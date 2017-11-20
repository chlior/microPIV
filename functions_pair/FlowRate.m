function [handles] = FlowRate(hObject, eventdata, handles)

% [handles.uavg,handles.umaxLineAvg]=avgVelocity(hObject, eventdata, handles);

    handles.channelWidth = str2num(get(handles.edit1,'string'))
    handles.channeHeight = str2num(get(handles.edit2,'string'))
    handles.flowrateChoose = get(handles.edit3,'string')
 hold off   
    vp =handles.vp;
    
switch handles.flowrateChoose
    case 'section'           
        if isfield(handles.vp,'uavgS')   
            Q = vp.uavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
            QL = Q*60*10e-9; % Q [ul/min]
            plot(vp.section,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
            title(sprintf('Flowrate (component %s)[ul/min]',handles.Component)); xlabel('x [um]'); ylabel('[ul/min]');
        else
            uiwait(msgbox('Run VelocityProfile on section analysis first!'));
        end
    case 'multi section'
       if isfield(handles.vp,'uavgMS')
        Q = vp.uavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
        QL = Q*60*10e-9; % Q [ul/min]
        plot(vp.runx,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
        title(sprintf('Flowrate (component %s)[ul/min]',handles.Component)); xlabel('x [um]'); ylabel('[ul/min]');
        else
            uiwait(msgbox('Run VelocityProfile on section analysis first!'));
       end
    case 'avg line'
        Q = vp.uavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
        QL = Q*60*10e-9; % Q [ul/min]
        plot(vp.runx,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
        title(sprintf('Flowrate (component %s)[ul/min]',handles.Component)); xlabel('x [um]'); ylabel('[ul/min]');
    otherwise
                uiwait(msgbox('Write Correctly Which Analysis!')); return;   
end
   



% switch handles.flowrateChoose
%     case 'section'
%         
%     handles.avgDirection = 'x';
%     hand = avgVelocityU(hObject, eventdata, handles)
%     handles = hand;
%     
%     avgV = handles.avgV;
%     Q=avgV.avg*handles.channelWidth*handles.channeHeight
% 
% %   set(handles.flowRateUm,'String',num2str(Q,'%0.2f  um^3/sec  '));
% 
%     Ql=Q*5.999999999999989e-8
%     2
% %   set(handles.flowRateUl,'String',num2str(Q,'%0.2f ul/min'));
%    handles.Q = struct('meter' , Q, 'liter' , Ql);
%    
%    
%     case 'section'
%     
% %     handles.vDirection = 'x';
% %     handles.vComponent = 'u';
% %     hand = VelocityProfileU(hObject, eventdata, handles)
% %     handles = hand;
%     
%     Profile = handles.Profile;
%     Q=Profile.avg*handles.channelWidth*handles.channeHeight
% 
% %   set(handles.flowRateUm,'String',num2str(Q,'%0.2f  um^3/sec  '));
% 
%     Ql=Q*5.999999999999989e-8
%     2
% %   set(handles.flowRateUl,'String',num2str(Q,'%0.2f ul/min'));
%    handles.Q = struct('meter' , Q, 'liter' , Ql);
%         
% end
%    
%    
% end