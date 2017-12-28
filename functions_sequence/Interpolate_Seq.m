function [handles] = Interpolate(hObject, eventdata, handles)

handles.sizeFactor = str2num(get(handles.edit1,'string'));
handles.fps = str2num(get(handles.edit2,'string'));
handles.display = (get(handles.edit3,'string'));

set(handles.text_Status,'String','Wait: Interpolating');drawnow;



     %Save
   folder  = fullfile(handles.FolderName,'Correlation_Seq','Interpolate');  
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

mSeqFiltering = handles.mSeqFiltering;
%%%%%% function%%%%%%
   for i=1:handles.seq
      set(handles.text_Status,'String',sprintf('Wait: Interpolate %d / %d',i,handles.seq)); drawnow;
      cla(handles.axes1);
   
x = mSeqFiltering{1,i}.x;
y = mSeqFiltering{1,i}.y;
u = mSeqFiltering{1,i}.u;
v = mSeqFiltering{1,i}.v;
snr = mSeqFiltering{1,i}.snr;
pkh = mSeqFiltering{1,i}.pkh;

[u,v] = naninterp(u,v,'linear',handles.maskfile,x,y);
%  set(handles.text_Status,'String','Finished');
 
 cla(handles.axes1);
%  imshow(handles.images{i});   hold on; 
%  handles.fig=quiver(x,y,u,v,handles.sizeFactor); 
%  xlabel('pixel'); ylabel('pixel');
%  title('Filtered And Interpolated Correlation');

 
         %.mat  
   datetimef = strcat(datetime,sprintf('#%d-%d.mat',i,i+1));
   folder_mat  = fullfile(folder,'m-file');   
   if exist(folder_mat)==0 mkdir(folder_mat); end
   FileName = fullfile(folder_mat,datetimef)
%     m = matfile(FileName, 'Writable', true);
    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
    m.snr = snr;
    m.pkh = pkh;
    mSeqInterpolate{i} = m;
    mSeq{i} = m; %Global use;
    clear m 
 
    if strcmp(handles.display,'yes')
    cla(handles.axes1);
    imshow(handles.images{i});   hold on;  
    handles.fig=quiver(x,y,u,v,handles.sizeFactor,'Color','red');
    xlabel('x [pixel]'); ylabel('y [pixel]');
    title(sprintf('Raw Data Interpolated # %d-%d ',i ,i+1 ));
    if i==1 axis tight; lim = axis ; end
    axis on
    axis(lim)
        %save to image   
   folder_seq = fullfile(folder,'seq');  
      if exist(folder_seq)==0 mkdir(folder_seq); end    
    s = sprintf('___%d-%d',i,i+1);
    FileNameSeqIm = strcat(fullfile(folder_seq,datetime),s);
  
    a = handles.axes1;
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
    
    

    handles.mSeqFiltering = mSeqInterpolate;
    handles.mSeq = mSeqInterpolate; %Global use;
 
    mc = matfile(FileName, 'Writable', true);
    mc.cell = mSeqInterpolate;
  %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    str = sprintf('Finished Interpolate , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;
                
%     guidata(hObject, handles)
end