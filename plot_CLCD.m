function [] = plot_CLCD(wingtype, sel_inflation, exp_value, exp_value_hard, sel_speed, div, chord, kin_viscosity, plot_type, format, lift_dir, drag_dir)
    % prints average of forces ratios

    plot_variable = 'av_CL_CD';
    plot_variable_printed_name = 'C_{L} / C_{D}';

    if wingtype == "hard"

        for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
        
            Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
            fprintf('plotting for Re = %.2d (vel = %.2d m/s) \n', Re, sel_speed(j))
            
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
            %ylim([-1.3 2])
        
            clear k1
    
            for k = 1:length(exp_value.f_avg)
        
                 if (exp_value.vel(k) == sel_speed(j))
                    if exist('k1','var') == 0
                        errorbar(exp_value.aoa(k), -exp_value.f_ratio(k), exp_value.f_std_ratio(k), 'ob', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                    else
                        errorbar(exp_value.aoa(k), -exp_value.f_ratio(k), exp_value.f_std_ratio(k), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                        x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                        y_vec = [-exp_value.f_ratio(k1), -exp_value.f_ratio(k)];
                        plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
                    end
                    k1 = k;
                 end
            end
    
            str_annotation = sprintf('Re = %.2e', Re);
            annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
            hold off
            save_plot(wingtype, gcf, plot_type, plot_variable, j, sel_speed(j), format)
        end

  elseif wingtype == "soft"

    for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots

        Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
        fprintf('plotting for Re = %.2d (vel = %.2d m/s) \n', Re, sel_speed(j))
    
        clear k1 k2 k3 k4 k5
    
        figure('Position', [200, 200, 1000, 1000])
    
        if plot_type == "title"
            title(['CL / CD plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight', 'bold', 'fontsize', 24)
        end
    
        legend('Location','north','Orientation','horizontal','fontsize', 20)
        hold on
        grid on
        xlabel('AoA [ ˚ ]','fontweight','bold','fontsize', 30);
        ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 30);
        xlim([-10 35])
    
        for k = 1:length(exp_value.f_avg)
            if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
                if exist('k1','var') == 0
                            scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'or', 'DisplayName', 'neutral', 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
                else
                            scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'or', 'HandleVisibility','off', 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
                            x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                            plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
                 end
                 k1 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
                 if exist('k2','var') == 0
                 scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ok', 'DisplayName', 'inf. = 60 mL', 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
    
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 40,'ok', 'HandleVisibility','off', 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                    x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k2), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
                end
                k2 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
                 if exist('k3','var') == 0
                 scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18, 'om', 'DisplayName', 'inf. = 90 mL', 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18, 'om', 'HandleVisibility','off', 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                    x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k3), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
                end
                k3 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
                 if exist('k4','var') == 0
                 scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ob', 'DisplayName', 'inf. = 120 mL', 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ob', 'HandleVisibility','off', 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                    x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k4), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
                end
                k4 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
                 if exist('k5','var') == 0
                 scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'og', 'DisplayName', 'inf. = 30 mL', 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18, 'og', 'HandleVisibility','off', 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'green')
                    x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k5), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
                end
                k5 = k;
    
             end
         end
        
         %str_annotation = sprintf('Re = %.2e', Re);
         %annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
         hold off
         save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)
    
    end

  elseif wingtype == "soft_hard"

    for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
    
        Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
        fprintf('plotting for Re = %.2d (vel = %.2d m/s) \n', Re, sel_speed(j))
    
        clear k1 k2 k3 k4 k5 hard1
    
        figure('Position', [200, 200, 1000, 1000])
        set(gcf, 'Position', [440 378 1240 840])
    
        if plot_type == "title"
            title(['CL / CD plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight', 'bold', 'fontsize', 24)
        end
    
        legend('Location','north','Orientation','horizontal','fontsize', 20)
        hold on
        grid on
        xlabel('AoA [ ˚ ]','fontweight','bold','fontsize', 30);
        ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 30);
        xlim([-10 35])
        ylim([-31 25])
    
        for k = 1:length(exp_value.f_avg)

           if k <= length(exp_value_hard.vel)
                    if (exp_value_hard.vel(k) == sel_speed(j))
                        if exist('hard1','var') == 0
                            scatter(exp_value_hard.aoa(k), -exp_value_hard.f_ratio(k), 18, 'ok', 'DisplayName', '(solid) rigid', 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                        else
                            scatter(exp_value_hard.aoa(k), -exp_value_hard.f_ratio(k), 18, 'ok', 'HandleVisibility','off', 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                            x_vec = [exp_value_hard.aoa(hard1), exp_value_hard.aoa(k)];
                            y_vec = [-exp_value_hard.f_ratio(hard1), -exp_value_hard.f_ratio(k)];
                            plot(x_vec, y_vec, 'k', 'HandleVisibility', 'off')
                        end
                        hard1 = k;
                    end
            end

            if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
                if exist('k1','var') == 0
                            
                   scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ok', 'DisplayName', '(dotted) neutral', 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                else        
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ok', 'HandleVisibility','off', 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                    x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k1), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, ':k', 'HandleVisibility','off')
                 end
                 k1 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
                 if exist('k2','var') == 0
                  scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'oc', 'DisplayName', '30 mL inf.', 'MarkerFaceColor', 'c', 'LineWidth', 1, MarkerEdgeColor = 'cyan')
                 else
                  scatter(exp_value.aoa(k), exp_value.f_ratio(k), 40,'oc', 'HandleVisibility','off', 'MarkerFaceColor', 'c', 'LineWidth', 1, MarkerEdgeColor = 'cyan')       
                  x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                  y_vec = [exp_value.f_ratio(k2), exp_value.f_ratio(k)];
                  plot(x_vec, y_vec, ':c', 'HandleVisibility','off')
                end
                k2 = k;
   
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
                 if exist('k3','var') == 0
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18, 'om', 'DisplayName', '60 mL inf.', 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18, 'om', 'HandleVisibility','off', 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                    x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k3), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, ':m', 'HandleVisibility','off')
                end
                k3 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
                 if exist('k4','var') == 0
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ob', 'DisplayName', '90 mL inf.', 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue') 
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'ob', 'HandleVisibility','off', 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                    x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                    y_vec = [exp_value.f_ratio(k4), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, ':b', 'HandleVisibility','off')
                end
                k4 = k;
    
             elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
                 if exist('k5','var') == 0
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18,'og', 'DisplayName', '120 mL inf.', 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                 else
                    scatter(exp_value.aoa(k), exp_value.f_ratio(k), 18, 'og', 'HandleVisibility','off', 'MarkerFaceColor','g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                    x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];  
                    y_vec = [exp_value.f_ratio(k5), exp_value.f_ratio(k)];
                    plot(x_vec, y_vec, ':g', 'HandleVisibility','off')
                end
                k5 = k;
    
             end
        end
        
        %str_annotation = sprintf('Re = %.2e', Re);
        %annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
        hold off
        save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)
    
     end
    end
end