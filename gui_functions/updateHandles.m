function updateHandles(hObject, eventdata, handles, caseIndex)


    switch caseIndex
        case 1
            handles.wins = str2num(get(handles.edit1,'String'))
            handles.deltaT = str2double(get(handles.edit2,'String'))
            handles.overlap = str2double(get(handles.edit3,'String'))
            handles.method = get(handles.edit4,'String')
            handles.sizeFactor = str2double(get(handles.edit5,'String'))
        case 2
        case 3         
            filterChoose = str2num(get(handles.edit1,'string'))
            globtrld = str2num(get(handles.edit2,'string'))
            loctrld = str2num(get(handles.edit3,'string'))
            snrtrld = str2num(get(handles.edit4,'string'))
            sizeFactor = str2num(get(handles.edit5,'string'))
        case 4
            sizeFactor = str2num(get(handles.edit1,'string'))
    end
    guidata(hObject, handles)
end