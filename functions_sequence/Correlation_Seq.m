function [handles] = Correlation_Seq(hObject, eventdata,handles)

    set(handles.text_Status,'String','Wait: Correlation...'); drawnow;
    
    handles.wins = str2num(get(handles.edit1,'String'))
    handles.deltaT = str2double(get(handles.edit2,'String'))
    handles.overlap = str2double(get(handles.edit3,'String'))
    handles.method = get(handles.edit4,'String')
    handles.sizeFactor = str2double(get(handles.edit5,'String'))

       %Save
   folder  = fullfile(handles.FolderName,'Correlation_Seq');  
      if exist(folder)==0 mkdir(folder); end
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   %.mat   
   datetime_mat = strcat(datetime,'.mat'); 
   FileName = fullfile(folder,datetime_mat)
   %.png
%    FileNameIm = fullfile(folder,datetime)
   %.avi
   datetime_avi = strcat('video_',datetime,'.avi');
   outputVideo = VideoWriter(fullfile(folder,datetime_avi));
   outputVideo.FrameRate = 4; %edit1!!!!! sec
   open(outputVideo)
    
    timerVal = tic  
    for i=1:handles.seq
    [x,y,u,v,snr,pkh] = matpiv(handles.images{i},handles.images{i+1},...
        transpose(handles.wins),handles.deltaT,handles.overlap,handles.method,[],handles.maskfile);
    FileNameSeq = fullfile(FileName,i);
    m = matfile(FileName, 'Writable', true);
    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
    m.snr = snr;
    m.pkh = pkh;
    mSeqCorrelation{i} = m;
    clear m 
    
    cla(handles.axes1);
    set(handles.text_Status,'String','Wait: Plot Data'); drawnow;
    imshow(handles.images{i});   hold on;
    handles.fig=quiver(x,y,u,v,handles.sizeFactor);
    xlabel('pixel'); ylabel('pixel');
    title('Raw Data Correlation');
    axis on
    
        %save to image   
    s = sprintf('___%d.png',i);
    FileNameSeqIm = strcat(folder,datetime,s);
%     FileNameSeqIm = fullfile(FileNameIm,datetime_seq);
    a = getframe(gca)
    imwrite(a.cdata,FileNameSeqIm)
    writeVideo(outputVideo,a.cdata)
    end
    close(outputVideo)   
    elapsedTime = toc(timerVal)
  
    handles.mSeqCorrelation = mSeqCorrelation;
    handles.mSeq = mSeqCorrelation; %Global use;


 
 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    str = sprintf('Finished Correlation , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;
    guidata(hObject, handles)
end