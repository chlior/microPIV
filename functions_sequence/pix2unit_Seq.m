function [handles] = pix2unit(hObject, eventdata, handles)
%Pixels to Units
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Input:                                                                        %
%location xp,yp in pixels AND velocitys up,vp in pixels,and frame rate of the video. %
%input calibration scale = (pixels length)/(real length [um])                        %
%%%%%%%Output:                                                                       %
% x,u[um] , u,v[um/s]                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_cal = str2double(get(handles.edit1,'String'));
xp_cal = str2double(get(handles.edit2,'String'));
y_cal = str2double(get(handles.edit3,'String'));
yp_cal = str2double(get(handles.edit4,'String'));
ChooseConvert =  get(handles.edit5,'String');
handles.sizeFactor = str2double(get(handles.edit6,'String'));
handles.fps = str2double(get(handles.edit7,'String'))
handles.display = get(handles.edit8,'String')

handles.channelWitdh = y_cal; %for calculations

switch ChooseConvert
    case 'Correlation'
        mpix = handles.mSeqCorrelation;
        1
    case 'Filtering'
        if isfield(handles,'mFiltering')
            mpix = handles.mSeqFiltering;
            2
        else
            mpix = handles.mSeqCorrelation;
            1
        end
    case 'Interpolate'
        if isfield(handles,'mInterpolate')
            mpix = handles.mSeqInterpolate;
            3
        elseif isfield(handles,'mFiltering')
            mpix = handles.mSeqFiltering;
            2
        else
            mpix = handles.mSeqCorrelation;
            1
        end
    otherwise
            uiwait(msgbox('Write Correctly Which Data To Convert?')); return;
        
end


% xp = mpix{1,1}.x;
% yp = mpix{1,1}.y;
% up = mpix{1,1}.u;
% vp = mpix{1,1}.v;


cal = Calibration_Seq(x_cal, xp_cal, y_cal,  yp_cal);
handles.cal = cal;





   %Save
   folder  = fullfile(handles.FolderName,'Converted Data_Seq','Correlation');  
      if exist(folder)==0 mkdir(folder); end
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 


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

x{i}=mpix{1,1}.x/cal.x;
y{i}=mpix{1,1}.y/cal.y;
u{i}=mpix{1,i}.u/cal.x;
v{i}=mpix{1,i}.v/cal.y;   

   %.mat  
   datetimef = strcat(datetime,sprintf('#%d-%d.mat',i,i+1));
   folder_mat  = fullfile(folder,'m-file');   
   if exist(folder_mat)==0 mkdir(folder_mat); end
   FileName = fullfile(folder_mat,datetimef)
%    FileNameSeq = fullfile(FileName,i);
    m = matfile(FileName, 'Writable', true);
    m.x = x{1,1};
    m.y = y{1,1};
    m.u = u{1,i};
    m.v = v{1,i};
    mSeqPix2unit{i} = m;
%     clear m 
    
 if strcmp(handles.display,'yes')
    cla(handles.axes1);
    set(handles.text_Status,'String','Wait: Plot Data'); drawnow;
    handles.fig = quiver(m.x,m.y,m.u,m.v,handles.sizeFactor);
    xlabel('x [um]'); ylabel('y [um]');
    title(sprintf('Velocity field [um/sec] # %d-%d ',i ,i+1 ));
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
   
    a = handles.axes1;
    d = export_fig(a,FileNameSeqIm,  '-png', '-q101');    
    writeVideo(outputVideo,d); %a.cdata)
    end
    end
     if strcmp(handles.display,'yes')  
    close(outputVideo);
     else   
    handles.fig=quiver(m.x,m.y,m.u,m.v,handles.sizeFactor);
    title(sprintf('Velocity field [um/sec] example '));    
     end
    elapsedTime = toc(timerVal)


    clear m
    handles.mSeqPix2unit = mSeqPix2unit;
    handles.mpSeq = mSeqPix2unit; %Global use;


 
 %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    str = sprintf('Finished Converting The Data , %.2fsec',elapsedTime)
    set(handles.text_Status,'String',str); drawnow;

    end
