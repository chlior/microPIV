function infoResults(hObject, eventdata, handles)

strAvgVelocity =  '';
strQ = '';
strVelocityProfile = '';
strMaxVelocity = '';

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
if isfield(handles,'Profile')
    VProfile = handles.Profile;
    open = sprintf('Avrage Velocity at section  %.0f:',VProfile.pos);
    avg = sprintf('%.2f um/sec', VProfile.avg);
    maxInLine = sprintf('\nMax velocity in line = %.2f um/sec.', VProfile.maxInLine);
    direction = sprintf('\nDirection: %s,', VProfile.direction);
    component = sprintf('Componnet: %s.', VProfile.component);

    strVelocityProfile = strcat(open,avg,maxInLine,direction,{'   '},component);
end

if isfield(handles,'mp')
m = handles.mp;
umax =max( max(m.u));
vmax =max( max(m.v));
strMaxVelocity = sprintf('Umax = %.0f, Vmax = %.0f',umax , vmax);
end

str = strcat(strAvgVelocity,strQ,strVelocityProfile,strMaxVelocity)
set(handles.text_Results,'String',str);drawnow;   
end

