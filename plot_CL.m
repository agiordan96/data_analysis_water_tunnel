function [] = plot_CL(wingtype, sel_inflation, sel_inflation_double, exp_value, exp_value_hard, exp_value_double, sel_speed, div, chord, kin_viscosity, lift_dir, plot_type, format)
    
    plot_variable = 'CL';
    plot_variable_printed_name = 'C_{L}';
    double_vel = 0.25;

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
            ax.XAxis.TickValues = [-5 0 5 7.5 10 12.5 15];
            xlim([-7.5 17.5])
            ylim([-1.3 2])
        
            clear k1
    
            for k = 1:length(exp_value.f_avg)
        
                 if (exp_value.vel(k) == sel_speed(j))
                    if exist('k1','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'ob', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                        x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k1, lift_dir) / div(1, j)), (-exp_value.f_avg(k, lift_dir) / div(1, j))];
                        plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
                    end
                    k1 = k;
                 end
            end
    
            %str_annotation = sprintf('Re = %.2e', Re);
            %annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
            hold off
            save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)
        end

    elseif wingtype == "soft"

        for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots

            Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
            fprintf('plotting for Re = %.2d (vel = %.2d m/s) \n', Re, sel_speed(j))
            
            clear k1 k2 k3 k4 k5
            
            figure('Position', [200, 200, 1000, 1000])
        
            if plot_type == "title"
                title([plot_variable_printed_name, ' plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
            end

            legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
            hold on
            grid on
            ax.FontSize = 100;
            xlabel('AoA [ ˚ ]','fontweight','bold','fontsize', 30);
            ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 30);
            ax = gca;
            ax.XAxis.LineWidth = 2;
            ax.YAxis.LineWidth = 2;
            ax.XAxis.TickValues = [-5 0 5 7.5 10 12.5 15];
            xlim([-7.5 17.5])
            ylim([-0.5 2.6])
        
            for k = 1:length(exp_value.f_avg)
        
                 if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
                    if exist('k1','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'ok', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                        x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k1, lift_dir) / div(1, j)), (-exp_value.f_avg(k, lift_dir) / div(1, j))];
                        plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
                    end
                    k1 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
                     if exist('k2','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(2, j)), exp_value.f_std(k, lift_dir) / div(2, j), 'ok', 'DisplayName', '30 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(2, j)), exp_value.f_std(k, lift_dir) / div(2, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                        x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k2, lift_dir) / div(2, j)), (-exp_value.f_avg(k, lift_dir) / div(2, j))];
                        plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
                    end
                    k2 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
                     if exist('k3','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(3, j)), exp_value.f_std(k, lift_dir) / div(3, j), 'om', 'DisplayName', '60 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(3, j)), exp_value.f_std(k, lift_dir) / div(3, j), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                        x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k3, lift_dir) / div(3, j)), (-exp_value.f_avg(k, lift_dir) / div(3, j))];
                        plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
                    end
                    k3 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
                     if exist('k4','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(4, j)), exp_value.f_std(k, lift_dir) / div(4, j), 'ob', 'DisplayName', '90 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(4, j)), exp_value.f_std(k, lift_dir) / div(4, j), 'ob', 'HandleVisibility','off','CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                        x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k4, lift_dir) / div(4, j)), (-exp_value.f_avg(k, lift_dir) / div(4, j))];
                        plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
                    end
                    k4 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
                    if exist('k5','var') == 0 
                     errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(5, j)), exp_value.f_std(k, lift_dir) / div(5, j), 'og', 'DisplayName', '120 mL inf.', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(5, j)), exp_value.f_std(k, lift_dir) / div(5, j), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
                        x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k5, lift_dir) / div(5, j)), (-exp_value.f_avg(k, lift_dir) / div(5, j))];
                        plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
                    end
                    k5 = k;
                 end
            end
            
            %str_annotation = sprintf('Re = %.2e', Re);
            %annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, ...
            % 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex') % printing Re on plots
            hold off
            % saveas(gcf, ['./pic_notitle_paper/CL_plot/', 'CL_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
            % saveas(gcf, ['./pic/CL_plot/', 'CL_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
            save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)
        end

    elseif wingtype == "soft_hard"
        
        for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots

            Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
            fprintf('plotting for Re = %.2d (vel = %.2d m/s) \n', Re, sel_speed(j))
            
            clear k1 k2 k3 k4 k5 hard1
            
            figure('Position', [200, 200, 1000, 1000])
            set(gcf, 'InnerPosition', [1, 1, 1440, 800])
            set(gcf, 'OuterPosition', [1, 1, 1440, 880])

        
            if plot_type == "title"
                title([plot_variable_printed_name, ' plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
            end

            legend('Location','north','Orientation','horizontal','fontsize', 50, 'LineWidth', 2)
            hold on
            grid on
            ax.FontSize = 50;
            xlabel('AoA [ ˚ ]','fontweight','bold','fontsize', 50);
            ylabel(strcat(plot_variable_printed_name, ' [ ]'),'fontweight','bold','fontsize', 50);
            ax = gca;
            ax.XAxis.LineWidth = 2;
            ax.YAxis.LineWidth = 2;
            ax.XAxis.TickValues = [-5 0 5 7.5 10 12.5 15];
            xlim([-7.5 17.5])
            ylim([-1.3 2.6])
            ax.InnerPosition = ([0.084,0.1093,0.8771,0.8116]);
        
            for k = 1:length(exp_value.f_avg)

                if k <= length(exp_value_hard.vel)
                    if (exp_value_hard.vel(k) == sel_speed(j))
                        if exist('hard1','var') == 0
                            errorbar(exp_value_hard.aoa(k), (-exp_value_hard.f_avg(k, lift_dir) / div(1, j)), exp_value_hard.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'DisplayName', ' –– rigid', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor='#383B3E')
                        else
                            errorbar(exp_value_hard.aoa(k), (-exp_value_hard.f_avg(k, lift_dir) / div(1, j)), exp_value_hard.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor='#383B3E')
                            x_vec = [exp_value_hard.aoa(hard1), exp_value_hard.aoa(k)];
                            y_vec = [(-exp_value_hard.f_avg(hard1, lift_dir) / div(1, j)), (-exp_value_hard.f_avg(k, lift_dir) / div(1, j))];
                            plot(x_vec, y_vec, 'Color', '#383B3E', 'HandleVisibility', 'off')
                        end
                        hard1 = k;
                     end
                 end

%                if sel_speed(j) == double_vel 
%                         if k > length(exp_value_double.vel)
%                             continue
%                         end
%                       if exp_value_double.inflation(k) == sel_inflation_double(1)
%                        if exp_value_double.dir(k) == 1
%                             if exist('d1','var') == 0
%                                 errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(1, j)), exp_value_double.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'DisplayName', ' – – neutral', 'CapSize', 18,  'LineWidth', 1, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
%                             else
%                                 errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(1, j)), exp_value_double.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 1, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
%                                 x_vec = [exp_value_double.aoa(d1), exp_value_double.aoa(k)];
%                                 y_vec = [(-exp_value_double.f_avg(d1, lift_dir) / div(1, j)), (-exp_value_double.f_avg(k, lift_dir) / div(1, j))];
%                                 plot(x_vec, y_vec, '-.', 'Color', '#383B3E', 'HandleVisibility','off')
%                             end
%                             d1 = k;
%                         elseif exp_value_double.dir(k) == 0
%                              if exist('d1n','var') == 0
%                                 errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(1, j)), exp_value_double.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
%                              else
%                                 errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(1, j)), exp_value_double.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
%                                 x_vec = [exp_value_double.aoa(d1n), exp_value_double.aoa(k)];
%                                 y_vec = [(-exp_value_double.f_avg(d1n, lift_dir) / div(1, j)), (-exp_value_double.f_avg(k, lift_dir) / div(1, j))];
%                                 plot(x_vec, y_vec, '-.', 'Color', '#383B3E', 'HandleVisibility','off')
%                              end
%                             d1n = k;
%                         end
%                       elseif exp_value_double.inflation(k) == sel_inflation_double(2)
%                         if exp_value_double.dir(k) == 1
%                          if exist('d2','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#C9459A','DisplayName', '15 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#C9459A', MarkerEdgeColor = '#C9459A')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#C9459A','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#C9459A', MarkerEdgeColor = '#C9459A')
%                             x_vec = [exp_value_double.aoa(d2), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d2, lift_dir) / div(2, j)), (-exp_value_double.f_avg(k, lift_dir) / div(2, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#C9459A', 'HandleVisibility','off')
%                          end
%                         d2 = k;
%                         elseif exp_value_double.dir(k) == 0
%                          if exist('d2n','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#C9459A','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#C9459A', MarkerEdgeColor = '#C9459A')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#C9459A', 'HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#C9459A', MarkerEdgeColor = '#C9459A')
%                             x_vec = [exp_value_double.aoa(d2n), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d2n, lift_dir) / div(2, j)), (-exp_value_double.f_avg(k, lift_dir) / div(2, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#C9459A', 'HandleVisibility','off')
%                          end
%                         d2n = k;
%                        end
%     
%                      elseif exp_value_double.inflation(k) == sel_inflation_double(3) 
%                        if exp_value_double.dir(k) == 1 
%                          if exist('d3','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#BC3F02','DisplayName', '30 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#BC3F02', MarkerEdgeColor = '#BC3F02')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#BC3F02','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#BC3F02', MarkerEdgeColor = '#BC3F02')
%                             x_vec = [exp_value_double.aoa(d3), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d3, lift_dir) / div(2, j)), (-exp_value_double.f_avg(k, lift_dir) / div(2, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#BC3F02', 'HandleVisibility','off')
%                         end
%                         d3 = k;
%                        elseif exp_value_double.dir(k) == 0 
%                          if exist('d3n','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#BC3F02','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#BC3F02', MarkerEdgeColor = '#BC3F02')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#BC3F02','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#BC3F02', MarkerEdgeColor = '#BC3F02')
%                             x_vec = [exp_value_double.aoa(d3n), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d3n, lift_dir) / div(2, j)), (-exp_value_double.f_avg(k, lift_dir) / div(2, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#BC3F02', 'HandleVisibility','off')
%                         end
%                         d3n = k;
%                        end
%     
%                       elseif exp_value_double.inflation(k) == sel_inflation_double(4)
%                         if exp_value_double.dir(k) == 1
%                          if exist('d4','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#ED9B00','DisplayName', '45 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#ED9B00', MarkerEdgeColor = '#ED9B00')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#ED9B00','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#ED9B00', MarkerEdgeColor = '#ED9B00')
%                             x_vec = [exp_value_double.aoa(d4), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d4, lift_dir) / div(2, j)), (-exp_value_double.f_avg(k, lift_dir) / div(2, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#ED9B00', 'HandleVisibility','off')
%                          end
%                         d4 = k;
%                        elseif exp_value_double.dir(k) == 0
%                           if exist('d4n','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#ED9B00','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#ED9B00', MarkerEdgeColor = '#ED9B00')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(2, j)), exp_value_double.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#ED9B00','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#ED9B00', MarkerEdgeColor = '#ED9B00')
%                             x_vec = [exp_value_double.aoa(d4n), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d4n, lift_dir) / div(2, j)), (-exp_value_double.f_avg(k, lift_dir) / div(2, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#ED9B00', 'HandleVisibility','off')
%                          end
%                         d4n = k;
%                         end
%                      elseif exp_value_double.inflation(k) == sel_inflation_double(5)
%                        if exp_value_double.dir(k) == 1
%                          if exist('d5','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(3, j)), exp_value_double.f_std(k, lift_dir) / div(3, j), 'o', 'Color', '#E9D8A4','DisplayName', '60 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#E9D8A4', MarkerEdgeColor = '#E9D8A4')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(3, j)), exp_value_double.f_std(k, lift_dir) / div(3, j), 'o', 'Color', '#E9D8A4','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#E9D8A4', MarkerEdgeColor = '#E9D8A4')
%                             x_vec = [exp_value_double.aoa(d5), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d5, lift_dir) / div(3, j)), (-exp_value_double.f_avg(k, lift_dir) / div(3, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#E9D8A4', 'HandleVisibility','off')
%                         end
%                         d5 = k;
%                        elseif exp_value_double.dir(k) == 0
%                         if exist('d5n','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(3, j)), exp_value_double.f_std(k, lift_dir) / div(3, j), 'o', 'Color', '#E9D8A4','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#E9D8A4', MarkerEdgeColor = '#E9D8A4')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(3, j)), exp_value_double.f_std(k, lift_dir) / div(3, j), 'o', 'Color', '#E9D8A4','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#E9D8A4', MarkerEdgeColor = '#E9D8A4')
%                             x_vec = [exp_value_double.aoa(d5n), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d5n, lift_dir) / div(3, j)), (-exp_value_double.f_avg(k, lift_dir) / div(3, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#E9D8A4', 'HandleVisibility','off')
%                         end
%                         d5n = k;
%                        end
%                      elseif exp_value_double.inflation(k) == sel_inflation_double(6)
%                        if exp_value_double.dir(k) == 1
%                          if exist('d6','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(4, j)), exp_value_double.f_std(k, lift_dir) / div(4, j), 'o', 'Color', '#93D2BD','DisplayName', '90 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#93D2BD', MarkerEdgeColor = '#93D2BD')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(4, j)), exp_value_double.f_std(k, lift_dir) / div(4, j), 'o', 'Color', '#93D2BD','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#93D2BD', MarkerEdgeColor = '#93D2BD')
%                             x_vec = [exp_value_double.aoa(d6), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d6, lift_dir) / div(4, j)), (-exp_value_double.f_avg(k, lift_dir) / div(4, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#93D2BD', 'HandleVisibility','off')
%                         end
%                         d6 = k;
%                        elseif exp_value_double.dir(k) == 0
%                         if exist('d6n','var') == 0
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(4, j)), exp_value_double.f_std(k, lift_dir) / div(4, j), 'o', 'Color', '#93D2BD','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#93D2BD', MarkerEdgeColor = '#93D2BD')
%                          else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(4, j)), exp_value_double.f_std(k, lift_dir) / div(4, j), 'o', 'Color', '#93D2BD','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#93D2BD', MarkerEdgeColor = '#93D2BD')
%                             x_vec = [exp_value_double.aoa(d6n), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d6n, lift_dir) / div(4, j)), (-exp_value_double.f_avg(k, lift_dir) / div(4, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#93D2BD', 'HandleVisibility','off')
%                         end
%                         d6n = k;
%                        end
%                      elseif exp_value_double.inflation(k) == sel_inflation_double(7)
%                        if exp_value_double.dir(k) == 1
%                         if exist('d7','var') == 0 
%                          errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(5, j)), exp_value_double.f_std(k, lift_dir) / div(5, j), 'o', 'Color', '#005F73','DisplayName', '120 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#005F73', MarkerEdgeColor = '#005F73')
%                         else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(5, j)), exp_value_double.f_std(k, lift_dir) / div(5, j), 'o', 'Color', '#005F73','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#005F73', MarkerEdgeColor = '#005F73')
%                             x_vec = [exp_value_double.aoa(d7), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d7, lift_dir) / div(5, j)), (-exp_value_double.f_avg(k, lift_dir) / div(5, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#005F73', 'HandleVisibility','off')
%                         end
%                         d7 = k;
%                       elseif exp_value_double.dir(k) == 0
%                         if exist('d7n','var') == 0 
%                          errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(5, j)), exp_value_double.f_std(k, lift_dir) / div(5, j), 'o', 'Color', '#005F73','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#005F73', MarkerEdgeColor = '#005F73')
%                         else
%                             errorbar(exp_value_double.aoa(k), (-exp_value_double.f_avg(k, lift_dir) / div(5, j)), exp_value_double.f_std(k, lift_dir) / div(5, j), 'o', 'Color', '#005F73','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#005F73', MarkerEdgeColor = '#005F73')
%                             x_vec = [exp_value_double.aoa(d7n), exp_value_double.aoa(k)];
%                             y_vec = [(-exp_value_double.f_avg(d7n, lift_dir) / div(5, j)), (-exp_value_double.f_avg(k, lift_dir) / div(5, j))];
%                             plot(x_vec, y_vec, '-.', 'Color', '#005F73', 'HandleVisibility','off')
%                         end
%                         d7n = k;
%                       end
%                         
%                       end
% 
%                 else
                 if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
                    if exist('k1','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'DisplayName', ' – – neutral', 'CapSize', 18,  'LineWidth', 1, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'o', 'Color', '#383B3E', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 1, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
                        x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k1, lift_dir) / div(1, j)), (-exp_value.f_avg(k, lift_dir) / div(1, j))];
                        plot(x_vec, y_vec, '-.', 'Color', '#383B3E', 'HandleVisibility','off')
                    end
                    k1 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
                     if exist('k2','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(2, j)), exp_value.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#BC3F02','DisplayName', '30 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#BC3F02', MarkerEdgeColor = '#BC3F02')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(2, j)), exp_value.f_std(k, lift_dir) / div(2, j), 'o', 'Color', '#BC3F02','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#BC3F02', MarkerEdgeColor = '#BC3F02')
                        x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k2, lift_dir) / div(2, j)), (-exp_value.f_avg(k, lift_dir) / div(2, j))];
                        plot(x_vec, y_vec, '-.', 'Color', '#BC3F02', 'HandleVisibility','off')
                    end
                    k2 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
                     if exist('k3','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(3, j)), exp_value.f_std(k, lift_dir) / div(3, j), 'o', 'Color', '#E9D8A4','DisplayName', '60 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#E9D8A4', MarkerEdgeColor = '#E9D8A4')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(3, j)), exp_value.f_std(k, lift_dir) / div(3, j), 'o', 'Color', '#E9D8A4','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#E9D8A4', MarkerEdgeColor = '#E9D8A4')
                        x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k3, lift_dir) / div(3, j)), (-exp_value.f_avg(k, lift_dir) / div(3, j))];
                        plot(x_vec, y_vec, '-.', 'Color', '#E9D8A4', 'HandleVisibility','off')
                    end
                    k3 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
                     if exist('k4','var') == 0
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(4, j)), exp_value.f_std(k, lift_dir) / div(4, j), 'o', 'Color', '#93D2BD','DisplayName', '90 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#93D2BD', MarkerEdgeColor = '#93D2BD')
                     else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(4, j)), exp_value.f_std(k, lift_dir) / div(4, j), 'o', 'Color', '#93D2BD','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#93D2BD', MarkerEdgeColor = '#93D2BD')
                        x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k4, lift_dir) / div(4, j)), (-exp_value.f_avg(k, lift_dir) / div(4, j))];
                        plot(x_vec, y_vec, '-.', 'Color', '#93D2BD', 'HandleVisibility','off')
                    end
                    k4 = k;
                 elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
                    if exist('k5','var') == 0 
                     errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(5, j)), exp_value.f_std(k, lift_dir) / div(5, j), 'o', 'Color', '#005F73','DisplayName', '120 mL inf.', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#005F73', MarkerEdgeColor = '#005F73')
                    else
                        errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(5, j)), exp_value.f_std(k, lift_dir) / div(5, j), 'o', 'Color', '#005F73','HandleVisibility','off', 'CapSize', 18, 'LineWidth', 1, MarkerFaceColor = '#005F73', MarkerEdgeColor = '#005F73')
                        x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
                        y_vec = [(-exp_value.f_avg(k5, lift_dir) / div(5, j)), (-exp_value.f_avg(k, lift_dir) / div(5, j))];
                        plot(x_vec, y_vec, '-.', 'Color', '#005F73', 'HandleVisibility','off')
                    end
                    k5 = k;
                 end
            end
               
            
                % end
            %str_annotation = sprintf('Re = %.2e', Re);
            %annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, ...
            % 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex') % printing Re on plots
            hold off
            save_plot(gcf, wingtype, plot_type, plot_variable, j, sel_speed(j), format)
            
           
        end
    end
    

% close all
end
