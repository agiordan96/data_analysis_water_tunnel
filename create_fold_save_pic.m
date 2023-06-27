function [] = create_fold_save_pic(folder_vec, plot_type)
% this function produces the directory depending on inputs and modality (no title
% for papers, with title for analysis)

if folder_vec(1) == 1 
    if plot_type == "no_title"
        [status, msg, msgID] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'CL_CD_plot/'));
    else
        [status, msg, msgID] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/CL_CD_plot/'));
    end
end

if folder_vec(2) == 1 
    if plot_type == "no_title"
        [status, msg, msgID] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'CL_plot/'));
    else
        [status, msg, msgID] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/CL_plot/'));
    end
end

if folder_vec(3) == 1 
    if plot_type == "no_title"
        [status, msg, msgID] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '_', plot_type, '/', 'CD_plot/'));
    else
        [status, msg, msgID] = mkdir(strcat('./pictures_wing/pic_hardwing/', date, '/CD_plot/'));
    end

end