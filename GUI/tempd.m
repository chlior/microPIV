headWidth = 8;
headLength = 8;
LineLength = 0.08;

%some data
[x,y] = meshgrid(0:1:2,0:1:2);
u = 1.*y;
v = 1.*y;

%quiver plots
figure('Position',[10 10 1000 600],'Color','w');
hax_1 = subplot(1,2,1);
hq = quiver(x,y,u,v,1);           %get the handle of quiver
title('Regular Quiver plot','FontSize',16);
hq.Color = 'r';
hq.MaxHeadSize = 1000;
%get the data from regular quiver
U = hq.UData;
V = hq.VData;
X = hq.XData;
Y = hq.YData;


%right version (with annotation)
hax_2 = subplot(1,2,2);
%hold on;
for ii = 1:length(X)
    for ij = 1:length(X)

        headWidth = 5;
        ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[X(ii,ij) Y(ii,ij) LineLength*U(ii,ij) LineLength*V(ii,ij)]);

    end
end
%axis off;
title('Quiver - annotations ','FontSize',16);

linkaxes([hax_1 hax_2],'xy');