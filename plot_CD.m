function [] = plot_CD(wingtype, sel_inflation, exp_value, exp_value_hard, sel_speed, div, chord, kin_viscosity, drag_dir, plot_type, format)
    
    plot_variable = 'CD';
    plot_variable_printed_name = 'C_{D}';

    if wingtype == "hard"

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
            ax.XAxis.TickValues = [-5 0 5 7.5 10 12.5 15];
            xlim([-7.5 17.5])
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
            save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)

            disp(sel_speed(j))
        end
    
    elseif wingtype == "soft"

        for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
        
            %Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
            disp(sel_speed(j))
            clear k1 k2 k3 k4 k5
        
            figure('Position', [200, 200, 1000, 1000])
        
            if plot_type == "title"
                title([plot_variable_printed_name, ' plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
            end
            
            legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
            hold on
            grid on
            xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
            ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 30);
            ax = gca;
            ax.XAxis.TickValues = [-5 0 5 7.5 10 12.5 15];
            xlim([-7.5 17.5])
            ylim([-.1 1.1])
            ax.XAxis.LineWidth = 2;
            ax.YAxis.LineWidth = 2;
        
            for k = 1:length(exp_value.f_avg)
        
                 if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
                    if exist('k1','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(1, j)), exp_value.f_std(k, drag_dir) / div(1, j), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(1, j)), exp_value.f_std(k, drag_dir) / div(1, j), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
                        x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k1, drag_dir) / div(1, j)), (-exp_value.f_avg(k, drag_dir) / div(1, j))];
                        plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
                    end
                    k1 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
                     if exist('k2','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(2, j)), exp_value.f_std(k, drag_dir) / div(2, j), 'ok', 'DisplayName', '30 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(2, j)), exp_value.f_std(k, drag_dir) / div(2, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                        x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k2, drag_dir)  / div(2, j)), (-exp_value.f_avg(k, drag_dir) / div(2, j))];
                        plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
                    end
                    k2 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
                     if exist('k3','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(3, j)), exp_value.f_std(k, drag_dir) / div(3, j), 'om', 'DisplayName', '60 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(3, j)), exp_value.f_std(k, drag_dir) / div(3, j), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                        x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k3, drag_dir) / div(3, j)), (-exp_value.f_avg(k, drag_dir) / div(3, j))];
                        plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
                    end
                    k3 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
                     if exist('k4','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(4, j)), exp_value.f_std(k, drag_dir) / div(4, j), 'ob', 'DisplayName', '90 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(4, j)), exp_value.f_std(k, drag_dir) / div(4, j), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                        x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k4, drag_dir) / div(4, j)), (-exp_value.f_avg(k, drag_dir) / div(4, j))];
                        plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
                    end
                    k4 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
                     if exist('k5','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(5, j)), exp_value.f_std(k, drag_dir) / div(5, j), 'og', 'DisplayName', '120 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(5, j)), exp_value.f_std(k, drag_dir) / div(5, j), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                        x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k5, drag_dir) / div(5, j)), (-exp_value.f_avg(k, drag_dir) / div(5, j))];
                        plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
                    end
                    k5 = k; 
                 end
            end
            
            hold off
            %saveas(gcf, ['./pic_notitle_paper/CD_plot/','/CD_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
            %saveas(gcf, ['./pic/CD_plot/','/CD_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
            save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)

        end


    elseif wingtype == "soft_hard"

        for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
        
            %Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
            disp(sel_speed(j))
            clear k1 k2 k3 k4 k5 hard1
        
            figure('Position', [200, 200, 1000, 1000])
            set(gcf, 'Position', [440 378 1240 840])
        
            if plot_type == "title"
                title([plot_variable_printed_name, ' plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
            end
            
            legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
            hold on
            grid on
            xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
            ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 30);
            ax = gca;
            ax.XAxis.TickValues = [-5 0 5 7.5 10 12.5 15];
            xlim([-7.5 17.5])
            ylim([-.1 1.08])
            ax.XAxis.LineWidth = 2;
            ax.YAxis.LineWidth = 2;
        
            for k = 1:length(exp_value.f_avg)

                if k <= length(exp_value_hard.vel)
                    if (exp_value_hard.vel(k) == sel_speed(j))
                        if exist('hard1','var') == 0
                            errorbar(exp_value_hard.aoa(k), (-exp_value_hard.f_avg(k, drag_dir) / div(1, j)), exp_value_hard.f_std(k, drag_dir) / div(1, j), 'ok', 'DisplayName', '(solid) rigid', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                        else
                            errorbar(exp_value_hard.aoa(k), (-exp_value_hard.f_avg(k, drag_dir) / div(1, j)), exp_value_hard.f_std(k, drag_dir) / div(1, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                            x_vec = [exp_value_hard.aoa(hard1), exp_value_hard.aoa(k)];
                            y_vec = [(-exp_value_hard.f_avg(hard1, drag_dir) / div(1, j)), (-exp_value_hard.f_avg(k, drag_dir) / div(1, j))];
                            plot(x_vec, y_vec, 'k', 'HandleVisibility', 'off')
                        end
                        hard1 = k;
                     end
                end
        
                 if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
                    if exist('k1','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(1, j)), exp_value.f_std(k, drag_dir) / div(1, j), 'ok', 'DisplayName', '(dotted) neutral', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(1, j)), exp_value.f_std(k, drag_dir) / div(1, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                        x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k1, drag_dir) / div(1, j)), (-exp_value.f_avg(k, drag_dir) / div(1, j))];
                        plot(x_vec, y_vec, ':k', 'HandleVisibility','off')
                    end
                    k1 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
                     if exist('k2','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(2, j)), exp_value.f_std(k, drag_dir) / div(2, j), 'oc', 'DisplayName', '30 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'c', 'LineWidth', 1, MarkerEdgeColor = 'cyan')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(2, j)), exp_value.f_std(k, drag_dir) / div(2, j), 'oc', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'c', 'LineWidth', 1, MarkerEdgeColor = 'cyan')
                        x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k2, drag_dir)  / div(2, j)), (-exp_value.f_avg(k, drag_dir) / div(2, j))];
                        plot(x_vec, y_vec, ':c', 'HandleVisibility','off')
                    end
                    k2 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
                     if exist('k3','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(3, j)), exp_value.f_std(k, drag_dir) / div(3, j), 'om', 'DisplayName', '60 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(3, j)), exp_value.f_std(k, drag_dir) / div(3, j), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                        x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k3, drag_dir) / div(3, j)), (-exp_value.f_avg(k, drag_dir) / div(3, j))];
                        plot(x_vec, y_vec, ':m', 'HandleVisibility','off')
                    end
                    k3 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
                     if exist('k4','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(4, j)), exp_value.f_std(k, drag_dir) / div(4, j), 'ob', 'DisplayName', '90 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(4, j)), exp_value.f_std(k, drag_dir) / div(4, j), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                        x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k4, drag_dir) / div(4, j)), (-exp_value.f_avg(k, drag_dir) / div(4, j))];
                        plot(x_vec, y_vec, ':b', 'HandleVisibility','off')
                    end
                    k4 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
                     if exist('k5','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(5, j)), exp_value.f_std(k, drag_dir) / div(5, j), 'og', 'DisplayName', '120 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(5, j)), exp_value.f_std(k, drag_dir) / div(5, j), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                        x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k5, drag_dir) / div(5, j)), (-exp_value.f_avg(k, drag_dir) / div(5, j))];
                        plot(x_vec, y_vec, ':g', 'HandleVisibility','off')
                    end
                    k5 = k; 
                 end
            end
            
            hold off
            %saveas(gcf, ['./pic_notitle_paper/CD_plot/','/CD_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
            %saveas(gcf, ['./pic/CD_plot/','/CD_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
            save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)

        end

    end
    
%     close all
end