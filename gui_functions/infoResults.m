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
if isfield(handles,'vp')
    vp = handles.vp;
    
    avguS ='';avguMS ='';avguAVG ='';avgvS ='';avgvMS ='';avgvAVG ='';
    open =  sprintf('Avrage Velocity [um/s]:');
    openu = sprintf('_''u''>>');
    if isfield(vp,'uavgS') avguS = sprintf('S: %.2f.' ,vp.uavgS); end
    if isfield(vp,'uavgMS') avguMS = sprintf('MS: %.2f.', mean(vp.uavgMS)); end
    if isfield(vp,'uavgAVG') avguAVG = sprintf('AVG: %.2f.', vp.uavgAVG); end
    openv = sprintf('_''v''>>');
    if isfield(vp,'vavgS') avgvS = sprintf('S: %.2f.', vp.vavgS); end
    if isfield(vp,'vavgMS') avgvMS = sprintf('MS: %.2f.',  mean(vp.vavgMS)); end
    if isfield(vp,'vavgAVG') avgvAVG = sprintf('AVG: %.2f.', vp.vavgAVG); end   
   
    flow =  sprintf('\nQ(%s,%s)=%.0f um^3/sec %.2ful.',vp.direction,vp.component, vp.Q , vp.QL);
    
    strVelocityProfile = strcat(open, openu, avguS,avguMS,avguAVG,openv,avgvS,avgvMS,avgvAVG,flow);
end

if isfield(handles,'mp')
m = handles.mp;
umax =max( max(m.u));
vmax =max( max(m.v));
strMaxVelocity = sprintf('__Umax = %.0f , Vmax = %.0f  um/s',umax , vmax);
end

str = strcat(strAvgVelocity,strQ,strVelocityProfile,strMaxVelocity)
set(handles.text_Results,'String',str);drawnow;   
end

