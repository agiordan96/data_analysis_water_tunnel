clc
clear variables
close all

format long

set(groot,'DefaultAxesFontSize', 24)
set(groot,'DefaultLineLineWidth',2.5)

%% sensor orientation

% to define sensor orientation, enter from keyboard what versor of the
% right-handed triad is the given force parallel to. 
% (1 --> X; 2 --> Y; 3--> Z)

sensor_orientation = struct; 

promptdrag = "Enter drag direction\n";
promptlift = "Enter lift direction\n";
promptlat = "Enter lat direction\n";

sensor_orientation.drag_dir = (input(promptdrag, 's'));
sensor_orientation.lift_dir = (input(promptlift, 's'));
sensor_orientation.lat_dir = (input(promptlat, 's'));

% default value in case of repeated experiment (for user's agility only)

if sensor_orientation.drag_dir == "" 
    sensor_orientation.drag_dir = 2;    % enter default value here
end

if sensor_orientation.lift_dir == "" 
    sensor_orientation.lift_dir = 1;    % enter default value here
end

if sensor_orientation.lat_dir == "" 
    sensor_orientation.lat_dir = 3;     % enter default value here
end

%% data reading

prompt = "Enter data directory's name\n";
MyFolder = (input(prompt, "s"));

% default data in case of repeated experiment (for user's agility only)

if MyFolder == "" 
    MyFolder = "force_torque_measurements";    % enter default value here force_torque_measurements
end

MyFolderInfo = dir(MyFolder);

exp_value  = struct;

exp_value.f_avg = zeros(length(MyFolderInfo), 3);
exp_value.f_std = zeros(length(MyFolderInfo), 3);
exp_value.t_avg = zeros(length(MyFolderInfo), 3);
exp_value.t_std = zeros(length(MyFolderInfo), 3);
exp_value.aoa = zeros(length(MyFolderInfo), 1);
exp_value.vel = zeros(length(MyFolderInfo), 1);
exp_value.inflation = zeros(length(MyFolderInfo), 1);

for k = 1:length(MyFolderInfo) 

    if length(MyFolderInfo(k).name) < 4
        continue
    end

    if MyFolderInfo(k).name(1:4) ~= "hard" && MyFolderInfo(k).name(1:4) ~= "soft"
        continue
    end

    exp_table = readtable(MyFolder + "/" + MyFolderInfo(k).name, 'Delimiter', ', ', "Range", "D:I");

    exp_value.f_avg(k, :) = mean(exp_table{1:end, 1:3});  % average force vector for all of wing's config.
    exp_value.f_std(k, :) = std(exp_table{1:end, 1:3});   % standard dev for each force component of every wing config.
    
    exp_value.f_ratio(k, :) = mean(exp_table{1:end, 1:3});

    exp_value.t_avg(k, :) = mean(exp_table{1:end, 4:6}); % average torque vector for all of wing's config.
    exp_value.t_std(k, :) = std(exp_table{1:end, 4:6});  % standard deviation for each torque component of every wing config.

    exp_value.wingtype(k, 1:4) = MyFolderInfo(k).name(1:4); % wing type.

    if MyFolderInfo(k).name(6:9) == "zero"  % wing angle of attack discrimination (char and int) --> lines 58 to 66
        exp_value.aoa(k) = 0;
    elseif MyFolderInfo(k).name(6:9) == "neg5"
        exp_value.aoa(k) = -5;
    elseif MyFolderInfo(k).name(6:9) == "pos5"
        exp_value.aoa(k) = 5;
    else
        exp_value.aoa(k) = str2double(MyFolderInfo(k).name(8:9));
    end

    exp_value.vel(k) = str2double(MyFolderInfo(k).name(14:15)) / 100;   % flow velocity (m/s)
    exp_value.inflation(k) = str2double(MyFolderInfo(k).name(19:21));   % wing inflation

end

remove = (exp_value.f_avg(:, 1) == 0);
fields = fieldnames(exp_value);
for k = 1:numel(fields)
    exp_value.(fields{k})(remove, :) = [];
end

clear exp_table

disp('data read complete')

%% data sorting

T = struct2table(exp_value); % convert the struct array to a table
sortedT = sortrows(T, 'aoa'); % sort the table by 'aoa'
exp_value = table2struct(sortedT,'ToScalar',true); % convert the table back to the struct array

clear T sortedT

disp('data sorting completed')

%% data processing

L = 1;

% given a reference frame, Sf(x_s, y_s, z_s) represents the force sensing point,
% whereas St(x_t, y_t, z_t) represents the torque sensing point.

% given a reference frame, T(x_t, y_t, z_t) represents the transposition
% point of forces and momenta

% d(x, y, z) = (dx; dy; dz) vector defining distance between force and moment sensing
% points and transposition point (one vector because force and momenta sensing
% points coincide)

% CL = L / (dynamic pressure * wing_surface)
% CD = D / (dynamic pressure * wing_surface)

x_s = 1;
y_s = 0;
z_s = L / 2;

x_t = 0;
y_t = 0;
z_t = 0;

dx = x_t - x_s;
dy = y_t - y_s;
dz = z_t - z_s;

d = [dx; dy; dz];

semi_wingspan_length = 0.368; % m; exclunding yellow cantilever spanning out from the support. Otherwise tot = 0.378 + 0.02575 [m]
S = semi_wingspan_length .* [0.160; 0.160; 0.160; 0.160; 0.160]; % m^2; reference surface for aerodynamic coefficients calculation is the projection of the semi-wing's area on the XZ plane
chord = 0.160+0.07; % m, measured visually from neutral configuration videos
rho = 998; % kg / m^3 density of water @ 20 C
dyn_viscosity = 10^(-3); % Pa * s
kin_viscosity = dyn_viscosity / rho; % m^2 * s

tor_transposed = zeros(length(exp_value.t_avg), 3);
tor_transposed(1:end, 1:3) = exp_value.t_avg(1:end, 1:3) + exp_value.f_avg(1:end, 1:3) * d;

disp('data processing completed')

%% data visualization init.

close all
format short

sel_speed = [.10, .15, .20, .25, .30, .40];
% sel_speed = [.10, .25];
sel_inflation = [0, 30, 60, 90, 120];

dyn_pressure = 0.5 * rho .* sel_speed .^ 2; % vector, calculation of dynamic pressure
div = dyn_pressure .* S; % matrix leading to aero coefficients. Rows: inflations. Column: speeds.

if exp_value.wingtype(1, 1:4) == "hard"
    plot_hard_wing(exp_value, sel_speed, div, chord, kin_viscosity, sensor_orientation);
end

if exp_value.wingtype(1, 1:4) == "soft"
    plot_soft_wing(exp_value, sel_speed, sel_inflation, div, chord, kin_viscosity, sensor_orientation);
end