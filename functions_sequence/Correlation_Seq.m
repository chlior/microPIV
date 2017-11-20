function [handles] = Correlation_Seq(hObject, eventdata,handles)

    set(handles.text_Status,'String','Wait: Correlation...'); drawnow;
    
    handles.wins = str2num(get(handles.edit1,'String'))
    handles.deltaT = str2double(get(handles.edit2,'String'))
    handles.overlap = str2double(get(handles.edit3,'String'))
    handles.method = get(handles.edit4,'String')
    handles.sizeFactor = str2double(get(handles.edit5,'String'))
    handles.fps = str2double(get(handles.edit6,'String')) 
    
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
   handles.fps
   outputVideo.FrameRate = 1;%handles.fps;
   outputVideo.Quality=100;
   open(outputVideo)

    timerVal = tic  
    for i=1:handles.seq
        size(handles.images{i,1})
    [x,y,u,v,snr,pkh] = matpiv(handles.images{i},handles.images{i+1},...
        handles.wins,handles.deltaT,handles.overlap,handles.method,[],handles.maskfile);
    
      if y(end,:) == 0; y(end,:) = []; x(end,:) = []; v(end,:) = []; u(end,:) = [];  end %%%Temporary 'multin' fix
    if x(:,end) == 0; x(:,end) = []; y(:,end) = []; v(:,end) = []; u(:,end) = []; end
    
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
    xlabel('x [pixel]'); ylabel('y [pixel]');
    title(sprintf('Raw Data Correlation # %d-%d ',i ,i+1 ));
    axis on
    
        %save to image   
   folder_seq = fullfile(folder,'seq');  
      if exist(folder_seq)==0 mkdir(folder_seq); end    
    s = sprintf('___%d-%d',i,i+1);
    FileNameSeqIm = strcat(fullfile(folder_seq,datetime),s);
%     FileNameSeqIm = fullfile(FileNameIm,datetime_seq);
   
%     imwrite(a.cdata,FileNameSeqIm)
    a = handles.axes1;
    b = a.Children;
%      d = getframe(gca)
     d = export_fig(a,FileNameSeqIm,  '-png', '-q101');
    
    writeVideo(outputVideo,d); %a.cdata)
    end
    close(outputVideo)   
    elapsedTime = toc(timerVal)
  
    handles.mSeqCorrelation = mSeqCorrelation;
    handles.mSeq = mSeqCorrelation; %Global use;


 
 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    str = sprintf('Finished Correlation , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;
%     guidata(hObject, handles)
end