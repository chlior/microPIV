function [handles] = Magnitude(hObject, eventdata,handles)
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.magitudeComponent = get(handles.edit1,'string')
    m = handles.mp;
    
hold off
     switch handles.magitudeComponent
        case 'm'
        handles.w=magnitude(m.x,m.y,m.u,m.v);
        case 'u'
        handles.w=magnitude(m.x,m.y,m.u,m.v.*0);
        case 'v'
        handles.w=magnitude(m.x,m.y,m.u.*0,m.v);
     end    
handles.w = flipud(handles.w); %Note: magnitude function mirror about horizontal axis!
handles.fig = pcolor(m.x,m.y,handles.w);% drawnow;%, shading flat, colorbar

  set(handles.fig,'edgecolor','none');
  colormap(jet);
  ylabel(colorbar,'Velocity magnitude [um/sec]');
  shading flat %shading interp/flat/faceted 
  %// get axes handle
  ax = gca;
  %// set labels
   set(ax,'XTickLabel');
   set(ax,'YTickLabel');
   xlabel('[um]'); ylabel('[um]');
 end