function [] = plot_soft_hard_wing(wingtype, exp_value_soft, exp_value_hard, exp_value_double, sel_speed, sel_inflation, sel_inflation_double, div, chord, kin_viscosity, sensor_orientation)

% plots data relative to soft wing type. All inflations displayed.

%% Renaming variables for typing reasons

drag_dir = sensor_orientation.drag_dir;
lift_dir = sensor_orientation.lift_dir;
lat_dir = sensor_orientation.lat_dir;   

%% Plot choice to increase performance

CL_CD_prompt = "CL / CD plot: yes (1) or no (0)\n";
CL_prompt = "CL plot: yes (1) or no (0)\n";
CD_prompt = "CD plot: yes (1) or no (0)\n";
avCL_avCD_prompt = "average CL / average CD plot: yes (1) or no (0)\n";
medianCL_CD_prompt = "median CL / median CD plot: yes (1) or no (0)\n";

plot_type_prompt = "please type in <title> or <no_title>\n";

CL_CD_plot = (input(CL_CD_prompt, "s"));
CL_plot = (input(CL_prompt, "s"));
CD_plot = (input(CD_prompt, "s"));
avCL_avCD_plot = (input(avCL_avCD_prompt, "s"));
medianCL_CD_plot = (input(medianCL_CD_prompt, "s"));

plot_type = (input(plot_type_prompt, "s"));

if CL_CD_plot == "" 
    CL_CD_plot = 0;    % enter default value here
    fprintf('-> going for default value\n\n'); 
end

if CL_plot == "" 
   CL_plot = 1;    % enter default value here
   fprintf('-> going for default value\n\n'); 
end

if CD_plot == "" 
   CD_plot = 0;     % enter default value here
   fprintf('-> going for default value\n\n'); 
end

if avCL_avCD_plot == "" 
   avCL_avCD_plot = 0;     % enter default value here
   fprintf('-> going for default value\n\n'); 
end

if medianCL_CD_plot == "" 
   medianCL_CD_plot = 0;     % enter default value here
   fprintf('-> going for default value\n\n'); 
end

if plot_type == "" 
    plot_type = 'title';    % enter default value here
    fprintf('-> going for default value: plotting %s plot\n\n', plot_type); 
end

%% Saving folder creation

plot_choice_vec = [CL_CD_plot; CL_plot; CD_plot; avCL_avCD_plot; medianCL_CD_plot];
create_fold_save_pic(wingtype, plot_choice_vec, plot_type);

%% Plotting

if CL_CD_plot == 1
    plot_CLCD(wingtype, sel_inflation, exp_value_soft, exp_value_hard, exp_value_double, sel_speed, div, chord, kin_viscosity, plot_type, 'png', lift_dir, drag_dir);
end

if CL_plot == 1
    plot_CL(wingtype, sel_inflation, sel_inflation_double, exp_value_soft, exp_value_hard, exp_value_double, sel_speed, div, chord, kin_viscosity, lift_dir, plot_type, 'png');
end

if CD_plot == 1
    plot_CD(wingtype, sel_inflation, exp_value_soft, exp_value_hard, exp_value_double, sel_speed, div, chord, kin_viscosity, drag_dir, plot_type, 'png');
end

if avCL_avCD_plot == 1
    plot_avCLavCD(wingtype, sel_inflation, exp_value_soft, exp_value_hard, exp_value_double, sel_speed, div, chord, kin_viscosity, plot_type, 'png', lift_dir, drag_dir);
end

if medianCL_CD_plot == 1
    plot_medianCLCD(wingtype, sel_inflation, exp_value_soft, exp_value_hard, exp_value_double, sel_speed, div, chord, kin_viscosity, plot_type, 'png', lift_dir, drag_dir);
end



end