function [handles] = Correlation(hObject, eventdata,handles)

    set(handles.text_Status,'String','Wait: Correlation...'); drawnow;
    
    handles.wins = str2num(get(handles.edit1,'String'))
    handles.deltaT = str2double(get(handles.edit2,'String'))
    handles.overlap = str2double(get(handles.edit3,'String'))
    handles.method = get(handles.edit4,'String')
    handles.sizeFactor = str2double(get(handles.edit5,'String'))

    timerVal = tic  
    [x,y,u,v,snr,pkh] = matpiv(handles.image{1},handles.image{2},...
        transpose(handles.wins),handles.deltaT,handles.overlap,handles.method,[],handles.maskfile);
    elapsedTime = toc(timerVal)
  
   %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetime = strcat(datetime,'.mat');
   folder  = fullfile(handles.FolderName,'Correlation');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetime)
    m = matfile(FileName, 'Writable', true);
    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
    m.snr = snr;
    m.pkh = pkh;
%     clear m
    handles.mCorrelation = m;

    cla(handles.axes1);
    set(handles.text_Status,'String','Wait: Plot Data'); drawnow;
    imshow(handles.image{1});   hold on;
    handles.fig=quiver(x,y,u,v,handles.sizeFactor);
    xlabel('pixel'); ylabel('pixel');
    title('Raw Data Correlation');
    axis on
    zoom on
    
    str = sprintf('Finished Correlation , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;
    guidata(hObject, handles)
end