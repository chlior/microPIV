function updateEdit_Seq(hObject, eventdata, handles , caseIndex)      

switch caseIndex
        case 'Correlation'
          if isfield(handles,'wins')~=1
              SetEdit(hObject, eventdata, handles,64,1,0.5,'single',1,0.5,'yes')        
          else
              SetEdit(hObject, eventdata, handles,handles.wins,handles.deltaT,handles.overlap,handles.method,handles.sizeFactor,handles.fps,handles.display)
          end
        case 'Pixel2Unit'
          if isfield(handles,'mpSeq')~=1
              SetEdit(hObject, eventdata, handles,600,1000,'','','Interpolate',handles.sizeFactor,handles.fps,handles.display)        
          else
              SetEdit(hObject, eventdata, handles, handles.channelWitdh , handles.y_cal,handles.areaLength,handles.x_cal,handles.ChooseConvert,handles.sizeFactor, handles.fps,handles.display)
          end  
        case 'Filtering'
            if isfield(handles,'filterChoose')~=1
               SetEdit(hObject, eventdata, handles,'1,2,3',2.4,1.3,1.2,1,handles.fps,handles.display)
            else
               SetEdit(hObject, eventdata, handles,handles.filterChoose,handles.globtrld,handles.loctrld,handles.snrtrld,handles.sizeFactor,handles.fps,handles.display)
            end
        case 'Interpolate'
        if isfield(handles,'filterChoose')~=1
           SetEdit(hObject, eventdata, handles,1,handles.fps,handles.display)
        else
           SetEdit(hObject, eventdata, handles,handles.sizeFactor,handles.fps,handles.display)
        end
        case 'ColorMap'
            if isfield(handles,'magitudeComponent')~=1
               SetEdit(hObject, eventdata, handles,'m','magnitude','no', handles.sizeFactor,handles.fps,handles.display)
            else
               SetEdit(hObject, eventdata, handles,handles.magitudeComponent, handles.display,  handles.displayVector, handles.sizeFactor,handles.fps,handles.display)
            end
        case 'VelocityProfile'
            if isfield(handles,'AvgVelocity')~=1
               SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh , handles.channelWitdh,handles.fps,handles.display)
            else
               SetEdit(hObject, eventdata, handles, handles.avgComponent , handles.avgDirection , handles.channelWitdh, handles.channelLength,handles.fps,handles.display)
            end
        case 'FlowRate'
            if isfield(handles,'channelHeight')~=1
               SetEdit(hObject, eventdata, handles, handles.channelWitdh ,'200',handles.fps,handles.display)
            else
               SetEdit(hObject, eventdata, handles, handles.channelWidth , handles.channelHeight,handles.fps,handles.display)
            end
        case 'Density'
            if isfield(handles,'densityWinW')~=1
               SetEdit(hObject, eventdata, handles, 200 , 20,handles.fps,handles.display)
            else
               SetEdit(hObject, eventdata, handles, handles.densityWinW , handles.densityWinH,handles.fps,handles.display)
            end
        case 'Streamline'
            if isfield(handles,'streamlineGap')~=1
               SetEdit(hObject, eventdata, handles, 2)
            else
               SetEdit(hObject, eventdata, handles, handles.streamlineGap)
            end
        case 'TimeFunction'
            if isfield(handles,'TimeFunction')~=1
               SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh , 100,'nan',50,'section',4,1,100,handles.fps,handles.display)
            else
               SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh , 100,'nan',50,'section',4,1,100,handles.fps,handles.display)
            end
            
end
end