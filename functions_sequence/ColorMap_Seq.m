function [handles] = ColorMap(hObject, eventdata,handles)
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
   hold off    
    handles.magitudeComponent = get(handles.edit1,'string')
    handles.analysisDisplay = get(handles.edit2,'string')
    handles.displayVector = get(handles.edit3,'string')    
    handles.sizeFactor = str2double(get(handles.edit4,'String')) 
    handles.noScale =(get(handles.edit5,'string'));
    handles.fps = str2num(get(handles.edit6,'string'));
    handles.display = (get(handles.edit7,'string'));
    handles.guessMinU = str2num(get(handles.edit8,'string'));
    handles.guessMaxU = str2num(get(handles.edit9,'string'));
    handles.sacleColor = get(handles.edit10,'string');
    handles.saveVideo = (get(handles.edit11,'string'));
    
    
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
   datetimef = strcat(datetime,'_colormap.mat');
   folder_mat  = fullfile(folder,'m-file');   
   if exist(folder_mat)==0 mkdir(folder_mat); end
   FileName = fullfile(folder_mat,datetimef)
   mag = matfile(FileName, 'Writable', true);
%    mag = matfile('testm', 'Writable', true);


   %.avi
 if strcmp(handles.saveVideo,'yes')  
   datetimef = strcat('video_',datetime,'.avi');
   folder_vid = fullfile(folder,'video');   
   if exist(folder_vid)==0 mkdir(folder_vid); end
   FileName_vid = fullfile(folder_vid,datetimef)
   
   outputVideo = VideoWriter(FileName_vid);
   handles.fps
   outputVideo.FrameRate = 0.5;%handles.fps;
   outputVideo.Quality=100;
   open(outputVideo)
 end
    timerVal = tic 
    colormap(jet);
    for i=1:handles.seq
%%%%%%%%function%%%%%%

%  m.y = flipud(m.y);
     switch handles.magitudeComponent
        case 'm'
        handles.w= magnitude(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v);
        dw = gradient(handles.w);
        vor = vorticity(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v);
        strTitle = ' Velocity Magnitude';
        mtemp.x = m{1,i}.x; mtemp.y = m{1,i}.y; mtemp.w=handles.w;
        magnitude_m{i} = mtemp;
        gtemp.x = m{1,i}.x; gtemp.y = m{1,i}.y; gtemp.w=dw;
        gradient_m{i} = gtemp;    
        vtemp.x = m{1,i}.x(3:end-2,3:end-2); vtemp.y = m{1,i}.y(3:end-2,3:end-2); vtemp.vor = vor;
        vorticity_m{i} = vtemp;
        case 'u'
        handles.w=magnitude(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v.*0);
        dw = gradient(handles.w);
        strTitle = ' Velocity x component';
        mtemp.x = m{1,i}.x; mtemp.y = m{1,i}.y; mtemp.w=handles.w;
        magnitude_u{i} = mtemp;
        gtemp.x = m{1,i}.x; gtemp.y = m{1,i}.y; gtemp.w=dw;
        gradient_u{i} = gtemp;
        case 'v'
        handles.w=magnitude(m{1,i}.x,m{1,i}.y,m{1,i}.u.*0,m{1,i}.v);
        dw = gradient(handles.w);
        strTitle = ' Velocity y component';
        mtemp.x = m{1,i}.x; mtemp.y = m{1,i}.y; mtemp.w=handles.w;
        magnitude_v{i} = mtemp;
        gtemp.x = m{1,i}.x; gtemp.y = m{1,i}.y; gtemp.w=dw;
        gradient_v{i} = gtemp;
         otherwise
            set(handles.text_Status,'String','Magnitude: fix and run again'); drawnow;
            uiwait(msgbox('Choose correct component')); return;
     end

     
     
     switch handles.analysisDisplay
        case 'magnitude'
            handles.fig = pcolor(m{1,i}.x,m{1,i}.y,handles.w);% drawnow;%, shading flat, colorbar
            set(handles.fig,'edgecolor','none');  
            strTitle = strcat('Magnitude  -',strTitle);
        case 'contour fill'
             handles.fig = contourf(m{1,i}.x,m{1,i}.y,m{1,i}.v);
             strTitle = strcat('Contour fill  -',strTitle);
        case 'gradient contour'
            handles.fig = contour(m{1,i}.x,m{1,i}.y,dw);
            strTitle = strcat('Gradient contour  -',strTitle);
        case 'gradient contour fill'      
            contourf(m{1,i}.x,m{1,i}.y,dw);
            strTitle = strcat('Gradient contour fill -',strTitle);
        case 'gradient fill'           
            handles.fig =  pcolor(m{1,i}.x,m{1,i}.y,dw); %contourf(m.x,m.y,dw);
        case 'vorticity'
            strTitle = 'Vorticity';
            vor = vorticity(m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v);
            pcolor(m{1,i}.x(3:end-2,3:end-2),m{1,i}.y(3:end-2,3:end-2),vor);
            
         otherwise
          uiwait(msgbox('Write Correctly Which Analysis!')); return;            
     end
     
