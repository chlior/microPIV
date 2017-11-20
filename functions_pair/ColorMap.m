function [handles] = ColorMap(hObject, eventdata,handles)
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.magitudeComponent = get(handles.edit1,'string')
    handles.display = get(handles.edit2,'string')
    handles.displayVector = get(handles.edit3,'string')    
    handles.sizeFactor = str2double(get(handles.edit4,'String'))   
    m = handles.mp;

hold off
      colormap(jet);
%  m.y = flipud(m.y);
     switch handles.magitudeComponent
        case 'm'
        handles.w= magnitude(m.x,m.y,m.u,m.v);
        strTitle = ' Velocity Magnitude';
        case 'u'
        handles.w=magnitude(m.x,m.y,m.u,m.v.*0);
        strTitle = ' Velocity x component';
        case 'v'
        handles.w=magnitude(m.x,m.y,m.u.*0,m.v);
        strTitle = ' Velocity y component';
         otherwise
            set(handles.text_Status,'String','Magnitude: fix and run again'); drawnow;
            uiwait(msgbox('Choose correct component')); return;
     end    
%  handles.w = flipud(handles.w); %Note: magnitude function mirror about horizontal axis!
%  m.y = flipud(m.y);
%     m = handles.mp;
% handles.fig = pcolor(m.x,m.y,handles.w);% drawnow;%, shading flat, colorbar

     switch handles.display
        case 'magnitude'
            handles.fig = pcolor(m.x,m.y,handles.w);% drawnow;%, shading flat, colorbar
            set(handles.fig,'edgecolor','none');  
            strTitle = strcat('Magnitude  -',strTitle);
        case 'contour fill'
             handles.fig = contourf(m.x,m.y,m.v);
             strTitle = strcat('Contour fill  -',strTitle);
        case 'gradient contour'
            dw = gradient(handles.w)
            handles.fig = contour(m.x,m.y,dw);
            strTitle = strcat('Gradient contour  -',strTitle);
        case 'gradient contour fill'      
            dw = gradient(handles.w)
            contourf(m.x,m.y,dw);
            strTitle = strcat('Gradient contour fill -',strTitle);
        case 'gradient fill'           
            dw = gradient(handles.w)
            handles.fig =  pcolor(m.x,m.y,dw); %contourf(m.x,m.y,dw);
        case 'vorticity'
            strTitle = 'Vorticity';
            vor = vorticity(m.x,m.y,m.u,m.v);  pcolor(m.x(3:end-2,3:end-2),m.y(3:end-2,3:end-2),vor);
            
         otherwise
          uiwait(msgbox('Write Correctly Which Analysis!')); return;            
     end



  shading interp %shading interp/flat/faceted 
  %// get axes handle
  ax = gca;
  %// set labels
  set(gca,'Ydir','reverse')
   set(ax,'XTickLabel');
   set(ax,'YTickLabel');
   xlabel('x [um]'); ylabel('y [um]');
   title(strTitle);
   
if strcmp(handles.display,'vorticity')   
      ylabel(colorbar,'Vorticity [1/sec]');
%       title('Vorticity');
elseif strcmp(handles.display,'gradient contour fill') ||  strcmp(handles.display,'gradient contour') 
      ylabel(colorbar,'Acceleration magnitude [um^2/sec]');
else
      ylabel(colorbar,'Velocity magnitude [um/sec]');      
end

  switch handles.displayVector
      case 'yes'
         hold on; quiver( m.x,m.y,m.u,m.v,handles.sizeFactor,'color',[0 0 0]);
      case 'no'
  end
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
% %     a = axes(handles.axes1);    
% %     a = getframe(gca)
% %     imwrite(a.cdata,FileName)
% set(gcf, 'Color', 'none'); %'w'
set(gcf, 'Color', 'w');
a = handles.axes1;
% % set(a, 'Color', 'none'); %'w'
b = a.Children;
     export_fig(a,FileName,  '-png', '-q101');
     set(gcf, 'Color', [0.94 0.94 0.94]);
    %screen capture
    datetimef = strcat(datetime,'_magnitude.png');
    FileName = fullfile(folder,datetimef)
    export_fig(FileName,  '-png', '-q101');
 %%%%%%%%%%%%%%%%%%%%%%%%%%
   set(handles.text_Status,'String','ColorMap: Finish'); drawnow;
 end