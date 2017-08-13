function [handles] = FlowRate(hObject, eventdata, handles)

% [handles.uavg,handles.umaxLineAvg]=avgVelocity(hObject, eventdata, handles);

    handles.channelWidth = str2num(get(handles.edit1,'string'))
    handles.channeHeight = str2num(get(handles.edit2,'string'))

    handles.avgDirection = 'x';
    hand = avgVelocityU(hObject, eventdata, handles)
    handles = hand;
    
  Q=handles.uavg*handles.channelWidth*handles.channeHeight
  1
%   set(handles.flowRateUm,'String',num2str(Q,'%0.2f  um^3/sec  '));

  Q=Q*5.999999999999989e-8
    2
%   set(handles.flowRateUl,'String',num2str(Q,'%0.2f ul/min'));
end