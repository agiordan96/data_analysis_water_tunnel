function [] = plot_soft_wing(exp_value, sel_speed, sel_inflation, div, chord, kin_viscosity, sensor_orientation)
    
    % plots data relative to soft wing type. All inflations displayed.

%% Renaming variables for typing reasons

drag_dir = sensor_orientation.drag_dir;
lift_dir = sensor_orientation.lift_dir;
lat_dir = sensor_orientation.lat_dir;   

%% CL / CD: presenting one plot per selected speed and all inflations, against AoA

% threshold = 3000;
% 
% for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
% 
%     [status, msg, msgID] = mkdir('../pic/CL_over_CD_plot/'); % saving-folder creation
%     Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
%     disp(sel_speed(j))
% 
%     clear k1 k2 k3 k4 k5
% 
%     figure('Position', [200, 200, 1000, 1000])
% 
%     title(['CL / CD plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight', 'bold', 'fontsize', 24)
%     legend('Location','north','Orientation','horizontal','fontsize', 16)
%     hold on
%     grid on
%     xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
%     ylabel('CL / CD [ ]','fontweight','bold','fontsize', 30);
%     xlim([-10 35])
% 
%     for k = 1:length(exp_value.f_avg)
% 
%          if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) > threshold
%                  continue
%              end
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) < - threshold
%                  continue
%              end
% 
%             if exist('k1','var') == 0
%             errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%             else
%                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%                 x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
%                 y_vec = [exp_value.f_avg(k1, 2) / exp_value.f_avg(k1, 1), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)];
%                 plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
%             end
%             k1 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) > threshold
%                  continue
%              end
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) < - threshold
%                  continue
%              end
%              if exist('k2','var') == 0
%              errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
% 
%              else
%                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%                 x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
%                 y_vec = [exp_value.f_avg(k2, 2) / exp_value.f_avg(k2, 1), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)];
%                 plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
%             end
%             k2 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) > threshold
%                  continue
%              end
%             if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) < - threshold
%                  continue
%              end
%              if exist('k3','var') == 0
%              errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%              else
%                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%                 x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
%                 y_vec = [exp_value.f_avg(k3, 2) / exp_value.f_avg(k3, 1), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)];
%                 plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
%             end
%             k3 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) > threshold
%                  continue
%              end
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) < -threshold
%                  continue
%              end
%              if exist('k4','var') == 0
%              errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%              else
%                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%                 x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
%                 y_vec = [exp_value.f_avg(k4, 2) / exp_value.f_avg(k4, 1), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)];
%                 plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
%             end
%             k4 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) > threshold
%                  continue
%              end
%              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) < - threshold
%                  continue
%              end
%              if exist('k5','var') == 0
%             errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%             else
%                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'green')
%                 x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
%                 y_vec = [exp_value.f_avg(k5, 2) / exp_value.f_avg(k5, 1), exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)];
%                 plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
%             end
%             k5 = k;
%          end
%     end
%     
%     str_annotation = sprintf('Re = %.2e', Re);
%     annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
%     hold off
%     saveas(gcf, ['../pic/CL_over_CD_plot/', 'CL_over_CD_plot_#', num2str(j), 'flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
% 
% % checking and printing whether chosen path is accessible
%     
%     if ~isfolder('..')
%         error('Corrupt or very very old file system, missing .. directory entry')
%     elseif ~isfolder('../pic')
%         error('No folder ../data_analysis')
%     elseif ~isfolder('../pic/CL_over_CD_plot')
%         error('No folder ../pic/CL_over_CD_plot')
%     else
%         fprintf('folder path ../pic/CL_plot/ is okay \n')
%     end
% 
% end

% % %% CD / CL: presenting one plot per selected speed and all inflations, against AoA
% % 
% % for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
% % 
% %     [status, msg, msgID] = mkdir('./pic/CD_over_CL_plot/'); % saving-folder creation
% %     Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
%       disp(sel_speed(j))
% % 
% %     clear k1 k2 k3 k4 k5
% % 
% %     figure('Position', [200, 200, 1000, 1000])
% % 
% %     title(['CD / CL plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight', 'bold', 'fontsize', 24)
% %     legend('Location','north','Orientation','horizontal','fontsize', 16)
% %     hold on
% %     grid on
% %     xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
% %     ylabel('CD / CL [ ]','fontweight','bold','fontsize', 30);
% %     xlim([-10 35])
% %     ylim([0 +1])
% % 
% %     for k = 1:length(exp_value.f_avg)
% % 
% %          if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
% %              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) > threshold
% %                  continue
% %              end
% %              if (exp_value.f_avg(k, 2) / exp_value.f_avg(k, 1)) < - threshold
% %                  continue
% %              end
% % 
% %             if exist('k1','var') == 0
% %             errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
% %             else
% %                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
% %                 x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
% %                 y_vec = [exp_value.f_avg(k1, 1) / exp_value.f_avg(k1, 2), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)];
% %                 plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
% %             end
% %             k1 = k;
% %          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) > threshold
% %                  continue
% %              end
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) < - threshold
% %                  continue
% %              end
% %              if exist('k2','var') == 0
% %              errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
% % 
% %              else
% %                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 2) / exp_value.f_std(k, 1), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
% %                 x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
% %                 y_vec = [exp_value.f_avg(k2, 1) / exp_value.f_avg(k2, 2), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)];
% %                 plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
% %             end
% %             k2 = k;
% %          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) > threshold
% %                  continue
% %              end
% %             if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) < - threshold
% %                  continue
% %              end
% %              if exist('k3','var') == 0
% %              errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
% %              else
% %                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
% %                 x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
% %                 y_vec = [exp_value.f_avg(k3, 1) / exp_value.f_avg(k3, 2), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)];
% %                 plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
% %             end
% %             k3 = k;
% %          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) > threshold
% %                  continue
% %              end
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) < -threshold
% %                  continue
% %              end
% %              if exist('k4','var') == 0
% %              errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
% %              else
% %                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
% %                 x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
% %                 y_vec = [exp_value.f_avg(k4, 1) / exp_value.f_avg(k4, 2), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)];
% %                 plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
% %             end
% %             k4 = k;
% %          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) > threshold
% %                  continue
% %              end
% %              if (exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)) < - threshold
% %                  continue
% %              end
% %              if exist('k5','var') == 0
% %             errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
% %             else
% %                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2), exp_value.f_std(k, 1) / exp_value.f_std(k, 2), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'green')
% %                 x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
% %                 y_vec = [exp_value.f_avg(k5, 1) / exp_value.f_avg(k5, 2), exp_value.f_avg(k, 1) / exp_value.f_avg(k, 2)];
% %                 plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
% %             end
% %             k5 = k;
% %          end
% %     end
% %     
% %     str_annotation = sprintf('Re = %.2e', Re);
% %     annotation('textbox', [0.696 0.77 0.1 0.1], 'String', str_annotation, 'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex' ) % printing Re on plots
% %     hold off
% %     saveas(gcf, ['./pic/CD_over_CL_plot/', 'CD_over_CL_plot_#', num2str(j), 'flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
% % 
% % % checking and printing whether chosen path is accessible
% %     
% %     if ~isfolder('..')
% %         error('Corrupt or very very old file system, missing .. directory entry')
% %     elseif ~isfolder('../pic')
% %         error('No folder ../data_analysis')
% %     elseif ~isfolder('../pic/CL_over_CD_plot')
% %         error('No folder ../pic/CL_over_CD_plot')
% %     else
% %         fprintf('folder path ../pic/CL_plot/ is okay \n')
% %     end
% % 
% % end
% % 


%% CL: presenting one plot per selected speed and all inflations, against AoA

%   [status, msg, msgID] = mkdir('./pic_notitle_paper/CL_plot/'); % saving-folder creation
    [status, msg, msgID] = mkdir('./pic/CL_plot/');

for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots

    Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
    disp(sel_speed(j))
    
    clear k1 k2 k3 k4 k5
    
    figure('Position', [200, 200, 1000, 1000])

    title(['CL plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
    legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
    hold on
    grid on
    xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
    ylabel('CL [ ]','fontweight','bold','fontsize', 30);
    ax = gca;
    ax.XAxis.LineWidth = 2;
    ax.YAxis.LineWidth = 2;
    xlim([-10 25])
    ylim([-0.2 2])

    for k = 1:length(exp_value.f_avg)

         if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
            if exist('k1','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
            else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(1, j)), exp_value.f_std(k, lift_dir) / div(1, j), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
                x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k1, lift_dir) / div(1, j)), (-exp_value.f_avg(k, lift_dir) / div(1, j))];
                plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
            end
            k1 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
             if exist('k2','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(2, j)), exp_value.f_std(k, lift_dir) / div(2, j), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
             else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(2, j)), exp_value.f_std(k, lift_dir) / div(2, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k2, lift_dir) / div(2, j)), (-exp_value.f_avg(k, lift_dir) / div(2, j))];
                plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
            end
            k2 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
             if exist('k3','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(3, j)), exp_value.f_std(k, lift_dir) / div(3, j), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
             else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(3, j)), exp_value.f_std(k, lift_dir) / div(3, j), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k3, lift_dir) / div(3, j)), (-exp_value.f_avg(k, lift_dir) / div(3, j))];
                plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
            end
            k3 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
             if exist('k4','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(4, j)), exp_value.f_std(k, lift_dir) / div(4, j), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
             else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(4, j)), exp_value.f_std(k, lift_dir) / div(4, j), 'ob', 'HandleVisibility','off','CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k4, lift_dir) / div(4, j)), (-exp_value.f_avg(k, lift_dir) / div(4, j))];
                plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
            end
            k4 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
            if exist('k5','var') == 0 
             errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, lift_dir) / div(5, j)), exp_value.f_std(k, lift_dir) / div(5, j), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
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
     %      'BackgroundColor','white','LineStyle','-','Fontsize', 16, 'Interpreter','latex') % printing Re on plots
    hold off
    %saveas(gcf, ['./pic_notitle_paper/CL_plot/', 'CL_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
    saveas(gcf, ['./pic/CL_plot/', 'CL_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
    
% checking and printing whether chosen path is accessible
    
%     if ~isfolder('..')
%         error('Corrupt or very very old file system, missing .. directory entry')
%     elseif ~isfolder('../pic')
%         error('No folder ../data_analysis')
%     elseif ~isfolder('../pic/CL_plot')
%         error('No folder ../pic/CL_plot')
%     else
%         fprintf('folder path ../pic/CL_plot/ is okay \n')
%     end
 
end


%% CD: presenting one plot per selected speed and all inflations, against AoA

%     [status, msg, msgID] = mkdir('../pic_notitle_paper/CD_plot/'); % saving-folder creation
[status, msg, msgID] = mkdir('./pic/CD_plot/');

for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots

    Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
    disp(sel_speed(j))
    clear k1 k2 k3 k4 k5

    figure('Position', [200, 200, 1000, 1000])

    title(['CD plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))], 'fontweight','bold','fontsize', 24)
    legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
    hold on
    grid on
    xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
    ylabel('CD [ ]','fontweight','bold','fontsize', 30);
    xlim([-10 25])
    ylim([-.1 0.8])
    ax = gca;
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
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(2, j)), exp_value.f_std(k, drag_dir) / div(2, j), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
             else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(2, j)), exp_value.f_std(k, drag_dir) / div(2, j), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
                x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k2, drag_dir)  / div(2, j)), (-exp_value.f_avg(k, drag_dir) / div(2, j))];
                plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
            end
            k2 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
             if exist('k3','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(3, j)), exp_value.f_std(k, drag_dir) / div(3, j), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
             else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(3, j)), exp_value.f_std(k, drag_dir) / div(3, j), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
                x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k3, drag_dir) / div(3, j)), (-exp_value.f_avg(k, drag_dir) / div(3, j))];
                plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
            end
            k3 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
             if exist('k4','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(4, j)), exp_value.f_std(k, drag_dir) / div(4, j), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
             else
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(4, j)), exp_value.f_std(k, drag_dir) / div(4, j), 'ob', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
                x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
                y_vec = [(-exp_value.f_avg(k4, drag_dir) / div(4, j)), (-exp_value.f_avg(k, drag_dir) / div(4, j))];
                plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
            end
            k4 = k;
         elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
             if exist('k5','var') == 0
                errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, drag_dir) / div(5, j)), exp_value.f_std(k, drag_dir) / div(5, j), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
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
    saveas(gcf, ['./pic/CD_plot/','/CD_plot_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder

% checking and printing whether chosen path is accessible

%     if ~isfolder('..')
%         error('Corrupt or very very old file system, missing .. directory entry')
%     elseif ~isfolder('../pic')
%         error('No folder ../data_analysis')
%     elseif ~isfolder('../pic/CD_plot')
%         error('No folder ../pic/CD_plot')
%     else
%         fprintf('folder path ../pic/CD_plot/ is okay \n')
%     end

end
% 
% %% CM: presenting one plot per selected speed and all inflations, against AoA
% 
% for j = 1:length(sel_speed)
%     dyn_pressure = 0.5 * rho * sel_speed(j) ^ 2; % calculation of dynamic pressure
% 
%     figure
%     title(['CM pitch plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))])
%     hold on
%     grid on
%     xlabel('AoA [deg]')
%     ylabel('CL / CD')
%     xlim([-10 35])
%     ylim([-10 10])
% 
%     for k = 1:length(MyFolderInfo)
%          if (torque.vel(k) == sel_speed(j)) && (torque.inflation(k) == sel_inflation(1))
%             scatter(torque.aoa(k), torque.avg(k, 2), 'r', 'filled');
%          elseif (torque.vel(k) == sel_speed(j)) && (torque.inflation(k) == sel_inflation(2))
%              scatter(torque.aoa(k), torque.avg(k, 2), 'o', 'filled');
%          elseif (torque.vel(k) == sel_speed(j)) && (torque.inflation(k) == sel_inflation(3))
%              scatter(torque.aoa(k), torque.avg(k, 2), 'y', 'filled');
%          elseif (torque.vel(k) == sel_speed(j)) && (torque.inflation(k) == sel_inflation(4))
%              scatter(torque.aoa(k), torque.avg(k, 2), 'b', 'filled');
%          elseif (torque.vel(k) == sel_speed(j)) && (torque.inflation(k) == sel_inflation(5))
%              scatter(torque.aoa(k), torque.avg(k, 2), 'k', 'filled');
%          end
%     end
%     
%     legend({'inf. = 0 mL', 'inf. = 60 mL', 'inf. = 90 mL', 'inf. = 120 mL', 'inf. = 30 mL'}, ... 
%      'Location','northwest','Orientation','horizontal')
%     hold off
% 
% end
% 
% 
% %% Lift: presenting one plot per selected speed and all inflations, against AoA

%     [status, msg, msgID] = mkdir('./Force_pic/Lift/'); % saving-folder creation
% 
% for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
% 
%     
%     Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
%     
%     clear k1 k2 k3 k4 k5
%     
%     figure('Position', [200, 200, 1000, 1000])
% 
%     title(['Lift plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
%     legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
%     hold on
%     grid on
%     xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
%     ylabel('Lift [N]','fontweight','bold','fontsize', 30);
%     ax = gca;
%     ax.XAxis.LineWidth = 2;
%     ax.YAxis.LineWidth = 2;
%     xlim([-10 35])
% %   ylim([-0.75 1.75])
% 
%     for k = 1:length(exp_value.f_avg)
% 
%          if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
%             if exist('k1','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%             else
%                 errorbar(exp_value.aoa(k), -exp_value.f_avg(k, 2), exp_value.f_std(k, lift_dir), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%                 x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
%                 y_vec = [-exp_value.f_avg(k1, 2)  , (-exp_value.f_avg(k, 2))];
%                 plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
%             end
%             k1 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
%              if exist('k2','var') == 0
%                 errorbar(exp_value.aoa(k), (exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%              else
%                 errorbar(exp_value.aoa(k), exp_value.f_avg(k, 2), exp_value.f_std(k, lift_dir), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%                 x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
%                 y_vec = [(exp_value.f_avg(k2, 2)), (exp_value.f_avg(k, 2))];
%                 plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
%             end
%             k2 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
%              if exist('k3','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%                 x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k3, 2)), (-exp_value.f_avg(k, 2))];
%                 plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
%             end
%             k3 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
%              if exist('k4','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'ob', 'HandleVisibility','off','CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%                 x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k4, 2)), (-exp_value.f_avg(k, 2))];
%                 plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
%             end
%             k4 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
%             if exist('k5','var') == 0 
%              errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%             else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 2)), exp_value.f_std(k, lift_dir), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%                 x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k5, 2)), (-exp_value.f_avg(k, 2))];
%                 plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
%             end
%             k5 = k;
%          end
%     end
%     
%     hold off
%     saveas(gcf, ['./Force_pic/Lift/', 'Lift_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
% 
% end
% 
% %% Drag: presenting one plot per selected speed and all inflations, against AoA

%     [status, msg, msgID] = mkdir('./Force_pic/Drag/'); % saving-folder creation
% 
% for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
% 
%     
%     Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
%     
%     clear k1 k2 k3 k4 k5
%      
%     figure('Position', [200, 200, 1000, 1000])
% 
%     title(['Drag plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
%     legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
%     hold on
%     grid on
%     xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
%     ylabel('Drag [N]','fontweight','bold','fontsize', 30);
%     ax = gca;
%     ax.XAxis.LineWidth = 2;
%     ax.YAxis.LineWidth = 2;
%     xlim([-10 35])
%     ylim([-0.25 8])
% 
%     for k = 1:length(exp_value.f_avg)
% 
%          if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
%             if exist('k1','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%             else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1))  , exp_value.f_std(k, 1), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%                 x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k1, 1))  , (-exp_value.f_avg(k, 1))  ];
%                 plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
%             end
%             k1 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
%              if exist('k2','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%                 x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k2, 1)), (-exp_value.f_avg(k, 1))];
%                 plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
%             end
%             k2 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
%              if exist('k3','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%                 x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k3, 1)), (-exp_value.f_avg(k, 1))];
%                 plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
%             end
%             k3 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
%              if exist('k4','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'ob', 'HandleVisibility','off','CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%                 x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k4, 1)), (-exp_value.f_avg(k, 1))];
%                 plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
%             end
%             k4 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
%             if exist('k5','var') == 0 
%              errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%             else
%                 errorbar(exp_value.aoa(k), (-exp_value.f_avg(k, 1)), exp_value.f_std(k, 1), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%                 x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.f_avg(k5, 1)), (-exp_value.f_avg(k, 1))];
%                 plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
%             end
%             k5 = k;
%          end
%     end
%     
%     hold off
%     saveas(gcf, ['./Force_pic/Drag/', 'Drag_#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
% 
% end
% 
% %% Torque: z direction

%     [status, msg, msgID] = mkdir('./Torque_pic/TorqueZ/'); % saving-folder creation
% 
% for j = 1:length(sel_speed) % looping over flow speed to create fixed-speed plots
% 
%     
%     Re = sel_speed(j) * chord / kin_viscosity; % Reynolds number
%     
%     clear k1 k2 k3 k4 k5
%      
%     figure('Position', [200, 200, 1000, 1000])
% 
%     title(['TorqueZ plot # ', num2str(j), '; Flow Speed: ', num2str(sel_speed(j))],'fontweight','bold','fontsize', 24)
%     legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
%     hold on
%     grid on
%     xlabel('AoA [deg]','fontweight','bold','fontsize', 30);
%     ylabel('TorqueZ [Nm]','fontweight','bold','fontsize', 30);
%     ax = gca;
%     ax.XAxis.LineWidth = 2;
%     ax.YAxis.LineWidth = 2;
%     xlim([-10 35])
%     ylim([-1 1])
% 
%     for k = 1:length(exp_value.t_avg)
% 
%          if (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(1))
%             if exist('k1','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'or', 'DisplayName', 'neutral', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%             else
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3))  , exp_value.t_std(k, 3), 'or', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'r', 'LineWidth', 1, MarkerEdgeColor = 'red')
%                 x_vec = [exp_value.aoa(k1), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.t_avg(k1, 3))  , (-exp_value.t_avg(k, 3))  ];
%                 plot(x_vec, y_vec, '--r', 'HandleVisibility','off')
%             end
%             k1 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(2))
%              if exist('k2','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'ok', 'DisplayName', 'inf. = 60 mL', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'ok', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'k', 'LineWidth', 1, MarkerEdgeColor = 'black')
%                 x_vec = [exp_value.aoa(k2), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.t_avg(k2, 3)), (-exp_value.t_avg(k, 3))];
%                 plot(x_vec, y_vec, '--k', 'HandleVisibility','off')
%             end
%             k2 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(3))
%              if exist('k3','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'om', 'DisplayName', 'inf. = 90 mL', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'om', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'm', 'LineWidth', 1, MarkerEdgeColor = 'magenta')
%                 x_vec = [exp_value.aoa(k3), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.t_avg(k3, 3)), (-exp_value.t_avg(k, 3))];
%                 plot(x_vec, y_vec, '--m', 'HandleVisibility','off')
%             end
%             k3 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(4))
%              if exist('k4','var') == 0
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'ob', 'DisplayName', 'inf. = 120 mL', 'CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%              else
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'ob', 'HandleVisibility','off','CapSize', 18, 'MarkerFaceColor', 'b', 'LineWidth', 1, MarkerEdgeColor = 'blue')
%                 x_vec = [exp_value.aoa(k4), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.t_avg(k4, 3)), (-exp_value.t_avg(k, 3))];
%                 plot(x_vec, y_vec, '--b', 'HandleVisibility','off')
%             end
%             k4 = k;
%          elseif (exp_value.vel(k) == sel_speed(j)) && (exp_value.inflation(k) == sel_inflation(5))
%             if exist('k5','var') == 0 
%              errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'og', 'DisplayName', 'inf. = 30 mL', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%             else
%                 errorbar(exp_value.aoa(k), (-exp_value.t_avg(k, 3)), exp_value.t_std(k, 3), 'og', 'HandleVisibility','off', 'CapSize', 18, 'MarkerFaceColor', 'g', 'LineWidth', 1, MarkerEdgeColor = 'green')
%                 x_vec = [exp_value.aoa(k5), exp_value.aoa(k)];
%                 y_vec = [(-exp_value.t_avg(k5, 3)), (-exp_value.t_avg(k, 3))];
%                 plot(x_vec, y_vec, '--g', 'HandleVisibility','off')
%             end
%             k5 = k;
%          end
%     end
%     
%     hold off
%     saveas(gcf, ['./Torque_pic/TorqueZ/', 'TorqueZ#', num2str(j), '_flow_speed_0_', num2str(100 * sel_speed(j))], 'png'); % saving plots in desired folder
% 
% end

%% Plots closure

close all