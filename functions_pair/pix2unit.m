function [handles] = pix2unit(hObject, eventdata, handles)
%Pixels to Units
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%Input:                                                                        %
%location xp,yp in pixels AND velocitys up,vp in pixels,and frame rate of the video. %
%input calibration scale = (pixels length)/(real length [um])                        %
%%%%%%%Output:                                                                       %
% x,u[um] , u,v[um/s]                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_cal = str2double(get(handles.edit1,'String'));
yp_cal = str2double(get(handles.edit2,'String'));
x_cal = str2double(get(handles.edit3,'String'));
xp_cal = str2double(get(handles.edit4,'String'));
ChooseConvert =  get(handles.edit5,'String');
handles.sizeFactor = str2double(get(handles.edit6,'String'));

handles.channelWitdh = y_cal; %for calculations

% if xp_cal==0 || x_cal==0 
%     x_cal = y_cal;
%     xp_cal = yp_cal;
% end


switch ChooseConvert
    case 'Correlation'
        mpix = handles.mCorrelation;
        1
    case 'Filtering'
        if isfield(handles,'mFiltering')
            mpix = handles.mFiltering;
            2
        else
            mpix = handles.mCorrelation;
            1
        end
    case 'Interpolate'
        if isfield(handles,'mInterpolate')
            mpix = handles.mInterpolate;
            3
        elseif isfield(handles,'mFiltering')
            mpix = handles.mFiltering;
            2
        else
            mpix = handles.mCorrelation;
            1
        end
    otherwise
            uiwait(msgbox('Write Correctly Which Data To Convert?')); return;
        
end


xp = mpix.x;
yp = mpix.y;
up = mpix.u;
vp = mpix.v;


cal = Calibration(x_cal, xp_cal, y_cal,  yp_cal);
handles.cal = cal;

x=xp/cal.x;
y=yp/cal.y;
u=up/cal.x;
v=vp/cal.y;

 %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetime = strcat(datetime,'.mat');
   folder  = fullfile(handles.FolderName,'Converted Data');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetime)
    m = matfile(FileName, 'Writable', true);
    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
%     clear m
    handles.mphysical = m;
    handles.mp = m;
        cla(handles.axes1);
    handles.fig=quiver(m.x,m.y,m.u,m.v,handles.sizeFactor);
    xlabel('um'); ylabel('um');
    title('um/sec');
    axis tight
    axis on
    zoom on
    end