if strcmp(handles.display,'yes')
     
  shading interp %shading interp/flat/faceted 
  ax = gca;  %// get axes handle
  if strcmp(handles.sacleColor,'color')
    set(gca,'Ydir','reverse');   set(ax,'XTickLabel');   set(ax,'YTickLabel'); %// set labels
    arrowCol = [0 0 0];
  else %%if strcmp(handles.sacleColor,'color')
    ax.ColorOrder =   colormap(1-gray(8192).^(1/2.2)); % set(gcf,'renderer','OpenGL'); set(gca,'Ydir','reverse'); 
    arrowCol = [1 0 0];
  end
  xlabel('x [um]'); ylabel('y [um]');
  strTitle = strcat(strTitle,sprintf('#%d-%d',i,i+1));
  title(strTitle);


if strcmp(handles.analysisDisplay,'vorticity')   
      ylabel(colorbar,'Vorticity [1/sec]');
elseif strcmp(handles.analysisDisplay,'gradient contour fill') ||  strcmp(handles.analysisDisplay,'gradient contour') 
      ylabel(colorbar,'Acceleration magnitude [um^2/sec]');
else
      ylabel(colorbar,'Velocity magnitude [um/sec]');      
end
     
a = handles.axes1;
     if i==1
%              colormap(gray(8192).^(1/2.2)); set(gcf,'renderer','OpenGL')
         axis tight;
      
         lim = axis;
%          clim = a.CLim; 
         clim = [handles.guessMinU, handles.guessMaxU];
     end
%     axis on

  switch handles.displayVector
      case 'yes'
         
         if strcmp(handles.noScale,'yes')
             hold on; quiver( m{1,i}.x,m{1,i}.y,m{1,i}.u,m{1,i}.v,handles.sizeFactor,'color',arrowCol);
         else
             normelize = sqrt(m{1,i}.u.^2+m{1,i}.v.^2);
             hold on; quiver( m{1,i}.x,m{1,i}.y,m{1,i}.u./normelize,m{1,i}.v./normelize,handles.sizeFactor,'color',arrowCol);
         end
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
  if strcmp(handles.saveVideo,'yes')
      writeVideo(outputVideo,d); %a.cdata)
  end
end
    end
    
 if  strcmp(handles.display,'yes') && strcmp(handles.saveVideo,'yes')
    close(outputVideo);   end
    elapsedTime = toc(timerVal)
  
    if exist('magnitude_m','var') mag.magnitude_m = magnitude_m; end
    if exist('magnitude_u','var') mag.magnitude_u = magnitude_u; end
    if exist('magnitude_v','var') mag.magnitude_v = magnitude_v; end
    if exist('gradient_m','var') mag.gradient_m = gradient_m; end
    if exist('gradient_u','var') mag.gradient_u = gradient_u; end
    if exist('gradient_v','var') mag.gradient_v = gradient_v; end
    if exist('vorticity_m','var') mag.vorticity_m = vorticity_m; end
    
load gong.mat;
sound(y, 5*Fs);  
recipient = get(handles.edit_email,'String')
sendmail('liorch@mail.tau.ac.il','Correlation complete.')
set(handles.text_Status,'String','ColorMap: Finish'); drawnow;

 end