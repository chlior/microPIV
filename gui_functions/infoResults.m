function infoResults(hObject, eventdata, handles)

strAvgVelocity =  '';
strQ = '';



if isfield(handles,'avgV')
    avgV = handles.avgV;
    open = sprintf('//   Avrage Velocity Along ''');
    direction = sprintf('%s'' ,', avgV.direction);
    component = sprintf('for Componnet %s.   /', avgV.component);
    maxInLine = sprintf('Maximum In Line = %.2f um/sec  and ', avgV.maxInLine);
    avg = sprintf('Avrage Velocity = %.2f um/sec   //', avgV.avg);
    strAvgVelocity = strcat(open,direction,component,maxInLine,avg);
end
if isfield(handles,'Q')
    strQ = sprintf('/   Flow Rate = %d   /',handles.Q)
end

str = strcat(strAvgVelocity,strQ)
set(handles.text_Results,'String',str);drawnow;   
end

