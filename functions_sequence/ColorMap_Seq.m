function [handles] = ColorMap(hObject, eventdata,handles)
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.magitudeComponent = get(handles.edit1,'string')
    handles.display = get(handles.edit2,'string')
    handles.displayVector = get(handles.edit3,'string')    
    handles.sizeFactor = str2double(get(handles.edit4,'String'))   
    m = handles.mpSeq;

    
hold off

%%%%%%%%Pre save%%%%%%
   %Save
   folder  = fullfile(handles.FolderName,'Converted Data_Seq','ColorMap');  
      if exist(folder)==0 mkdir(folder); end
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   %.mat  
   datetimef = strcat(datetime,'.mat');
   folder_mat  = fullfile(folder,'m-file');   
   if exist(folder_mat)==0 mkdir(folder_mat); end
   FileName = fullfile(folder_mat,datetimef)
   mag = matfile(FileName, 'Writable', true);

   %.avi
   datetimef = strcat('video_',datetime,'.avi');
   folder_vid = fullfile(folder,'video');   
   if exist(folder_vid)==0 mkdir(folder_vid); end
   FileName_vid = fullfile(folder_vid,datetimef)
   
   outputVideo = VideoWriter(FileName_vid);
   handles.fps
   outputVideo.FrameRate = 0.5;%handles.fps;
   outputVideo.Quality=100;
   open(outputVideo)

    timerVal = tic 
    for i=1:handles.seq
%%%%%%%%function%%%%%%
colormap(jet);
%  m.y = flipud(m.y);
     switch handles.magitudeComponent
        case 'm'
        handles.w= magnitude(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v);
        strTitle = ' Velocity Magnitude';
        case 'u'
        handles.w=magnitude(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v.*0);
        strTitle = ' Velocity x component';
        case 'v'
        handles.w=magnitude(m{1,i}.x,m{1,i}.y,m{1,i}.u.*0,m{1,i}.v);
        strTitle = ' Velocity y component';
         otherwise
            set(handles.text_Status,'String','Magnitude: fix and run again'); drawnow;
            uiwait(msgbox('Choose correct component')); return;
     end    

     switch handles.display
        case 'magnitude'
            handles.fig = pcolor(m{1,i}.x,m{1,i}.y,handles.w);% drawnow;%, shading flat, colorbar
            set(handles.fig,'edgecolor','none');  
            strTitle = strcat('Magnitude  -',strTitle);
        case 'contour fill'
             handles.fig = contourf(m{1,i}.x,m{1,i}.y,m{1,i}.v);
             strTitle = strcat('Contour fill  -',strTitle);
        case 'gradient contour'
            dw = gradient(handles.w)
            handles.fig = contour(m{1,i}.x,m{1,i}.y,dw);
            strTitle = strcat('Gradient contour  -',strTitle);
        case 'gradient contour fill'      
            dw = gradient(handles.w)
            contourf(m{1,i}.x,m{1,i}.y,dw);
            strTitle = strcat('Gradient contour fill -',strTitle);
        case 'gradient fill'           
            dw = gradient(handles.w)
            handles.fig =  pcolor(m{1,i}.x,m{1,i}.y,dw); %contourf(m.x,m.y,dw);
        case 'vorticity'
            strTitle = 'Vorticity';
            vor = vorticity(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v);
            pcolor(m{1,i}.x(3:end-2,3:end-2),m{1,i}.y(3:end-2,3:end-2),vor);
            
         otherwise
          uiwait(msgbox('Write Correctly Which Analysis!')); return;            
     end

  shading interp %shading interp/flat/faceted 
  ax = gca;  %// get axes handle
  set(gca,'Ydir','reverse');   set(ax,'XTickLabel');   set(ax,'YTickLabel'); %// set labels
  xlabel('x [um]'); ylabel('y [um]');
  strTitle = strcat(strTitle,sprintf('#%d-%d',i,i+1));
  title(strTitle);

if strcmp(handles.display,'vorticity')   
      ylabel(colorbar,'Vorticity [1/sec]');
elseif strcmp(handles.display,'gradient contour fill') ||  strcmp(handles.display,'gradient contour') 
      ylabel(colorbar,'Acceleration magnitude [um^2/sec]');
else
      ylabel(colorbar,'Velocity magnitude [um/sec]');      
end
     
a = handles.axes1;
     if i==1
         axis tight;
         lim = axis;
         clim = a.CLim; 
     end
%     axis on

  switch handles.displayVector
      case 'yes'
         hold on; quiver( m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v,handles.sizeFactor,'color',[0 0 0]);
      case 'no'
  end
     axis(lim) 
%%%%%%%%After save%%%%
        %save to image   
   folder_seq = fullfile(folder,'seq');  
      if exist(folder_seq)==0 mkdir(folder_seq); end    
    s = sprintf('___%d-%d',i,i+1);
    FileNameSeqIm = strcat(fullfile(folder_seq,datetime),s);
   
%     a = handles.axes1;
    
     a.CLim = clim;
%     a.XLim = lim(1,1:2)
%     a.YLim = lim(1,3:4)
    d = export_fig(a,FileNameSeqIm,  '-png', '-q101');    
    writeVideo(outputVideo,d); %a.cdata)
    
    end
    close(outputVideo)   
    elapsedTime = toc(timerVal)
  

% %    %Save
% %    datetime=datestr(now);
% %    datetime=strrep(datetime,':','_'); %Replace colon with underscore
% %    datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
% %    datetime=strrep(datetime,' ','_');%Replace space with underscore 
% %    datetimef = strcat(datetime,'magnitude.mat');
% %    folder  = fullfile(handles.FolderName,'Converted Data');   
% %    if exist(folder)==0 mkdir(folder); end
% %    FileName = fullfile(folder,datetimef);
% %     mag = matfile(FileName, 'Writable', true);
% %     mag.magnitude = handles.w;
% %       %save to image
% %     datetimef = strcat(datetime,'Magnitude.png');
% %     FileName = fullfile(folder,datetimef)
% % % %     a = axes(handles.axes1);    
% % % %     a = getframe(gca)
% % % %     imwrite(a.cdata,FileName)
% % % set(gcf, 'Color', 'none'); %'w'
% % set(gcf, 'Color', 'w');
% % a = handles.axes1;
% % % % set(a, 'Color', 'none'); %'w'
% % b = a.Children;
% %      export_fig(a,FileName,  '-png', '-q101');
% %      set(gcf, 'Color', [0.94 0.94 0.94]);
% %     %screen capture
% %     datetimef = strcat(datetime,'_magnitude.png');
% %     FileName = fullfile(folder,datetimef)
% %     export_fig(FileName,  '-png', '-q101');
 %%%%%%%%%%%%%%%%%%%%%%%%%%
   set(handles.text_Status,'String','ColorMap: Finish'); drawnow;
 end