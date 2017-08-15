function [handles]=avgVelocityU(hObject, eventdata, handles)
hold off
m = handles.mp;
x = m.x; y = m.y; u = m.u; v = m.v;
channelWidth = handles.channelWitdh;
channelLength = handles.channelLength;
%  x: duplicated raws of x. size of raws is y size.
%          x
%  19.2  38.4 57.6 76.8
%  19.2  38.4 57.6 76.8
%  19.2  38.4 57.6 76.8     y
%  19.2  38.4 57.6 76.8

% y: duplicated colums of y. size of colums is x size.
%         x
% 19.2 19.2 19.2 19.2
% 38.4 38.4 38.4 38.4
% 57.6 57.6 57.6 57.6   y
% 46.8 46.8 46.8 46.8


uTempHor = zeros(1,size(x(1,:),2));    %        x
                                       % 0   0   0   0
                                       
uTempVer = zeros(size(y(:,1),1),1);    % 0      
                                       % 0
                                       % 0   y
                                       % 0 
                                       
row = zeros(size(x));    %Matrix of y different raws of duplicated colums of avg veloxity.  same size as x.
colum = zeros(size(x));


switch handles.avgDirection;
    case 'x'      % Avarage line along x   
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
    
    handles.avgV = struct('cValues', y(:,1), 'avgValues' , uLineAvg(:,1) , 'component' , 'u' ,'direction' , handles.avgDirection , 'maxInLine' , umaxLineAvg , 'avg' , uavg);
    
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
    uavg = trapz(y(:,1),uLineAvg(:,1))/channelLength; % u  avrage
     ylabel('Velocity average [um/sec]');
     xlabel('Position [um]');
%     title('Avarage Velocity along y. ''u'' direction');    
    umaxLineAvg= max(max(uLineAvg));


handles.avgV = struct('cValues', x(1,:), 'avgValues' , uLineAvg(1,:) , 'component' , 'u' ,'direction' , handles.avgDirection , 'maxInLine' , umaxLineAvg , 'avg' , uavg);
end
    
% handles.uavg = uavg;
% handles.umaxLineAvg = umaxLineAvg;