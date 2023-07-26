FolderName = ('./pictures_wing/pic_softhardwing/jpegtest/CL/');   % using my directory
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = num2str(get(FigHandle, 'Number'));
  set(0, 'CurrentFigure', FigHandle);
%   saveas(FigHandle, strcat(FigName, '.png'));
  exportgraphics(FigHandle, strcat(FolderName, FigName, '.jpg'),'Resolution',300); % specify the full path
end