function [handles] = RunSequence(hObject, eventdata, handles)
if isfield(handles,'maskfile')==0
handles.maskfile=[];
end

if strcmp(handles.functionDir,'Correlation')
    [hand] = Correlation_Seq(hObject, eventdata,handles);
    handles = hand;
    guidata(hObject , handles)    
elseif strcmp(handles.functionDir,'Mask')
    hand = CreateMask(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'Filtering')  
    [hand] = Filtering_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)   
elseif strcmp(handles.functionDir,'Interpolate') 
    hand = Interpolate_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)  
elseif strcmp(handles.functionDir,'Pixel2Unit') 
    hand = pix2unit_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'ColorMap') 
    hand = ColorMap_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
% elseif strcmp(handles.functionDir,'AvgVelocity') 
%     hand = AvgVelocity(hObject, eventdata, handles);
%     handles = hand;
%     guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'FlowRate') 
    hand = FlowRate_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)
elseif strcmp(handles.functionDir,'Density') 
    Density_Seq(hObject, eventdata, handles);
elseif strcmp(handles.functionDir,'Streamline')
    Streamline_Seq(hObject, eventdata, handles);

elseif strcmp(handles.functionDir,'VelocityProfile') 
    hand = VelocityProfile_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'TimeFunction') 
    hand = TimeFunction_Seq(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)     
    
end
infoData(hObject, eventdata, handles)
infoResults(hObject, eventdata, handles)
guidata(hObject, handles)