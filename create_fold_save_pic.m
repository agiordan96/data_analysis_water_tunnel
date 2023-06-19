function [] = create_fold_save_pic(folder_vec, plot_type)
% this function produces the directory depending on inputs and modality (no title
% for papers, with title for analysis)

if folder_vec(1) == 1 
    if plot_type == "no_title"
        [status, msg, msgID] = mkdir('./pic_no_title/CL/CD_plot/');
    else
        [status, msg, msgID] = mkdir('./pic/CD_plot/CL/CD_plot/');
    end

elseif folder_vec(2) == 1 
    if plot_type == "no_title"
        [status, msg, msgID] = mkdir('./pic_no_title/CL_plot/');
    else
        [status, msg, msgID] = mkdir('./pic/CL_plot/CL_plot/');
    end

elseif folder_vec(3) == 1 
    if plot_type == "no_title"
        [status, msg, msgID] = mkdir('./pic_no_title/CD_plot/');
    else
        [status, msg, msgID] = mkdir('./pic/CD_plot/CD_plot/');
    end

end