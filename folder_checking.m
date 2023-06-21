function [] = folder_checking(plot_type, plot_variable)
   % checking and printing whether chosen path is accessible
    
   if length(plot_type) == 5 && plot_type == "title"
       if ~isfolder('..')
           error('Corrupt or very very old file system, missing .. directory entry')
        elseif ~isfolder('./pic_hardwing')
           error('No folder ../data_analysis_soft_wing')
        elseif ~isfolder(strcat('./pic_hardwing/',plot_variable, '_plot'))
           error(strcat('No folder ./pic_hardwing/',plot_variable, '_plot'))
        else
           fprintf(strcat('folder path ./pic_hardwing/', plot_variable, '_plot/ is okay \n'))
       end

   else
       if ~isfolder('..')
           error('Corrupt or very very old file system, missing .. directory entry')
        elseif ~isfolder('./pic_hardwing')
           error('No folder ../data_analysis_soft_wing')
        elseif ~isfolder(strcat('./pic_hardwing/',plot_variable, '_plot'))
           error(strcat('No folder ./pic_hardwing/',plot_variable, '_plot'))
        else
           fprintf(strcat('folder path ./pic_hardwing/', plot_variable, '_plot/ is okay \n'))
       end
   end

  
end