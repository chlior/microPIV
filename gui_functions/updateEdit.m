function updateEdit(hObject, eventdata, handles , caseIndex)      

switch caseIndex
        case 'Correlation'
          if isfield(handles,'wins')~=1
              SetEdit(hObject, eventdata, handles,64,1,0.5,'single',5)        
          else
              SetEdit(hObject, eventdata, handles,handles.wins,handles.deltaT,handles.overlap,handles.method,handles.sizeFactor)
          end
        case 'Filtering'
            if isfield(handles,'filterChoose')~=1
               SetEdit(hObject, eventdata, handles,'1,2,3',2.4,1.3,1.2,5)
            else
               SetEdit(hObject, eventdata, handles,handles.filterChoose,handles.globtrld,handles.loctrld,handles.snrtrld,handles.sizeFactor)
            end
        case 'Interpolation'
        if isfield(handles,'filterChoose')~=1
           SetEdit(hObject, eventdata, handles,5)
        else
           SetEdit(hObject, eventdata, handles,handles.sizeFactor)
        end
        case 'Magnitude'
            if isfield(handles,'magitudeComponent')~=1
               SetEdit(hObject, eventdata, handles,'m')
            else
               SetEdit(hObject, eventdata, handles,handles.magitudeComponent)
            end
        case 'AvgVelocity'
            if isfield(handles,'AvgVelocity')~=1
               SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh , handles.channelWitdh)
            else
               SetEdit(hObject, eventdata, handles, handles.avgComponent , handles.avgDirection , handles.channelWitdh, handles.channelLength)
            end
        case 'FlowRate'
            if isfield(handles,'channelHeight')~=1
               SetEdit(hObject, eventdata, handles, handles.channelWitdh ,'200')
            else
               SetEdit(hObject, eventdata, handles, handles.channelWidth , handles.channelHeight)
            end
        case 'Density'
            if isfield(handles,'densityWinW')~=1
               SetEdit(hObject, eventdata, handles, 200 , 20)
            else
               SetEdit(hObject, eventdata, handles, handles.densityWinW , handles.densityWinH)
            end
        case 'Streamline'
            if isfield(handles,'streamlineGap')~=1
               SetEdit(hObject, eventdata, handles, 2)
            else
               SetEdit(hObject, eventdata, handles, handles.streamlineGap)
            end
        case 'Velocity_Profile'
            if isfield(handles,'velocity_profile')~=1
               SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh , 30)
            else
               SetEdit(hObject, eventdata, handles, handles.vComponent , handles.vDirection , handles.channelWitdh, handles.profilePos)
            end
end
end