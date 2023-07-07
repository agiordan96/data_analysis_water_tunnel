function [] = save_plot(gcf, wingtype, plot_type, plot_variable, j, speed, format)
% Saving plots in desired folder

    if wingtype == "hard"
        if length(plot_type) == 5 && plot_type == "title"
            saveas(gcf, ['./pictures_wing/pic_hardwing/', date, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
        
        elseif length(plot_type) == 7 && plot_type == "fourier"
            saveas(gcf, ['./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_', num2str(j), '_deg_flow_speed_0_', num2str(speed)], format);
        else
            saveas(gcf, ['./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
        
        end

    elseif wingtype == "soft"
        if length(plot_type) == 5 && plot_type == "title"
            saveas(gcf, ['./pictures_wing/pic_softwing/', date, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
        
        elseif length(plot_type) == 7 && plot_type == "fourier"
            saveas(gcf, ['./pictures_wing/pic_softwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_', num2str(j), '_deg_flow_speed_0_', num2str(speed)], format);
        else
            saveas(gcf, ['./pictures_wing/pic_softwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
        
        end

    elseif wingtype == "soft_hard"
        if length(plot_type) == 5 && plot_type == "title"
            saveas(gcf, ['./pictures_wing/pic_softhardwing/', date, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
        
        elseif length(plot_type) == 7 && plot_type == "fourier"
            saveas(gcf, ['./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_', num2str(j), '_deg_flow_speed_0_', num2str(speed)], format);
        else
            saveas(gcf, ['./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', plot_variable, '_plot/', plot_variable, '_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * speed)], format);
        
        end
    end

end

