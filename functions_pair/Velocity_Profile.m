function [handles]=Velocity_Profile(hObject, eventdata, handles)
hold off

    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.vComponent = get(handles.edit1,'string')
    handles.vDirection = get(handles.edit2,'string')
    handles.channelWidth = str2num(get(handles.edit3,'string'))
    handles.profilePos = str2num(get(handles.edit4,'string'))

m = handles.mp;
x = m.x; y = m.y; u = m.u; v = m.v;

xi=handles.profilePos;

switch handles.vDirection;
    case 'x' 
    uProfile=u(:,xi);   
    handles.fig=plot(uProfile(:,1),y(:,1));  
    uavg = trapz(y(:,1),uProfile(:,1))/handles.channelWidth; % u  avrage
     xlabel('Velocity average [um/sec]');
     ylabel('Position [um]');
     umaxuProfile= max(uProfile);
%     handles.uProfile = struct('cValues', y(:,1), 'avgValues' , uLineAvg(:,1) , 'component' , 'u' ,'direction' , handles.avgDirection , 'maxInLine' , umaxLineAvg , 'avg' , uavg);
    
    case 'y'
    
        uProfile=v(:,xi);   
    handles.fig=plot(uProfile(:,1),x(:,1));  
    uavg = trapz(x(:,1),uProfile(:,1))/handles.channelWidth; % u  avrage
     xlabel('Velocity average [um/sec]');
     ylabel('Position [um]');
     umaxuProfile= max(uProfile);

handles.avgV = struct('cValues', x(1,:), 'avgValues' , uLineAvg(1,:) , 'component' , 'u' ,'direction' , handles.avgDirection , 'maxInLine' , umaxLineAvg , 'avg' , uavg);
end