function [handles] = RunPair(hObject, eventdata, handles)
if isfield(handles,'maskfile')==0
handles.maskfile=[];
end

if strcmp(handles.functionDir,'Correlation')
    [hand] = Correlation(hObject, eventdata,handles);
    handles = hand;
    guidata(hObject , handles)    
elseif strcmp(handles.functionDir,'Mask')
    hand = CreateMask(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'Filtering')  
    [hand] = Filtering(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)   
elseif strcmp(handles.functionDir,'Interpolate') 
    hand = Interpolate(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)  
elseif strcmp(handles.functionDir,'Pixel2Unit') 
    hand = pix2unit(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'ColorMap') 
    hand = ColorMap(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'AvgVelocity') 
    hand = AvgVelocity(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'FlowRate') 
    hand = FlowRate(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)
elseif strcmp(handles.functionDir,'Density') 
    Density(hObject, eventdata, handles);
elseif strcmp(handles.functionDir,'Streamline')
    Streamline(hObject, eventdata, handles);

elseif strcmp(handles.functionDir,'VelocityProfile') 
    hand = VelocityProfile(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
end
infoData(hObject, eventdata, handles)
infoResults(hObject, eventdata, handles)
guidata(hObject, handles)