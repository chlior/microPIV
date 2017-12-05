function [handles] = Correlation_Seq(hObject, eventdata,handles)

    set(handles.text_Status,'String','Wait: Correlation...'); drawnow;
    
    handles.wins = str2num(get(handles.edit1,'String'))
    handles.deltaT = str2double(get(handles.edit2,'String'))
    handles.overlap = str2double(get(handles.edit3,'String'))
    handles.method = get(handles.edit4,'String')
    handles.sizeFactor = str2double(get(handles.edit5,'String'))
    handles.fps = str2double(get(handles.edit6,'String')) 
    handles.display = get(handles.edit7,'String')
    
       %Save
   folder  = fullfile(handles.FolderName,'Correlation_Seq');  
      if exist(folder)==0 mkdir(folder); end
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 


   %.avi
   if strcmp(handles.display,'yes')
   datetimef = strcat('video_',datetime,'.avi');
   folder_vid = fullfile(folder,'video');   
   if exist(folder_vid)==0 mkdir(folder_vid); end
   FileName_vid = fullfile(folder_vid,datetimef)

   outputVideo = VideoWriter(FileName_vid);
   outputVideo.FrameRate = handles.fps;
   outputVideo.Quality=100;
   open(outputVideo)
    end   
   
    timerVal = tic  
    for i=1:handles.seq
      set(handles.text_Status,'String',sprintf('Wait: Correlate %d / %d',i,handles.seq)); drawnow;
        size(handles.images{i,1})
    [x,y,u,v,snr,pkh] = matpiv(handles.images{i},handles.images{i+1},...
        handles.wins,handles.deltaT,handles.overlap,handles.method,[],handles.maskfile);
    
      if y(end,:) == 0; y(end,:) = []; x(end,:) = []; v(end,:) = []; u(end,:) = [];  end %%%Temporary 'multin' fix
    if x(:,end) == 0; x(:,end) = []; y(:,end) = []; v(:,end) = []; u(:,end) = []; end
 
    
       %.mat  
   datetimef = strcat(datetime,sprintf('#%d-%d.mat',i,i+1));
   folder_mat  = fullfile(folder,'m-file');   
   if exist(folder_mat)==0 mkdir(folder_mat); end
   FileName = fullfile(folder_mat,datetimef)
%     FileNameSeq = fullfile(FileName,i);
    m = matfile(FileName, 'Writable', true);
    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
    m.snr = snr;
    m.pkh = pkh;
    mSeqCorrelation{i} = m;
    clear m 
 

    if strcmp(handles.display,'yes')
    cla(handles.axes1);
%     set(handles.text_Status,'String','Wait: Plot Data'); drawnow;
    imshow(handles.images{i});   hold on;
    handles.fig=quiver(x,y,u,v,handles.sizeFactor,'Color','red');
    xlabel('x [pixel]'); ylabel('y [pixel]');
    title(sprintf('Raw Data Correlation # %d-%d ',i ,i+1 ));
    if i==1 axis tight; lim = axis ; end
    axis on
    axis(lim)
        %save to image   
   folder_seq = fullfile(folder,'seq');  
      if exist(folder_seq)==0 mkdir(folder_seq); end    
    s = sprintf('___%d-%d',i,i+1);
    FileNameSeqIm = strcat(fullfile(folder_seq,datetime),s);
   
%     imwrite(a.cdata,FileNameSeqIm)
    a = handles.axes1;
%      a = getframe(gca)
     d = export_fig(a,FileNameSeqIm,  '-png', '-q101');    
    writeVideo(outputVideo,d); %a.cdata)
    end
    end
     if  strcmp(handles.display,'yes')
    close(outputVideo);
     else 
      imshow(handles.images{i});   hold on;   
      handles.fig=quiver(x,y,u,v,handles.sizeFactor,'Color','red');
      title(sprintf('Raw Data Correlation example'));     
     end
    elapsedTime = toc(timerVal)
  
    handles.mSeqCorrelation = mSeqCorrelation;
    handles.mSeq = mSeqCorrelation; %Global use;


 
 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    str = sprintf('Finished Correlation , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;

end