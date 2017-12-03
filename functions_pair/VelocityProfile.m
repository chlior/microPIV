function [handles]=VelocityProfile(hObject, eventdata, handles)

    hold off
    
    set(handles.text_Status,'String','Wait: Calculating...'); drawnow;
    
    handles.Component = get(handles.edit1,'string')
    handles.Direction = get(handles.edit2,'string')
    handles.channelWidth = str2num(get(handles.edit3,'string'))
    handles.areaLength = str2num(get(handles.edit4,'string'))
    handles.nantrld = str2num(get(handles.edit5,'string'))
    handles.section = str2num(get(handles.edit6,'string'))    
    handles.analysis = get(handles.edit7,'string')
    handles.span = str2num(get(handles.edit8,'string'))
    handles.channelHeight = str2num(get(handles.edit9,'string'))
    
    m = handles.mp;
    x = m.x; y = m.y; u = m.u; v = m.v;
 if isfield(handles,'vp')==0  
 vp = struct('component' ,  handles.Component ,'direction',...
    handles.Direction , 'nantrld',handles.nantrld,'section',handles.section);
 else
    vp = handles.vp;
 end
 
    %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetimef = strcat(datetime,'VelocityProfile.mat');
   folder  = fullfile(handles.FolderName,'Converted Data');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetimef);    
    m = matfile(FileName, 'Writable', true);
 
%%%%%%%%%%%%%%%function%%%%%%%%%%%
timerVal = tic  
switch handles.Component
    case 'u'
        Vnan = u;
    case 'v'
        Vnan = v; 
    otherwise
        uiwait(msgbox('Write Correctly Which Component!')); return;
end    
    
switch  handles.analysis
% % % % % % % % %     
    case 'section'
 
Vnan(Vnan == nan) = 0;
switch handles.Direction
    case 'y'
i = round(size(x,2)*handles.section/100); if i==0 i=1; end        
profile = Vnan(:,i);
umax = max(profile);
uavg = nanmean(profile);  
plot(profile,y(:,i),'-o','MarkerSize',3); set(gca, 'ydir', 'reverse');
xlabel(sprintf('Velocity %s[um/sec]',handles.Component)); ylabel('y [um]');
    case 'x'
i = round(size(y,1)*handles.section/100); if i==0 i=1; end        
profile = Vnan(i,:);
umax = max(profile);
uavg = nanmean(profile);   
plot(x(i,:),profile,'-o','MarkerSize',3); set(gca, 'ydir', 'reverse');
ylabel(sprintf('Velocity %s[um/sec]',handles.Component)); xlabel('x [um]');
end

if handles.Component=='u' && handles.Direction=='x'
    vp.x_umaxS = umax; vp.x_uavgS = uavg;
    m.xuAVG = profile;
    m.xxAVG = x(i,:);
elseif handles.Component=='v' && handles.Direction=='x'
    vp.x_vmaxS = umax; vp.x_vavgS = uavg;
    m.xvAVG = profile;
    m.xxAVG = x(i,:);
elseif handles.Component=='u' && handles.Direction=='y'
    vp.y_umaxS = umax; vp.y_uavgS = uavg;
    m.yuAVG = profile;
    m.yyAVG = y(:,i);
elseif handles.Component=='v' && handles.Direction=='y'
    vp.y_maxS = umax; vp.y_avgS = uavg;
    m.yvAVG = profile;
    m.yyAVG = y(:,i);
end
 
% % % % % % % % % % % % % % % % %         
    case 'multi section'
 
switch handles.Direction
    case 'y'
jump = round(size(x,2)/handles.span);  
j=0;k=1;
zeroProfile = (Vnan(:,1).*0);
zeroProfile(zeroProfile==0)=1;
oneProfile = zeroProfile;
zeroProfile = (Vnan(:,1).*0);
gap = max(max(Vnan))+abs(min(min(Vnan)));

for i=1:jump:size(x,2)
zeroProfile = zeroProfile + oneProfile.*gap*j;
profile = Vnan(:,i)+ zeroProfile;

umax(k) = max(Vnan(:,i));
uavg(k) = nanmean(Vnan(:,i)); 
vp.runx(k) = x(round(size(y,1)/2),i);
plot(profile,y(:,i),'-ob','MarkerSize',1,'LineWidth',2); set(gca, 'ydir', 'reverse'); hold on
plot(zeroProfile,y(:,i),'-k'); hold on
xlabel(sprintf('Velocity trend %s[um/sec]',handles.Component)); ylabel('y [um]');
j = 1;k = k+1;
end

% % surf(u,x,y)
% % plot3(profile,x(:,i),y(:,i),'-o','MarkerSize',3,'LineWidth',3);
% % set(gca, 'zdir', 'reverse'); hold all;  grid on
% % set(gca, 'ydir', 'reverse');
% % xlabel(sprintf('Velocity %s[um/sec]',handles.Component)); ylabel('x [um]'); zlabel('y [um]');
% % legendInfo{j} =[' ' num2str(round(100*i/size(x,2)))]; 

    case 'x'
jump = round(size(y,1)/handles.span);  
j=0;k=1;
zeroProfile = (Vnan(round(size(y,1)/2),:).*0);
zeroProfile(zeroProfile==0)=1;
oneProfile = zeroProfile;
zeroProfile = (Vnan(round(size(y,1)/2),:).*0);
gap = max(max(Vnan))+abs(min(min(Vnan)));

