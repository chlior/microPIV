function updateEdit(hObject, eventdata, handles , caseIndex)      

switch caseIndex
        case 1
          if isfield(handles,'wins')~=1
              SetEdit(hObject, eventdata, handles,64,1,0.5,'single',5)        
          else
              SetEdit(hObject, eventdata, handles,handles.wins,handles.deltaT,handles.overlap,handles.method,handles.sizeFactor)
          end

        case 3
            if isfield(handles,'filterChoose')~=1
               SetEdit(hObject, eventdata, handles,'1,2,3',2.4,1.3,1.2,5)
            else
               SetEdit(hObject, eventdata, handles,handles.filterChoose,handles.globtrld,handles.loctrld,handles.snrtrld,handles.sizeFactor)
            end
end
end