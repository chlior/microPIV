function [handles] = AvgVelocity(hObject, eventdata, handles)

    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.avgComponent = get(handles.edit1,'string')
    handles.avgDirection = get(handles.edit2,'string')
    handles.channelWidth = str2num(get(handles.edit3,'string'))
    handles.channelLength = str2num(get(handles.edit4,'string'))

    m = handles.mp;

    hold off
    switch handles.avgComponent
        case 'u'
            hand = avgVelocityU(hObject, eventdata, handles)
            handles = hand;
            guidata(hObject , handles)  
        case 'v'
            hand = avgVelocityV(hObject, eventdata, handles)
            handles = hand;
            guidata(hObject , handles)
    end
    
      set(handles.text_Status,'String','Finished'); drawnow;
end