for i=1:jump:size(y,1)       
zeroProfile = zeroProfile + oneProfile.*gap*j;
profile = Vnan(i,:)+ zeroProfile;

umax(k) = max(Vnan(i,:));
uavg(k) = nanmean(Vnan(i,:));  
vp.runy(k) = y(i,round(size(x,2)/2));

plot(x(i,:),profile,'-ob','MarkerSize',1,'LineWidth',2);  hold on;
plot(x(i,:),zeroProfile,'-k'); hold on
ylabel(sprintf('Velocity trend %s[um/sec]',handles.Component)); xlabel('x [um]');
j = 1;k = k+1;
end
end

% % if handles.Component=='u'
% %     vp.umaxMS = umax; vp.uavgMS = uavg;
% % else
% %     vp.vmaxMS = umax; vp.vavgMS = uavg; end


if handles.Component=='u' && handles.Direction=='x'
    vp.x_umaxMS = umax; vp.x_uavgMS = uavg;
    m.XxMS = vp.runy;
    m.xuMS = profile;
elseif handles.Component=='v' && handles.Direction=='x'
    vp.x_vmaxMS = umax; vp.x_vavgMS = uavg;
    m.XxMS = vp.runy;
    m.xvMS = profile;
elseif handles.Component=='u' && handles.Direction=='y'
    vp.y_umaxMS = umax; vp.y_uavgMS = uavg;
    m.YyMS = vp.runx;
    m.yuMS = profile;    
elseif handles.Component=='v' && handles.Direction=='y'
    vp.y_maxMS = umax; vp.y_avgMS = uavg;
    m.YyMS = vp.runx;
    m.yvMS = profile;  
end

% legend(legendInfo)
% % % % % % % % % % % % % % % %  

    case 'avg line'

switch handles.Component
    case 'u'
        Vnan = u;
    case 'v'
        Vnan = v;   
        
end
Vnan(Vnan < handles.nantrld) = nan;
switch handles.Direction
    case 'y'
for i = 1:size(Vnan,1)
    vectoravg(i) = nanmean(Vnan(i,:));
end
umax_avg = max(vectoravg);
uavg = nanmean(vectoravg);
m.analysis = 'avg line yu';
plot(vectoravg,y(:,1),'-o','MarkerSize',3); set(gca, 'ydir', 'reverse');
xlabel(sprintf('avg Velocity %s[um/sec]',handles.Component)); ylabel('y [um]');
    case 'x'
for i = 1:size(Vnan,2)
    vectoravg(i) = nanmean(Vnan(:,i));
end
umax_avg = max(vectoravg);
uavg = nanmean(vectoravg); 
plot(x(1,:),vectoravg,'-o','MarkerSize',3); 
ylabel(sprintf('avg Velocity %s[um/sec]',handles.Component)); xlabel('x [um]');
end

if handles.Component=='u'
    vp.umaxAVG = umax_avg; vp.uavgAVG = uavg;
else
    vp.vmaxAVG = umax_avg; vp.vavgAVG = uavg; end


if handles.Component=='u' && handles.Direction=='x'
    vp.x_umaxAVG = umax_avg; vp.x_uavgAVG = uavg;
    m.yuAVG = vectoravg;
    m.xxAVG = x(1,:);
elseif handles.Component=='v' && handles.Direction=='x'
    vp.x_vmaxAVG = umax_avg; vp.x_vavgAVG = uavg;
    m.yvAVG = vectoravg;
    m.xxAVG = x(1,:);
elseif handles.Component=='u' && handles.Direction=='y'
    vp.y_umaxAVG = umax_avg; vp.y_uavgAVG = uavg; 
    m.yuAVG = vectoravg;
    m.yyAVG = y(:,1);
elseif handles.Component=='v' && handles.Direction=='y'
    vp.y_maxAVG = umax_avg; vp.y_avgAVG = uavg;
    m.yvAVG = vectoravg;
    m.yyAVG = y(:,1);
end
% % % % % % % % % % % % % 
  otherwise
            uiwait(msgbox('Write Correctly Which Analysis!')); return;
end

vp.Q = mean(uavg)*handles.channelWidth*handles.channelHeight; % Q [um^3/sec]
vp.QL = vp.Q*60*10e-9; % Q [ul/min]
  
 
handles.vp = vp;
% guidata(hObject , handles) 
    elapsedTime = toc(timerVal)
title(sprintf('Analysis: %s. Direction: %s. Component: %s.', handles.analysis, handles.Direction, handles.Component))
grid on


    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
    
      %save to image
    datetimef = strcat(datetime,'VelocityProfile.png');
    FileName = fullfile(folder,datetimef)
%      set(gcf, 'Color', 'w');
     a = handles.axes1;
     b = a.Children;
     export_fig(a,FileName,  '-png', '-q101');
%      set(gcf, 'Color', [0.94 0.94 0.94]);
    
    %screen capture
     elapsedTime = toc(timerVal)
    datetimef = strcat(datetime,'_VelocityProfile_screen.png');
    FileName = fullfile(folder,datetimef)
    export_fig(FileName,  '-png', '-q101');%
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%
 
 