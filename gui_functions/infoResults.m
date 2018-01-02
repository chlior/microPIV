function infoResults(hObject, eventdata, handles)

strAvgVelocity =  '';
strQ = '';
strVelocityProfile = '';
stMaxMinVelocity = '';
strFlowrate ='';
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

if isfield(handles,'vp')
    vp = handles.vp;
    
    y_avguS='';y_avgvS='';y_avguMS='';y_avgvMS='';y_avguAVG=''; y_avgvAVG='';
    x_avguS='';x_avgvS='';x_avguMS='';x_avgvMS='';x_avguAVG=''; x_avgvAVG ='';
    open =  sprintf('\n>>AvgVelocity(um/s):');
    openy = sprintf('|Y|');
    if isfield(vp,'y_uavgS') y_avguS = sprintf('  [uS: %.2f]  ' ,vp.y_uavgS); end
    if isfield(vp,'y_vavgS') y_avgvS = sprintf('  [vS: %.2f]  ' ,vp.y_vavgS); end
    if isfield(vp,'y_uavgMS') y_avguMS = sprintf('  [uMS: %.2f]  ', mean(vp.y_uavgMS)); end
    if isfield(vp,'y_vavgMS') y_avgvMS = sprintf('  [vMS: %.2f]  ', mean(vp.y_vavgMS)); end
    if isfield(vp,'y_uavgAVG') y_avguAVG = sprintf('  [uAVG: %.2f]  ', vp.y_uavgAVG); end
    if isfield(vp,'y_vavgAVG') y_avgvAVG = sprintf('  [vAVG: %.2f]', vp.y_vavgAVG); end
    openx = sprintf('   |X|');
    if isfield(vp,'x_uavgS') x_avguS = sprintf('  [uS: %.2f]  ' ,vp.x_uavgS); end
    if isfield(vp,'x_vavgS') x_avgvS = sprintf('  [vS: %.2f]  ' ,vp.x_vavgS); end
    if isfield(vp,'x_uavgMS') x_avguMS = sprintf('  [uMS: %.2f]  ', mean(vp.x_uavgMS)); end
    if isfield(vp,'x_vavgMS') x_avgvMS = sprintf('  [vMS: %.2f]  ', mean(vp.x_vavgMS)); end
    if isfield(vp,'x_uavgAVG') x_avguAVG = sprintf('  [uAVG: %.2f]  ', vp.x_uavgAVG); end
    if isfield(vp,'x_vavgAVG') x_avgvAVG = sprintf('  [vAVG: %.2f]', vp.x_vavgAVG); end
   
    flow =  sprintf('\n>>Q(%s,%s)= |%.0f um^3/sec |%.2ful.',vp.direction,vp.component, vp.Q , vp.QL);
    
    strVelocityProfile = strcat(open,openy,y_avguS,y_avgvS,y_avguMS,y_avgvMS,y_avguAVG, y_avgvAVG...
        ,openx,x_avguS,x_avgvS,x_avguMS,x_avgvMS,x_avguAVG, x_avgvAVG   ,flow);
end

if isfield(handles,'fr')
    fr = handles.fr;
    
    QLyuS='';QLyvS='';QLxuS='';QLxvS='';
    QLyuMS='';QLyvMS='';QLxuMS='';QLxvMS='';
    QLyuAVG='';QLyvAVG='';QLxuAVG='';QLxvAVG='';
    
    open =  sprintf('\n>>Flowrate(ul/min):');
%     openy = sprintf('\nY_');
    if isfield(fr,'QL_uyS') QLyuS = sprintf('   Q_S(y,u)=%.2f',fr.QL_uyS); end
    if isfield(fr,'QL_vyS') QLyvS = sprintf('   Q_S(y,v)=%.2f',fr.QL_vyS); end
    if isfield(fr,'QL_uyMS') QLyuMS = sprintf('   Q_MS(y,u)=%.2f',mean(fr.QL_uyMS)); end
    if isfield(fr,'QL_vyMS') QLyvMS = sprintf('   Q_MS(y,v)=%.2f',mean(fr.QL_vyMS)); end
    if isfield(fr,'QL_uyAVG') QLyuAVG = sprintf('   Q_AVG(y,u)=%.2f',fr.QL_uyAVG); end
    if isfield(fr,'QL_vyAVG') QLyvAVG = sprintf('   Q_AVG(y,v)=%.2f',fr.QL_vyAVG); end
%     openx = sprintf('\n_X_');
    if isfield(fr,'QL_uxS') QLxuS = sprintf('   Q_S(x,u)=%.2f',fr.QL_uxS); end
    if isfield(fr,'QL_vxS') QLxvS = sprintf('   Q_S(x,v)=%.2f',fr.QL_vxS); end
    if isfield(fr,'QL_uxMS') QLxuMS = sprintf('   Q_MS(x,u)=%.2f',mean(fr.QL_uxMS)); end
    if isfield(fr,'QL_vxMS') QLxvMS = sprintf('   Q_MS(x,v)=%.2f',mean(fr.QL_vxMS)); end
    if isfield(fr,'QL_uxAVG') QLxuAVG = sprintf('   Q_AVG(x,u)=%.2f',fr.QL_uxAVG); end
    if isfield(fr,'QL_vxAVG') QLxvAVG = sprintf('   Q_AVG(x,v)=%.2f',fr.QL_vxAVG); end
    
    
    strFlowrate = strcat(open,  QLyuS,QLyvS,QLyuMS,QLyvMS,QLyuAVG,QLyvAVG...   
                   ,QLxuS,QLxvS,QLxuMS,QLxvMS,QLxuAVG,QLxvAVG);

end

if isfield(handles,'mp')
m = handles.mp;
umax =max( max(m.u));
vmax =max( max(m.v));
strMaxVelocity = sprintf('>>Max-Min(um/s): Umax = %.0f Vmax = %.0f',umax , vmax);
umin =min( min(m.u));
vmin =min( min(m.v));
strMinVelocity = sprintf('Umin = %.0f  Vmin = %.0f',umin , vmin);
stMaxMinVelocity = [strMaxVelocity,strMinVelocity];
end

str = strcat(stMaxMinVelocity,strVelocityProfile,strFlowrate);
set(handles.text_Results,'String',str);drawnow;   
end

