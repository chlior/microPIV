function [handles] = Magnitude(hObject, eventdata,handles)
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.magitudeComponent = get(handles.edit1,'string')
    m = handles.mp;
    
hold off
%  m.y = flipud(m.y);
     switch handles.magitudeComponent
        case 'm'
        handles.w=magnitude(m.x,m.y,m.u,m.v);
        strTitle = 'Velocity magnitude';
        case 'u'
        handles.w=magnitude(m.x,m.y,m.u,m.v.*0);
        strTitle = 'Velocity x component';
        case 'v'
        handles.w=magnitude(m.x,m.y,m.u.*0,m.v);
        strTitle = 'Velocity y component';
         otherwise
            set(handles.text_Status,'String','Magnitude: fix and run again'); drawnow;
            uiwait(msgbox('Choose correct component')); return;
     end    
%  handles.w = flipud(handles.w); %Note: magnitude function mirror about horizontal axis!
%  m.y = flipud(m.y);
%     m = handles.mp;
handles.fig = pcolor(m.x,m.y,handles.w);% drawnow;%, shading flat, colorbar

  set(handles.fig,'edgecolor','none');
  colormap(jet);
  ylabel(colorbar,'Velocity magnitude [um/sec]');
  shading flat %shading interp/flat/faceted 
  %// get axes handle
  ax = gca;
  %// set labels
  set(gca,'Ydir','reverse')
   set(ax,'XTickLabel');
   set(ax,'YTickLabel');
   xlabel('x [um]'); ylabel('y [um]');
   title(strTitle);
  set(handles.text_Status,'String','Magnitude: Finish'); drawnow;
  
   %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetimef = strcat(datetime,'magnitude.mat');
   folder  = fullfile(handles.FolderName,'Converted Data');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetimef);
    mag = matfile(FileName, 'Writable', true);
    mag.magnitude = handles.w;
      %save to image
    datetimef = strcat(datetime,'Magnitude.png');
    FileName = fullfile(folder,datetimef)
    a = getframe(gca)
    imwrite(a.cdata,FileName)
    %screen capture
    datetimef = strcat(datetime,'_magnitude.png');
    FileName = fullfile(folder,datetimef)
    export_fig(FileName,  '-png', '-q101');
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 end