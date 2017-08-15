function [handles] = FlowRate(hObject, eventdata, handles)

% [handles.uavg,handles.umaxLineAvg]=avgVelocity(hObject, eventdata, handles);

    handles.channelWidth = str2num(get(handles.edit1,'string'))
    handles.channeHeight = str2num(get(handles.edit2,'string'))

    handles.avgDirection = 'x';
    hand = avgVelocityU(hObject, eventdata, handles)
    handles = hand;
    
    avgV = handles.avgV;
    Q=avgV.avg*handles.channelWidth*handles.channeHeight

%   set(handles.flowRateUm,'String',num2str(Q,'%0.2f  um^3/sec  '));

    Ql=Q*5.999999999999989e-8
    2
%   set(handles.flowRateUl,'String',num2str(Q,'%0.2f ul/min'));
   handles.Q = struct('meter' , Q, 'liter' , Ql);
end