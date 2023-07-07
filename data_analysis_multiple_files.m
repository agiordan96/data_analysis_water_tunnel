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

% default values in case of repeated experiment (for user's agility only)

sensor_orientation = struct; 

promptdrag = "Enter drag direction\n";
sensor_orientation.drag_dir = (input(promptdrag, 's'));

if sensor_orientation.drag_dir == "" 
    sensor_orientation.drag_dir = 2;    % enter default value here
    fprintf('-> going for default value: drag_dir = %d\n', sensor_orientation.drag_dir); 
end

promptlift = "Enter lift direction\n";
sensor_orientation.lift_dir = (input(promptlift, 's'));

if sensor_orientation.lift_dir == "" 
    sensor_orientation.lift_dir = 1;    % enter default value here
    fprintf('-> going for default value: lift_dir = %d\n', sensor_orientation.lift_dir); 
end

promptlat = "Enter lat direction\n";
sensor_orientation.lat_dir = (input(promptlat, 's'));

if sensor_orientation.lat_dir == "" 
    sensor_orientation.lat_dir = 3;     % enter default value here
    fprintf('-> going for default value: lat_dir = %d\n', sensor_orientation.lat_dir); 
end

%% data folder names acquisition

fprintf('\n')
prompt = "Enter soft wing data directory's name\n";
MyFolderSoft = (input(prompt, "s"));

% default data in case of repeated experiment (for user's agility only)

if MyFolderSoft == "" 
    MyFolderSoft = "soft_data_05072023";   % enter default value here
    fprintf('-> going for default value: data directory "%s"\n', MyFolderSoft); 
end

fprintf('\n')
prompt = "Enter rigid wing data directory's name\n";
MyFolderHard = (input(prompt, "s"));

% default data in case of repeated experiment (for user's agility only)

if MyFolderHard == "" 
    MyFolderHard = "hard_data_05072023";   % enter default value here
    fprintf('-> going for default value: data directory "%s"\n', MyFolderHard); 
end

% prompt = "Enter chord length data file name\n";
% MyFileChord = (input(prompt, "s"));

% default data in case of repeated experiment (for user's agility only)

% if MyFileChord == "" 
%     MyFileChord = "chord_length";   % enter default value here
%     fprintf('-> going for default value: data directory "%s"\n', MyFileChord); 
% end

MyFolderInfoSoft = dir(MyFolderSoft);   % directory information and file names for soft data
MyFolderInfoHard = dir(MyFolderHard);   % directory information and file names for hard data

%% variables initiation

exp_value_soft  = struct;

exp_value_soft.f_avg = zeros(length(MyFolderInfoSoft), 3);
exp_value_soft.f_std = zeros(length(MyFolderInfoSoft), 3);
exp_value_soft.f_ratio = zeros(length(MyFolderInfoSoft), 1);
exp_value_soft.f_std_ratio = zeros(length(MyFolderInfoSoft), 1);
exp_value_soft.t_avg = zeros(length(MyFolderInfoSoft), 3);
exp_value_soft.t_std = zeros(length(MyFolderInfoSoft), 3);
exp_value_soft.aoa = zeros(length(MyFolderInfoSoft), 1);
exp_value_soft.vel = zeros(length(MyFolderInfoSoft), 1);
exp_value_soft.inflation = zeros(length(MyFolderInfoSoft), 1);
%exp_value_soft.chord = zeros(length(MyFolderInfo), 1);   % chord length file must have ordered data to reflect that of force value data

exp_value_hard = struct;

exp_value_hard.f_avg = zeros(length(MyFolderInfoSoft), 3);
exp_value_hard.f_std = zeros(length(MyFolderInfoSoft), 3);
exp_value_hard.f_ratio = zeros(length(MyFolderInfoSoft), 1);
exp_value_hard.f_std_ratio = zeros(length(MyFolderInfoSoft), 1);
exp_value_hard.t_avg = zeros(length(MyFolderInfoSoft), 3);
exp_value_hard.t_std = zeros(length(MyFolderInfoSoft), 3);
exp_value_hard.aoa = zeros(length(MyFolderInfoSoft), 1);
exp_value_hard.vel = zeros(length(MyFolderInfoSoft), 1);
exp_value_hard.inflation = zeros(length(MyFolderInfoSoft), 1);
%exp_value_hard.chord = zeros(length(MyFolderInfo), 1);   % chord length file must have ordered data to reflect that of force value data

fprintf('\nVariables allocated successfully\n\n'); 

%% soft data read 

for k = 1:length(MyFolderInfoSoft) 

    if length(MyFolderInfoSoft(k).name) < 4
        continue
    end

    if MyFolderInfoSoft(k).name(1:4) ~= "soft"   % skip files that are not soft
        continue
    end

    exp_table = readtable(MyFolder + "/" + MyFolderInfoSoft(k).name, 'Delimiter', ', ', "Range", "D:I");
    %chord_table = readtable("./" + MyFileChord, 'Delimiter', ', ', "Range", "A:A");

    exp_value_soft.f_avg(k, :) = mean(exp_table{1:end, 1:3});  % average force vector for all of wing's config.
    exp_value_soft.f_std(k, :) = std(exp_table{1:end, 1:3});   % standard dev for each force component of every wing config.
    
    exp_value_soft.f_ratio(k, 1) = mean(exp_table{1:end, sensor_orientation.lift_dir} ./ exp_table{1:end, sensor_orientation.drag_dir});
    exp_value_soft.f_std_ratio(k, 1) = std(exp_table{1:end, sensor_orientation.lift_dir} ./ exp_table{1:end, sensor_orientation.drag_dir});

    exp_value_soft.t_avg(k, :) = mean(exp_table{1:end, 4:6}); % average torque vector for all of wing's config.
    exp_value_soft.t_std(k, :) = std(exp_table{1:end, 4:6});  % standard deviation for each torque component of every wing config.

    exp_value_soft.wingtype(k, 1) = string(MyFolderInfoSoft(k).name(1:4)); % wing type.

    if MyFolderInfoSoft(k).name(6:9) == "zero"  % wing angle of attack discrimination (char and int) --> lines 58 to 66
        exp_value_soft.aoa(k) = 0;
    elseif MyFolderInfoSoft(k).name(6:9) == "-005"
        exp_value_soft.aoa(k) = -5;
    elseif MyFolderInfoSoft(k).name(6:9) == "neg5"
        exp_value_soft.aoa(k) = -5;    
    elseif MyFolderInfoSoft(k).name(6:9) == "pos5"
        exp_value_soft.aoa(k) = 5;
    elseif MyFolderInfoSoft(k).name(6:9) == "0007"
        exp_value_soft.aoa(k) = 7.5;  
    elseif MyFolderInfoSoft(k).name(6:9) == "0012"
        exp_value_soft.aoa(k) = 12.5;
    else
        exp_value_soft.aoa(k) = str2double(MyFolderInfoSoft(k).name(8:9));
    end

%     if MyFolderInfo(k).name(6:9) == "0010" && MyFolderInfo(k).name(14:15) == "40"
%         %fourier_transform_signal(exp_table,  sensor_orientation.lift_dir);
%         fourier(exp_table,  sensor_orientation.lift_dir);
%     end
% 
%     if MyFolderInfo(k).name(6:9) == "0025" && MyFolderInfo(k).name(14:15) == "30"
%         %fourier_transform_signal(exp_table,  sensor_orientation.lift_dir);
%         fourier(exp_table,  sensor_orientation.lift_dir);
%     end
% 
%     if MyFolderInfo(k).name(6:9) == "0010" && MyFolderInfo(k).name(14:15) == "30"
%         %fourier_transform_signal(exp_table,  sensor_orientation.lift_dir);
%         fourier(exp_table,  sensor_orientation.lift_dir, str2double(MyFolderInfo(k).name(6:9)), str2double(MyFolderInfo(k).name(14:15)));
%     end

    exp_value_soft.vel(k) = str2double(MyFolderInfoSoft(k).name(14:15)) / 100;   % flow velocity (m/s)
    exp_value_soft.inflation(k) = str2double(MyFolderInfoSoft(k).name(19:21));   % wing inflation

end

% fourier_transform_signal(exp_value_soft, 10, 0.4, sensor_orientation.lift_dir);

remove = (exp_value_soft.f_avg(:, 1) == 0);

fields = fieldnames(exp_value_soft);
for k = 1:numel(fields)
    exp_value_soft.(fields{k})(remove, :) = [];
end

clear exp_table

%% hard data read 

fprintf('%d hard data files read successfully\n', length(exp_value_soft.aoa));  

for k = 1:length(MyFolderInfoHard) 

    if length(MyFolderInfoHard(k).name) < 4
        continue
    end

    if MyFolderInfoHard(k).name(1:4) ~= "hard"   % skip files that are not hard
        continue
    end

    exp_table = readtable(MyFolder + "/" + MyFolderInfoHard(k).name, 'Delimiter', ', ', "Range", "D:I");
    %chord_table = readtable("./" + MyFileChord, 'Delimiter', ', ', "Range", "A:A");

    exp_value_hard.f_avg(k, :) = mean(exp_table{1:end, 1:3});  % average force vector for all of wing's config.
    exp_value_hard.f_std(k, :) = std(exp_table{1:end, 1:3});   % standard dev for each force component of every wing config.
    
    exp_value_hard.f_ratio(k, 1) = mean(exp_table{1:end, sensor_orientation.lift_dir} ./ exp_table{1:end, sensor_orientation.drag_dir});
    exp_value_hard.f_std_ratio(k, 1) = std(exp_table{1:end, sensor_orientation.lift_dir} ./ exp_table{1:end, sensor_orientation.drag_dir});

    exp_value_hard.t_avg(k, :) = mean(exp_table{1:end, 4:6}); % average torque vector for all of wing's config.
    exp_value_hard.t_std(k, :) = std(exp_table{1:end, 4:6});  % standard deviation for each torque component of every wing config.

    exp_value_hard.wingtype(k, 1) = string(MyFolderInfoSoft(k).name(1:4)); % wing type.

    if MyFolderInfoSoft(k).name(6:9) == "zero"  % wing angle of attack discrimination (char and int) --> lines 58 to 66
        exp_value_hard.aoa(k) = 0;
    elseif MyFolderInfoSoft(k).name(6:9) == "-005"
        exp_value_hard.aoa(k) = -5;
    elseif MyFolderInfoSoft(k).name(6:9) == "neg5"
        exp_value_soft.aoa(k) = -5;  
    elseif MyFolderInfoSoft(k).name(6:9) == "pos5"
        exp_value_hard.aoa(k) = 5;
    elseif MyFolderInfoSoft(k).name(6:9) == "0007"
        exp_value_hard.aoa(k) = 7.5;  
    elseif MyFolderInfoSoft(k).name(6:9) == "0012"
        exp_value_hard.aoa(k) = 12.5;
    else
        exp_value_hard.aoa(k) = str2double(MyFolderInfoSoft(k).name(8:9));
    end

%     if MyFolderInfo(k).name(6:9) == "0010" && MyFolderInfo(k).name(14:15) == "40"
%         %fourier_transform_signal(exp_table,  sensor_orientation.lift_dir);
%         fourier(exp_table,  sensor_orientation.lift_dir);
%     end
% 
%     if MyFolderInfo(k).name(6:9) == "0025" && MyFolderInfo(k).name(14:15) == "30"
%         %fourier_transform_signal(exp_table,  sensor_orientation.lift_dir);
%         fourier(exp_table,  sensor_orientation.lift_dir);
%     end
% 
%     if MyFolderInfo(k).name(6:9) == "0010" && MyFolderInfo(k).name(14:15) == "30"
%         %fourier_transform_signal(exp_table,  sensor_orientation.lift_dir);
%         fourier(exp_table,  sensor_orientation.lift_dir, str2double(MyFolderInfo(k).name(6:9)), str2double(MyFolderInfo(k).name(14:15)));
%     end

    exp_value_hard.vel(k) = str2double(MyFolderInfoSoft(k).name(14:15)) / 100;   % flow velocity (m/s)
    exp_value_hard.inflation(k) = str2double(MyFolderInfoSoft(k).name(19:21));   % wing inflation

end

% fourier_transform_signal(exp_value_hard, 10, 0.4, sensor_orientation.lift_dir);

remove = (exp_value_hard.f_avg(:, 1) == 0);

fields = fieldnames(exp_value_hard);
for k = 1:numel(fields)
    exp_value_hard.(fields{k})(remove, :) = [];
end

clear exp_table

fprintf('%d files read successfully\n', length(exp_value_hard.aoa)); 

fprintf('\ndata read completed\n'); 

%% soft data sorting

T = struct2table(exp_value_soft); % convert the struct array to a table
sortedT = sortrows(T, 'aoa'); % sort the table by 'aoa'
exp_value_soft = table2struct(sortedT,'ToScalar',true); % convert the table back to the struct array

clear T sortedT

fprintf('\n soft data sorting completed')

%% soft data sorting

T = struct2table(exp_value_hard); % convert the struct array to a table
sortedT = sortrows(T, 'aoa'); % sort the table by 'aoa'
exp_value_hard = table2struct(sortedT,'ToScalar',true); % convert the table back to the struct array

clear T sortedT

fprintf('\n hard data sorting completed')

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

tor_transposed_soft = zeros(length(exp_value_soft.t_avg), 3);
tor_transposed_soft(1:end, 1:3) = exp_value_soft.t_avg(1:end, 1:3) + exp_value_soft.f_avg(1:end, 1:3) * d;

tor_transposed_hard = zeros(length(exp_value_hard.t_avg), 3);
tor_transposed_hard(1:end, 1:3) = exp_value_hard.t_avg(1:end, 1:3) + exp_value_hard.f_avg(1:end, 1:3) * d;

fprintf('\n data processing completed')

%% data visualization init.

close all
format short

sel_speed = [.10, .15, .20, .25, .30, .40];
sel_inflation = [0, 30, 60, 90, 120];

dyn_pressure = 0.5 * rho .* sel_speed .^ 2; % vector, calculation of dynamic pressure
div = dyn_pressure .* S; % matrix leading to aero coefficients. Rows: inflations. Column: speeds.

% if exp_value_soft.wingtype(1, 1:4) == "hard"
%     plot_hard_wing(exp_value_soft.wingtype(1, 1:4), exp_value_soft, sel_speed, div, chord, kin_viscosity, sensor_orientation);
% end

%plot_soft_wing(exp_value_soft.wingtype(1, 1:4), exp_value_soft, sel_speed, sel_inflation, div, chord, kin_viscosity, sensor_orientation);
plot_soft_wing(exp_value_soft.wingtype(1), exp_value_soft, sel_speed, sel_inflation, div, chord, kin_viscosity, sensor_orientation);

plot_hard_wing(exp_value_hard.wingtype(1, 1:4), exp_value_hard, sel_speed, div, chord, kin_viscosity, sensor_orientation);

% if exp_value_soft.wingtype(1, 1:4) == "soft"
%     plot_soft_wing(exp_value_soft.wingtype(1, 1:4), exp_value_soft, sel_speed, sel_inflation, div, chord, kin_viscosity, sensor_orientation);
% end