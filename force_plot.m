figure
hold on
title('Drag vs AoA')
xlabel('AoA')
ylabel('Drag [N]')
legend('Location','north','Orientation','horizontal','fontsize', 22, 'LineWidth', 2)
xlim([-7.5 17.5])
ylim([0 5])
grid on


for k = 1:length(exp_value_soft.f_avg(:, 1))
    
    if exp_value_soft.inflation(k) == 90

            if exp_value_soft.vel(k) == sel_speed(1)
                    if exist('k1','var') == 0
                        errorbar(exp_value_soft.aoa(k), -exp_value_soft.f_avg(k, 2), exp_value_soft.ci(k, 2), 'o', 'Color', '#383B3E', 'DisplayName', '0.15 m/s', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
                    else
                        errorbar(exp_value_soft.aoa(k), (-exp_value_soft.f_avg(k, 2)), exp_value_soft.ci(k, 2), 'o', 'Color', '#383B3E', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#383B3E', MarkerEdgeColor = '#383B3E')
                        x_vec = [exp_value_soft.aoa(k1), exp_value_soft.aoa(k)];
                        y_vec = [(-exp_value_soft.f_avg(k1, 2)), (-exp_value_soft.f_avg(k, 2))];
                        plot(x_vec, y_vec, '-.', 'Color', '#383B3E', 'HandleVisibility','off')
                    end
                    k1 = k;
            end

            if exp_value_soft.vel(k) == sel_speed(2)
                    if exist('k2','var') == 0
                        errorbar(exp_value_soft.aoa(k), -exp_value_soft.f_avg(k, 2), exp_value_soft.ci(k, 2), 'o', 'Color', '#7E2F8E', 'DisplayName', '0.20 m/s', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#7E2F8E', MarkerEdgeColor = '#7E2F8E')
                    else
                        errorbar(exp_value_soft.aoa(k), (-exp_value_soft.f_avg(k, 2)), exp_value_soft.ci(k, 2), 'o', 'Color', '#7E2F8E', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#7E2F8E', MarkerEdgeColor = '#7E2F8E')
                        x_vec = [exp_value_soft.aoa(k2), exp_value_soft.aoa(k)];
                        y_vec = [(-exp_value_soft.f_avg(k2, 2)), (-exp_value_soft.f_avg(k, 2))];
                        plot(x_vec, y_vec, '-.', 'Color', '#7E2F8E', 'HandleVisibility','off')
                    end
                    k2 = k;
            end

            if exp_value_soft.vel(k) == sel_speed(3)
                    if exist('k3','var') == 0
                        errorbar(exp_value_soft.aoa(k), -exp_value_soft.f_avg(k, 2), exp_value_soft.ci(k, 2), 'o', 'Color', '#77AC30', 'DisplayName', '0.25 m/s', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#77AC30', MarkerEdgeColor = '#77AC30')
                    else
                        errorbar(exp_value_soft.aoa(k), (-exp_value_soft.f_avg(k, 2)), exp_value_soft.ci(k, 2), 'o', 'Color', '#77AC30', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#77AC30', MarkerEdgeColor = '#77AC30')
                        x_vec = [exp_value_soft.aoa(k3), exp_value_soft.aoa(k)];
                        y_vec = [(-exp_value_soft.f_avg(k3, 2)), (-exp_value_soft.f_avg(k, 2))];
                        plot(x_vec, y_vec, '-.', 'Color', '#77AC30', 'HandleVisibility','off')
                    end
                    k3 = k;
            end

            if exp_value_soft.vel(k) == sel_speed(4)
                    if exist('k4','var') == 0
                        errorbar(exp_value_soft.aoa(k), -exp_value_soft.f_avg(k, 2), exp_value_soft.ci(k, 2), 'o', 'Color', '#4DBEEE', 'DisplayName', '0.30 m/s', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#4DBEEE', MarkerEdgeColor = '#4DBEEE')
                    else
                        errorbar(exp_value_soft.aoa(k), (-exp_value_soft.f_avg(k, 2)), exp_value_soft.ci(k, 2), 'o', 'Color', '#4DBEEE', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#4DBEEE', MarkerEdgeColor = '#4DBEEE')
                        x_vec = [exp_value_soft.aoa(k4), exp_value_soft.aoa(k)];
                        y_vec = [(-exp_value_soft.f_avg(k4, 2)), (-exp_value_soft.f_avg(k, 2))];
                        plot(x_vec, y_vec, '-.', 'Color', '#4DBEEE', 'HandleVisibility','off')
                    end
                    k4 = k;
            end

            if exp_value_soft.vel(k) == sel_speed(5)
                    if exist('k5','var') == 0
                        errorbar(exp_value_soft.aoa(k), -exp_value_soft.f_avg(k, 2), exp_value_soft.ci(k, 2), 'o', 'Color', '#A2142F', 'DisplayName', '0.40 m/s', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#A2142F', MarkerEdgeColor = '#A2142F')
                    else
                        errorbar(exp_value_soft.aoa(k), (-exp_value_soft.f_avg(k, 2)), exp_value_soft.ci(k, 2), 'o', 'Color', '#A2142F', 'HandleVisibility','off', 'CapSize', 18,  'LineWidth', 2, MarkerFaceColor = '#A2142F', MarkerEdgeColor = '#A2142F')
                        x_vec = [exp_value_soft.aoa(k5), exp_value_soft.aoa(k)];
                        y_vec = [-exp_value_soft.f_avg(k5, 2), (-exp_value_soft.f_avg(k, 2))];
                        plot(x_vec, y_vec, '-.', 'Color', '#A2142F', 'HandleVisibility','off')
                    end
                    k5 = k;
            end

    end
    
end
clear k1 k2 k3 k4 k5