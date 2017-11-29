function updateEdit(hObject, eventdata, handles , caseIndex)      

switch caseIndex
        case 'Correlation' 
          if isfield(handles,'wins')~=1
              SetEdit(hObject, eventdata, handles,64,1,0.5,'single',1)        
          else
                strWins = []
                for a = transpose(handles.wins)
                    b = cat(2,num2str(transpose(a)),';')
                    strWins = cat(2,strWins,b)
                end
              SetEdit(hObject, eventdata, handles,strWins,handles.deltaT,handles.overlap,handles.method,handles.sizeFactor)
          end
        case 'Filtering'
            if isfield(handles,'filterChoose')~=1
               SetEdit(hObject, eventdata, handles,'1,2,3',2.4,1.3,1.2,handles.sizeFactor)
            else
               SetEdit(hObject, eventdata, handles,handles.filterChoose,handles.globtrld,handles.loctrld,handles.snrtrld,handles.sizeFactor)
            end
        case 'Interpolate'
        if isfield(handles,'filterChoose')~=1
           SetEdit(hObject, eventdata, handles,handles.sizeFactor)
        else
           SetEdit(hObject, eventdata, handles,handles.sizeFactor)
        end
        case 'Pixel2Unit'
        if isfield(handles,'y_cal')~=1
           SetEdit(hObject, eventdata, handles,600,1000,'','','Interpolate',handles.sizeFactor)
        else
           SetEdit(hObject, eventdata, handles, handles.channelWitdh , handles.y_cal,handles.areaLength,handles.x_cal,handles.ChooseConvert,handles.sizeFactor)
        end
        case 'ColorMap'
            if isfield(handles,'magitudeComponent')~=1
               SetEdit(hObject, eventdata, handles,'m','magnitude','no', handles.sizeFactor)
            else
               SetEdit(hObject, eventdata, handles,handles.magitudeComponent, handles.display,  handles.displayVector, handles.sizeFactor)
            end
%         case 'AvgVelocity'
%             if isfield(handles,'AvgVelocity')~=1
%                SetEdit(hObject, eventdata, handles, 'u','x' , handles.channelWitdh , handles.channelWitdh)
%             else
%                SetEdit(hObject, eventdata, handles, handles.avgComponent , handles.avgDirection , handles.channelWitdh, handles.channelLength)
%             end
        case 'FlowRate'
            if isfield(handles,'flowrateChoose')~=1
               SetEdit(hObject, eventdata, handles, handles.channelWitdh ,'200',  handles.analysis, handles.Component , handles.Direction)
            else
               SetEdit(hObject, eventdata, handles, handles.channelWidth , handles.channelHeight, handles.flowrateChoose, handles.Component , handles.Direction)
            end
        case 'Density'
            if isfield(handles,'densityWinW')~=1
               SetEdit(hObject, eventdata, handles, 20 , 20)
            else
               SetEdit(hObject, eventdata, handles, handles.densityWinW , handles.densityWinH)
            end
        case 'Streamline'
            if isfield(handles,'streamlineGap')~=1
               SetEdit(hObject, eventdata, handles, 1)
            else
               SetEdit(hObject, eventdata, handles, handles.streamlineGap)
            end
        case 'VelocityProfile'
            if isfield(handles,'vp')~=1
               SetEdit(hObject, eventdata, handles, 'u','y' , handles.channelWitdh , handles.areaLength, 'nan' , 50, 'multi section' , 4, 1)
            else
               SetEdit(hObject, eventdata, handles, handles.Component , handles.Direction , handles.channelWitdh,...
                   handles.areaLength, handles.nantrld, handles.section, handles.analysis, handles.span,handles.channelHeight)
            end
end
end