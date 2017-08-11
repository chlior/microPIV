function infoData(hObject, eventdata, handles)

if isfield(handles,'wins')
   wins = sprintf('Wins = %d __',handles.wins);
   overlap = sprintf('Overlap = %.2f __',handles.overlap);
   strCorrelation = strcat(wins,overlap);
    set(handles.text_Data,'String',strCorrelation);drawnow;
end

  
end