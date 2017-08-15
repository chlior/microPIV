function infoResults(hObject, eventdata, handles)

strAvgVelocity =  '';
strQ = '';



if isfield(handles,'avgV')
    avgV = handles.avgV;
    open = sprintf('Avrage Velocity:');
    avg = sprintf('%.2f um/sec', avgV.avg);
    maxInLine = sprintf('\nMax avg velocity in line = %.2f um/sec.', avgV.maxInLine);
    direction = sprintf('\nDirection: %s,', avgV.direction);
    component = sprintf('Componnet: %s.', avgV.component);

    strAvgVelocity = strcat(open,avg,maxInLine,direction,{'   '},component);
end
if isfield(handles,'Q')
    Q = handles.Q;
    strQ = sprintf('\nFlow Rate = %.2f ul/min,  %.2f um^3/sec',Q.liter , Q.meter);
end

str = strcat(strAvgVelocity,strQ)
set(handles.text_Results,'String',str);drawnow;   
end

