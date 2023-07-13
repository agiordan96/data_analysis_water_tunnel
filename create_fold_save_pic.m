function [] = create_fold_save_pic(wingtype, folder_vec, plot_type)
% this function produces the directory depending on inputs and modality (no title
% for papers, with title for analysis)

    if wingtype == "hard"

        if folder_vec(1) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'CL_CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/CL_CD_plot/'));
            end
        end
        
        if folder_vec(2) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'CL_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/CL_plot/'));
            end
        end
        
        if folder_vec(3) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '_', plot_type, '/', 'CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '/CD_plot/'));
            end
        end

        if folder_vec(4) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'avCL_avCD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/avCL_avCD_plot/'));
            end
        end

        if folder_vec(5) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'medianCL_CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/medianCL_CD_plot/'));
            end
        end

     elseif wingtype == "soft"

         if folder_vec(1) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '_', plot_type, '/', 'avCL_avCD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '/avCL_avCD_plot/'));
            end
        end
        
        if folder_vec(2) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '_', plot_type, '/', 'CL_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '/CL_plot/'));
            end
        end
        
        if folder_vec(3) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '_', plot_type, '/', 'CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '/CD_plot/'));
            end
        end

        if folder_vec(4) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '_', plot_type, '/', 'avCL_avCD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '/avCL_avCD_plot/'));
            end
        end

        if folder_vec(5) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '_', plot_type, '/', 'medianCL_CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softwing/', date, '/medianCL_CD_plot/'));
            end
        end
    
    elseif wingtype == "soft_hard"
        if folder_vec(1) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', 'CL_CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '/CL_CD_plot/'));
            end
        end
        
        if folder_vec(2) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', 'CL_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '/CL_plot/'));
            end
        end
        
        if folder_vec(3) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', 'CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '/CD_plot/'));
            end
        end

        if folder_vec(4) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', 'avCL_avCD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '/avCL_avCD_plot/'));
            end
        end

        if folder_vec(5) == 1 
            if plot_type == "no_title"
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '_', plot_type, '/', 'medianCL_CD_plot/'));
            else
                [~, ~, ~] = mkdir(strcat('./pictures_wing/pic_softhardwing/', date, '/medianCL_CD_plot/'));
            end
        end
    end
end