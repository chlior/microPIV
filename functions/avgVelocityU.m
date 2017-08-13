function [handles]=avgVelocityU(hObject, eventdata, handles)
hold off
m = handles.mp;
x = m.x; y = m.y; u = m.u; v = m.v;
channelWidth = handles.channelWitdh;

uTempHor = zeros(1,size(x(1,:),2));
uTempVer = zeros(size(y(:,1),1),1);
row = zeros(size(y(:,1),1),size(x(1,:),2));
colum = zeros(size(y(:,1),1),size(x(1,:),2));


switch handles.avgDirection;
    case 'x'        
    for yi=1:(size(y,1))
     for xi=1:(size(x,2))
       if isnan(u(yi,xi))==0 
        uTempHor(yi) = uTempHor(yi) + u(yi,xi);
       end
     end
     row(yi,:)= ones(1,size(x(1,:),2)).*uTempHor(yi);
    end
    uLineAvg=row./size(x,2);   
    handles.fig=plot(uLineAvg(:,1),y(:,1));  
    uavg = trapz(y(:,1),uLineAvg(:,1))/handles.channelWidth; % u  avrage
     xlabel('Velocity average [um/sec]');
     ylabel('Position [um]');
%      str = sprintf('Avarage Velocity along x.''u'' direction , Uavg= %0.2f [um/sec]' , handles.uavg)
%      title(str); 
     umaxLineAvg= max(max(uLineAvg));
    case 'y'
    
     for xi=1:(size(x,1))
     for yi=1:(size(y,1))
         if isnan(u(yi,xi))==0 
          uTempVer(xi) = uTempVer(xi) +  u(yi,xi);
         end
     end
    colum(:,xi)= ones(size(y(:,1),1),1).*uTempVer(xi);
    end
    uLineAvg=colum./size(y,1);
    handles.fig = plot(x(1,:),uLineAvg(1,:));
    uavg = trapz(y(:,1),uLineAvg(:,1))/channelWidth; % u  avrage
     ylabel('Velocity average [um/sec]');
     xlabel('Position [um]');
%     title('Avarage Velocity along y. ''u'' direction');    
%     umaxLineAvg= max(max(uLineAvg));
umaxLineAvg =0;
end
    
handles.uavg = uavg;
handles.umaxLineAvg = umaxLineAvg;