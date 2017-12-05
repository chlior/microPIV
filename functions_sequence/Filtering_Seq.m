function [handles] = Filtering(hObject, eventdata, handles)

set(handles.text_Status,'String','Wait: Loading parameters'); drawnow;

handles.filterChoose = (get(handles.edit1,'string'));
handles.globtrld = str2num(get(handles.edit2,'string'));
handles.loctrld = str2num(get(handles.edit3,'string'));
handles.snrtrld = str2num(get(handles.edit4,'string'));
handles.sizeFactor = str2num(get(handles.edit5,'string'));
handles.fps = str2num(get(handles.edit6,'string'));
handles.display = (get(handles.edit7,'string'));


     %Save
   folder  = fullfile(handles.FolderName,'Filtered_Correlation_Seq');  
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

mCorrelation = handles.mSeqCorrelation;

%%%%%% function%%%%%%
   for i=1:handles.seq
      set(handles.text_Status,'String',sprintf('Wait: Correlate %d / %d',i,handles.seq)); drawnow;
 cla(handles.axes1);
 
 x = mCorrelation{1,i}.x; y = mCorrelation{1,i}.y; u = mCorrelation{1,i}.u; v = mCorrelation{1,i}.v; snr = mCorrelation{1,i}.snr; pkh = mCorrelation{1,i}.pkh;
 
imshow(handles.images{i});   hold on;
 set(handles.text_Status,'String','Wait: Filtering');drawnow;
 for choice=str2num(handles.filterChoose)  
     switch choice
        case 1
            [u,v] = globfilt(x,y,u,v,handles.globtrld);
        case 2
            [u,v] = localfilt(x,y,u,v,handles.loctrld,'median');
        case 3
            [u,v] = snrfilt(x,y,u,v,snr,handles.snrtrld);
     end
 end
 

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
    mSeqFiltering{i} = m;
    mSeq{i} = m; %Global use;
    clear m 
 
    if strcmp(handles.display,'yes')
    cla(handles.axes1);
    imshow(handles.images{i});   hold on;  
    handles.fig=quiver(x,y,u,v,handles.sizeFactor,'Color','red');
    xlabel('x [pixel]'); ylabel('y [pixel]');
    title(sprintf('Raw Data Filtering # %d-%d ',i ,i+1 ));
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
      title(sprintf('Raw Data Filtering example'));     
     end
    elapsedTime = toc(timerVal)    
    
    

    handles.mSeqFiltering = mSeqFiltering;
    handles.mSeq = mSeqFiltering; %Global use;
 
  %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    str = sprintf('Finished Filtering , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;

%  guidata(hObject, handles)
end