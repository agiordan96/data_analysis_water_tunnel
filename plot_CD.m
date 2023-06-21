function [] = plot_CD(exp_value, sel_speed, div, chord, kin_viscosity, drag_dir, plot_type, format)
    
    plot_variable = 'CD';
    plot_variable_printed_name = 'C_{D}';

    for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
    
        Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
        disp(sel_speed(j))
             
        figure('Position', [200, 200, 1000, 1000])
        
        if plot_type == "title"
            title([plot_variable_printed_name, ' plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
        end

        hold on
        grid on
        xlabel('AoA [ ˚ ]','fontweight','bold','fontsize', 30);
        ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 30);
        ax = gca;
        ax.XAxis.LineWidth = 2;
        ax.YAxis.LineWidth = 2;
        xlim([-10 30])
        ylim([-1.3 2])
    
        clear k1

        for k = 1:length(exp_value.f_avg)
    
             if (exp_value.vel(k) == sel_speed(j))
                if exist('k1','var') == 0
                    errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(1, j)), exp_value.f_std(k, drag_dir) / div(1, j), 'ob', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                else
                    errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(1, j)), exp_value.f_std(k, drag_dir) / div(1, j), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                    x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                    y_vec = [(-exp_value.f_avg(k1, drag_dir) / div(1, j)), (-exp_value.f_avg(k, drag_dir) / div(1, j))];
                    plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
                end
                k1 = k;
             end
        end

        str_annotation = sprintf('Re = %.2e', Re);
        annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
        hold off
        save_plot(gcf, plot_type, plot_variable, j, sel_speed(j), format)
    end

end