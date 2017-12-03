function [handles] = FlowRate(hObject, eventdata, handles)

% [handles.uavg,handles.umaxLineAvg]=avgVelocity(hObject, eventdata, handles);

    handles.channelWidth = str2num(get(handles.edit1,'string'))
    handles.channeHeight = str2num(get(handles.edit2,'string'))
    handles.analysis = get(handles.edit3,'string')
    handles.Component = get(handles.edit4,'string')%
    handles.Direction = get(handles.edit5,'string')%
 hold off   
    vp =handles.vp;
    
        %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetimef = strcat(datetime,'Flowrate.mat');
   folder  = fullfile(handles.FolderName,'Converted Data');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetimef);    
    m = matfile(FileName, 'Writable', true);

    timerVal = tic  
switch handles.analysis
    %%%%%%%%%%%%%%%%%%%%
    case 'section'        
        if handles.Component=='u' && handles.Direction=='x'          
            if isfield(handles.vp,'x_uavgS')   
                fr.Q_uxS = vp.x_uavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_uxS = fr.Q_uxS*60*10e-9; % Q [ul/min]
                plot(fr.QL_uxS,vp.section,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); ylabel('y [um]'); xlabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_uxS)];
                text(fr.QL_uxS,vp.section,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='v' && handles.Direction=='x' 
            if isfield(handles.vp,'x_vavgS')   
                fr.Q_vxS = vp.x_vavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_vxS = fr.Q_vxS*60*10e-9; % Q [ul/min]
                plot(fr.QL_vxS,vp.section,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); ylabel('y [um]'); xlabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(QL)];
                text(fr.QL_vxS,vp.section,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='u' && handles.Direction=='y' 
            if isfield(handles.vp,'y_uavgS')   
                fr.Q_uyS = vp.y_uavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_uyS = fr.Q_uyS*60*10e-9; % Q [ul/min]
                plot(vp.section,fr.QL_uyS,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_uyS)];
                text(vp.section,fr.QL_uyS,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='v' && handles.Direction=='y' 
            if isfield(handles.vp,'y_vavgS')   
                fr.Q_vyS = vp.y_vavgS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_vyS = fr.Q_vyS*60*10e-9; % Q [ul/min]
                plot(vp.section,fr.QL_vyS,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_vyS)];
                text(vp.section,fr.QL_vyS,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        end   
    %%%%%%%%%%%%%%%%%%%%%%%%
    case 'multi section'
               
        if handles.Component=='u' && handles.Direction=='x'          
            if isfield(handles.vp,'x_uavgMS')   
                fr.Q_uxMS = vp.x_uavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_uxMS = fr.Q_uxMS*60*10e-9; % Q [ul/min]
                plot(fr.QL_uxMS,vp.runy,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); ylabel('y [um]'); xlabel('[ul/min]');
              indexmin = find(min(fr.QL_uxMS) == fr.QL_uxMS); indexmax = find(max(fr.QL_uxMS) == fr.QL_uxMS);
              xmin = vp.runy(indexmin);       xmax = vp.runy(indexmax)
              ymin = fr.QL_uxMS(indexmin);            ymax = fr.QL_uxMS(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='v' && handles.Direction=='x' 
            if isfield(handles.vp,'x_vavgMS')   
                fr.Q_vxMS = vp.x_vavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_vxMS = fr.Q_vxMS*60*10e-9; % Q [ul/min]
                plot(fr.QL_vxMS,vp.runy,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); ylabel('y [um]'); xlabel('[ul/min]');
              indexmin = find(min(fr.QL_vxMS) == fr.QL_vxMS); indexmax = find(max(fr.QL_vxMS) == fr.QL_vxMS);
              xmin = vp.runy(indexmin);       xmax = vp.runy(indexmax)
              ymin = fr.QL_vxMS(indexmin);            ymax = fr.QL_vxMS(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='u' && handles.Direction=='y' 
                       if isfield(handles.vp,'y_uavgMS')   
                fr.Q_uyMS = vp.y_uavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_uyMS = fr.Q_uyMS*60*10e-9; % Q [ul/min]
                plot(vp.runx,fr.QL_uyMS,'-o','MarkerSize',2,'LineWidth',1);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
              indexmin = find(min(fr.QL_uyMS) == fr.QL_uyMS); indexmax = find(max(fr.QL_uyMS) == fr.QL_uyMS);
              xmin = vp.runx(indexmin);       xmax = vp.runx(indexmax)
              ymin = fr.QL_uyMS(indexmin);            ymax = fr.QL_uyMS(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='v' && handles.Direction=='y' 
             if isfield(handles.vp,'y_vavgMS')   
                fr.Q_vyMS = vp.y_vavgMS.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_vyMS = fr.Q_vyMS*60*10e-9; % Q [ul/min]
                plot(vp.runx,fr.QL_vyMS,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
              indexmin = find(min(fr.QL_vyMS) == fr.QL_vyMS); indexmax = find(max(fr.QL_vyMS) == fr.QL_vyMS);
              xmin = vp.runx(indexmin);       xmax = vp.runx(indexmax)
              ymin = fr.QL_vyMS(indexmin);            ymax = fr.QL_vyMS(indexmax);
                text(xmin,ymin,sprintf('Min %.2d',ymin),'HorizontalAlignment','center','FontSize',12);
                text(xmax,ymax,sprintf('Max %.2d',ymax),'HorizontalAlignment','center','FontSize',12);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        end  
        

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    case 'avg line'

    if handles.Component=='u' && handles.Direction=='x'          
            if isfield(handles.vp,'x_uavgAVG')   
                fr.Q_uxAVG = vp.x_uavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_uxAVG = fr.Q_uxAVG*60*10e-9; % Q [ul/min]
                plot(fr.QL_uxAVG,0,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); ylabel('y [um]'); xlabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_uxAVG)];
                text(fr.QL_uxAVG,0,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='v' && handles.Direction=='x' 
            if isfield(handles.vp,'x_vavgAVG')   
                fr.Q_vxAVG = vp.x_vavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_vxAVG = fr.Q_vxAVG*60*10e-9; % Q [ul/min]
                plot(fr.QL_vxAVG,0,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); ylabel('y [um]'); xlabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_vxAVG)];
                text(fr.QL_vxAVG,0,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='u' && handles.Direction=='y' 
            if isfield(handles.vp,'y_uavgAVG')   
                fr.Q_uyAVG = vp.y_uavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_uyAVG = fr.Q_uyAVG*60*10e-9; % Q [ul/min]
                plot(0,fr.QL_uyAVG,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_uyAVG)];
                text(0,fr.QL_uyAVG,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        elseif handles.Component=='v' && handles.Direction=='y' 
            if isfield(handles.vp,'y_vavgAVG')   
                fr.Q_vyAVG = vp.y_vavgAVG.*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
                fr.QL_vyAVG = fr.Q_vyAVG*60*10e-9; % Q [ul/min]
                plot(0,fr.QL_vyAVG,'-o','MarkerSize',3,'LineWidth',3);% set(gca, 'ydir', 'reverse');
                title(sprintf('Flowrate (component %s,direction %s)[ul/min]',handles.Component, handles.Direction)); xlabel('x [um]'); ylabel('[ul/min]');
                tex = ['   \leftarrow ',num2str(fr.QL_vyAVG)];
                text(0,fr.QL_vyAVG,tex);
            else
                uiwait(msgbox('Run VelocityProfile on section analysis first!')); return;
            end
        end   
        
        
        
    otherwise
                uiwait(msgbox('Write Correctly Which Analysis!')); return;   
end

handles.fr = fr;

%%%%%%%%%%%%
    elapsedTime = toc(timerVal)
str = sprintf('Finished, %.2fsec',elapsedTime)
set(handles.text_Status,'String',str); drawnow;



     
         %screen capture
    datetimef = strcat(datetime,'_pix2unit_screen.png');
    FileName = fullfile(folder,datetimef)
    export_fig(FileName,  '-png', '-q101');%
 %%%%%%%%%%%%%%%%%%%%%%%%%%

    
      %save to image
    datetimef = strcat(datetime,'Flowrate.png');
    FileName = fullfile(folder,datetimef)
%      set(gcf, 'Color', 'w');
     a = handles.axes1;
     b = a.Children;
     export_fig(a,FileName,  '-png', '-q101');
%      set(gcf, 'Color', [0.94 0.94 0.94]);
    
    %screen capture
    datetimef = strcat(datetime,'_Flowrate_screen.png');
    FileName = fullfile(folder,datetimef)
    export_fig(FileName,  '-png', '-q101');%
   