function [m] = Correlation(hObject, eventdata, handles)
    set(handles.text_Status,'String','Wait: Correlation...'); drawnow;
    
    handles.wins = str2double(get(handles.edit1,'String'))
    handles.deltaT = str2double(get(handles.edit2,'String'))
    handles.overlap = str2double(get(handles.edit3,'String'))
    handles.method = get(handles.edit4,'String')
    handles.sizeFactor = str2double(get(handles.edit5,'String'))
%     i = handles.loop;
sframe = 1;
eframe = 2;
    i=1;
    timerVal = tic  
    [x,y,u,v,snr,pkh] = matpiv(handles.image{i},handles.image{i+1},...
        transpose(handles.wins),handles.deltaT,handles.overlap,handles.method,[],handles.maskfile);
    elapsedTime = toc(timerVal)
    
    if i == sframe;
        m.x = x;
        m.y = y;
        NumberOfFrames = eframe-sframe;
        m.u = repmat(u,1,1,NumberOfFrames);
        m.v = repmat(v,1,1,NumberOfFrames);
    else
        m.u(:,:,k) = u;
        m.v(:,:,k) = v;        
    end
    
    set(handles.text_Status,'String','Wait: Plot Data'); drawnow;
    imshow(handles.image{1});   hold on;
    handles.fig=quiver(x,y,u,v,handles.sizeFactor);
    xlabel('pixel'); ylabel('pixel');
    title('Raw Data Correlation');
    axis on
    zoom on
    
    str = sprintf('Finished Correlation , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;
    
end