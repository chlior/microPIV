function [handles]=VelocityProfileU(hObject, eventdata, handles)
hold off
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
%     handles.vComponent = get(handles.edit1,'string')
%     handles.vDirection = get(handles.edit2,'string')
%     handles.channelWidth = str2num(get(handles.edit3,'string'))
%     handles.profilePos = str2num(get(handles.edit4,'string'))

m = handles.mp;
x = m.x; y = m.y; u = m.u; v = m.v;

xi = round(size(x,2)*handles.profilePos/100);
if xi==0 xi=1; end
switch handles.vComponent;
    case 'u' 
    uProfile=u(:,xi);   
    handles.fig=plot(uProfile(:,1),y(:,1));  
    uavg = nansum(uProfile(:,1))/handles.channelWidth % u  avrage
    xlabel('Velocity u[um/sec]');
    ylabel('y [um]');
    umax= max(uProfile);
    handles.Profile = struct('cValues', y(:,1), 'uProfile' , uProfile , 'component' , 'u' ,'direction' , handles.vDirection , 'maxInLine' , umax , 'avg' , uavg, 'pos' , xi);
    guidata(hObject , handles)  
    case 'v'
    vProfile=v(:,xi);   
    handles.fig=plot(vProfile(:,1),y(:,1));  
    vavg = trapz(y(:,1),vProfile(:,1))/handles.channelWidth; % u  avrage
    xlabel('Velocity v [um/sec]');
    ylabel('y [um]');
    vmax= max(vProfile);
    handles.Profile = struct('cValues', y(:,1), 'uProfile' , vProfile , 'component' , 'v' ,'direction' , handles.vDirection , 'maxInLine' , vmax , 'avg' , vavg, 'pos' , xi);
    guidata(hObject , handles)         
end
    set(handles.text_Status,'String','Wait: Finish'); drawnow;