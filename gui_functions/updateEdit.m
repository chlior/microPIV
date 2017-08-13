function updateEdit(hObject, eventdata, handles , caseIndex)      

switch caseIndex
        case 1 %Correlation
          if isfield(handles,'wins')~=1
              SetEdit(hObject, eventdata, handles,64,1,0.5,'single',5)        
          else
              SetEdit(hObject, eventdata, handles,handles.wins,handles.deltaT,handles.overlap,handles.method,handles.sizeFactor)
          end
        case 3 %Filtering
            if isfield(handles,'filterChoose')~=1
               SetEdit(hObject, eventdata, handles,'1,2,3',2.4,1.3,1.2,5)
            else
               SetEdit(hObject, eventdata, handles,handles.filterChoose,handles.globtrld,handles.loctrld,handles.snrtrld,handles.sizeFactor)
            end
        case 4 %Interpolation
        if isfield(handles,'filterChoose')~=1
           SetEdit(hObject, eventdata, handles,5)
        else
           SetEdit(hObject, eventdata, handles,handles.sizeFactor)
        end
        case 6 %Magnitude
            if isfield(handles,'magitudeComponent')~=1
               SetEdit(hObject, eventdata, handles,'m')
            else
               SetEdit(hObject, eventdata, handles,handles.magitudeComponent)
            end
        case 7 %AvgVelocity
            if isfield(handles,'AvgVelocity')~=1
               SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh)
            else
               SetEdit(hObject, eventdata, handles, handles.avgComponent , handles.avgDirection)
            end
        case 8 %FlowRate
            if isfield(handles,'channelHeight')~=1
               SetEdit(hObject, eventdata, handles, handles.channelWitdh ,'200')
            else
               SetEdit(hObject, eventdata, handles, handles.channelWidth , handles.channelHeight)
            end
end
end