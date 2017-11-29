function infoResults(hObject, eventdata, handles)

strAvgVelocity =  '';
strQ = '';
strVelocityProfile = '';
strMaxVelocity = '';

% % if isfield(handles,'avgV')
% %     avgV = handles.avgV;
% %     open = sprintf('Avrage Velocity:');
% %     avg = sprintf('%.2f um/sec', avgV.avg);
% %     maxInLine = sprintf('\nMax avg velocity in line = %.2f um/sec.', avgV.maxInLine);
% %     direction = sprintf('\nDirection: %s,', avgV.direction);
% %     component = sprintf('Componnet: %s.', avgV.component);
% % 
% %     strAvgVelocity = strcat(open,avg,maxInLine,direction,{'   '},component);
% % end
if isfield(handles,'Q')
    Q = handles.Q;
    strQ = sprintf('\nFlow Rate = %.2f ul/min,  %.2f um^3/sec',Q.liter , Q.meter);
end
if isfield(handles,'vp')
    vp = handles.vp;
    
    y_avguS='';y_avgvS='';y_avguMS='';y_avgvMS='';y_avguAVG=''; y_avgvAVG='';
    x_avguS='';x_avgvS='';x_avguMS='';x_avgvMS='';x_avguAVG=''; x_avgvAVG ='';
    open =  sprintf('>>AvgVelocity(um/s):');
    openy = sprintf('_Y_');
    if isfield(vp,'y_uavgS') y_avguS = sprintf('  [uS: %.2f]  ' ,vp.y_uavgS); end
    if isfield(vp,'y_vavgS') y_avgvS = sprintf('  [vS: %.2f]  ' ,vp.y_vavgS); end
    if isfield(vp,'y_uavgMS') y_avguMS = sprintf('  [uMS: %.2f]  ', mean(vp.y_uavgMS)); end
    if isfield(vp,'y_vavgMS') y_avgvMS = sprintf('  [vMS: %.2f]  ', mean(vp.y_vavgMS)); end
    if isfield(vp,'y_uavgAVG') y_avguAVG = sprintf('  [uAVG: %.2f]  ', vp.y_uavgAVG); end
    if isfield(vp,'y_vavgAVG') y_avgvAVG = sprintf('  [vAVG: %.2f]', vp.y_vavgAVG); end
    openx = sprintf('\n_X_');
    if isfield(vp,'x_uavgS') x_avguS = sprintf('  [uS: %.2f]  ' ,vp.x_uavgS); end
    if isfield(vp,'x_vavgS') x_avgvS = sprintf('  [vS: %.2f]  ' ,vp.x_vavgS); end
    if isfield(vp,'x_uavgMS') x_avguMS = sprintf('  [uMS: %.2f]  ', mean(vp.x_uavgMS)); end
    if isfield(vp,'x_vavgMS') x_avgvMS = sprintf('  [vMS: %.2f]  ', mean(vp.x_vavgMS)); end
    if isfield(vp,'x_uavgAVG') x_avguAVG = sprintf('  [uAVG: %.2f]  ', vp.x_uavgAVG); end
    if isfield(vp,'x_vavgAVG') x_avgvAVG = sprintf('  [vAVG: %.2f]', vp.x_vavgAVG); end
   
    flow =  sprintf('\n>>Q(%s,%s)=%.0f um^3/sec %.2ful.',vp.direction,vp.component, vp.Q , vp.QL);
    
    strVelocityProfile = strcat(open,openy,y_avguS,y_avgvS,y_avguMS,y_avgvMS,y_avguAVG, y_avgvAVG...
        ,openx,x_avguS,x_avgvS,x_avguMS,x_avgvMS,x_avguAVG, x_avgvAVG   ,flow);
end

if isfield(handles,'mp')
m = handles.mp;
umax =max( max(m.u));
vmax =max( max(m.v));
strMaxVelocity = sprintf('\n>>Max-Min(um/s): [Umax = %.0f] [Vmax = %.0f]',umax , vmax);
umin =min( min(m.u));
vmin =min( min(m.v));
strMinVelocity = sprintf('[Umin = %.0f] [Vmin = %.0f]',umin , vmin);
stMaxMinVelocity = [strMaxVelocity,strMinVelocity];
end

str = strcat(strAvgVelocity,strQ,strVelocityProfile,stMaxMinVelocity)
set(handles.text_Results,'String',str);drawnow;   
end

