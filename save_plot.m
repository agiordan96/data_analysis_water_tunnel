function [] = save_plot(gcf, plot_type, plot_variable, j, speed, format)
% Saving plots in desired folder

if length(plot_type) == 5 && plot_type == 'title'
    saveas(gcf, ['./pictures_wing/pic_hardwing/', date, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
else
    saveas(gcf, ['./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);

end

