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

    m = handles.mp;
    x = m.x; y = m.y; u = m.u; v = m.v;

switch handles.Component
    case 'u'
        Vnan = u;
    case 'v'
        Vnan = v;    
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
uprofile = nanmean(profile);  
plot(profile,y(:,i),'-o','MarkerSize',3); set(gca, 'ydir', 'reverse');
xlabel(sprintf('Velocity %s[um/sec]',handles.Component)); ylabel('y [um]');
    case 'x'
i = round(size(y,1)*handles.section/100); if i==0 i=1; end        
profile = Vnan(i,:);
vmax = max(profile);
vprofile = nanmean(profile);   
plot(x(i,:),profile,'-o','MarkerSize',3); set(gca, 'ydir', 'reverse');
ylabel(sprintf('Velocity %s[um/sec]',handles.Component)); xlabel('x [um]');
end

% % % % % % % % %         
    case 'multi section'
 
switch handles.Direction
    case 'y'
jump = round(size(x,2)/handles.span);  
j=0;
zeroProfile = (Vnan(:,1).*0);
zeroProfile(zeroProfile==0)=1;
oneProfile = zeroProfile;
zeroProfile = (Vnan(:,1).*0);
gap = max(max(Vnan))+abs(min(min(Vnan)));

for i=1:jump:size(x,2)
zeroProfile = zeroProfile + oneProfile.*gap*j;
profile = Vnan(:,i)+ zeroProfile;

umax = max(profile);
uprofile = nanmean(profile);  
plot(profile,y(:,i),'-o','MarkerSize',3,'LineWidth',3); set(gca, 'ydir', 'reverse'); hold on
plot(zeroProfile,y(:,i),'-r'); hold on
xlabel(sprintf('Velocity trend %s[um/sec]',handles.Component)); ylabel('y [um]');
j = 1;
end

% surf(u,x,y)
% plot3(profile,x(:,i),y(:,i),'-o','MarkerSize',3,'LineWidth',3);
% set(gca, 'zdir', 'reverse'); hold all;  grid on
% set(gca, 'ydir', 'reverse');
% xlabel(sprintf('Velocity %s[um/sec]',handles.Component)); ylabel('x [um]'); zlabel('y [um]');
% legendInfo{j} =[' ' num2str(round(100*i/size(x,2)))]; 

    case 'x'
jump = round(size(y,1)/handles.span);  
j=0;
zeroProfile = (Vnan(size(y,1)/2,:).*0);
zeroProfile(zeroProfile==0)=1;
oneProfile = zeroProfile;
zeroProfile = (Vnan(size(y,1)/2,:).*0);
gap = max(max(Vnan))+abs(min(min(Vnan)));

for i=1:jump:size(y,1)       
zeroProfile = zeroProfile + oneProfile.*gap*j;
profile = Vnan(i,:)+ zeroProfile;

vmax = max(profile);
vprofile = nanmean(profile);  

plot(x(i,:),profile,'-o','MarkerSize',3);  hold on;
plot(x(i,:),zeroProfile,'-r'); hold on
ylabel(sprintf('Velocity trend %s[um/sec]',handles.Component)); xlabel('x [um]');
j = 1;
end

end

% legend(legendInfo)
% % % % % % % % %         
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
plot(vectoravg,y(:,1),'-o','MarkerSize',3); set(gca, 'ydir', 'reverse');
xlabel(sprintf('avg Velocity %s[um/sec]',handles.Component)); ylabel('y [um]');
    case 'x'
for i = 1:size(Vnan,2)
    vectoravg(i) = nanmean(Vnan(:,i));
end
vmax_avg = max(vectoravg);
vavg = nanmean(vectoravg); 
plot(x(1,:),vectoravg,'-o','MarkerSize',3); 
ylabel(sprintf('avg Velocity %s[um/sec]',handles.Component)); xlabel('x [um]');
end
  otherwise
            uiwait(msgbox('Write Correctly Which Data To Convert?')); return;
end
% Plot
title(sprintf('Analysis: %s. Direction: %s. Component: %s.', handles.analysis, handles.Direction, handles.Component))
grid on
set(handles.text_Status,'String','Finished'); drawnow;