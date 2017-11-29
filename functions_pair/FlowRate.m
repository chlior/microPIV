function [handles] = FlowRate(hObject, eventdata, handles)

% [handles.uavg,handles.umaxLineAvg]=avgVelocity(hObject, eventdata, handles);

    handles.channelWidth = str2num(get(handles.edit1,'string'))
    handles.channeHeight = str2num(get(handles.edit2,'string'))
    handles.flowrateChoose = get(handles.edit3,'string')
    handles.Component = get(handles.edit4,'string')%
    handles.Direction = get(handles.edit5,'string')%
 hold off   
    vp =handles.vp;
    
switch handles.flowrateChoose
    %%%%%%%%%%%%%%%%%%%%
    case 'section'        
        if handles.Component=='u' && handles.Direction=='x'          
            if isfield(handles.vp,'x_uavgS')   
                Q = vp.x_uavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.section,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(vp.section,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='v' && handles.Direction=='x' 
            if isfield(handles.vp,'x_vavgS')   
                Q = vp.x_vavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.section,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(vp.section,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='u' && handles.Direction=='y' 
            if isfield(handles.vp,'y_uavgS')   
                Q = vp.y_uavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.section,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(vp.section,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='v' && handles.Direction=='y' 
            if isfield(handles.vp,'y_vavgS')   
                Q = vp.y_vavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.section,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(vp.section,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        end   
    %%%%%%%%%%%%%%%%%%%%%%%%
    case 'multi section'
               
        if handles.Component=='u' && handles.Direction=='x'          
            if isfield(handles.vp,'x_uavgMS')   
                Q = vp.x_uavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.runy,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
              indexmin = find(min(QL) == QL); indexmax = find(max(QL) == QL);
              xmin = vp.runy(indexmin);       xmax = vp.runy(indexmax)
              ymin = QL(indexmin);            ymax = QL(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='v' && handles.Direction=='x' 
            if isfield(handles.vp,'x_vavgMS')   
                Q = vp.x_vavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.runy,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
              indexmin = find(min(QL) == QL); indexmax = find(max(QL) == QL);
              xmin = vp.runy(indexmin);       xmax = vp.runy(indexmax)
              ymin = QL(indexmin);            ymax = QL(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='u' && handles.Direction=='y' 
                       if isfield(handles.vp,'y_uavgMS')   
                Q = vp.y_uavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.runx,QL,'-o','MarkerSize',2,'LineWidth',1);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
              indexmin = find(min(QL) == QL); indexmax = find(max(QL) == QL);
              xmin = vp.runx(indexmin);       xmax = vp.runx(indexmax)
              ymin = QL(indexmin);            ymax = QL(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='v' && handles.Direction=='y' 
             if isfield(handles.vp,'y_vavgMS')   
                Q = vp.y_vavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(vp.runx,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
              indexmin = find(min(QL) == QL); indexmax = find(max(QL) == QL);
              xmin = vp.runx(indexmin);       xmax = vp.runx(indexmax)
              ymin = QL(indexmin);            ymax = QL(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        end  
        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    case 'avg line'

    if handles.Component=='u' && handles.Direction=='x'          
            if isfield(handles.vp,'x_uavgAVG')   
                Q = vp.x_uavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(0,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(0,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='v' && handles.Direction=='x' 
            if isfield(handles.vp,'x_vavgAVG')   
                Q = vp.x_vavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(0,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(0,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='u' && handles.Direction=='y' 
            if isfield(handles.vp,'y_uavgAVG')   
                Q = vp.y_uavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(0,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(0,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        elseif handles.Component=='v' && handles.Direction=='y' 
            if isfield(handles.vp,'y_vavgAVG')   
                Q = vp.y_vavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                QL = Q*60*10e-9; % Q [ul/min]
                plot(0,QL,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(0,QL,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!'));
            end
        end   
        
        
        
    otherwise
                uiwait(msgbox('Write Correctly Which Analysis!')); return;   
end
   