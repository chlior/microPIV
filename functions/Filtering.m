function [m, handles] = Filtering(hObject, eventdata, handles)
hold off
set(handles.text_Status,'String','Wait: Loading parameters'); drawnow;

handles.filterChoose = str2num(get(handles.edit1,'string'))
handles.globtrld = str2num(get(handles.edit2,'string'))
handles.loctrld = str2num(get(handles.edit3,'string'))
handles.snrtrld = str2num(get(handles.edit4,'string'))
handles.sizeFactor = str2num(get(handles.edit5,'string'))

if isfield(handles,'image')==0
uiwait(msgbox('Load pair of images first!'));
return
end

if isfield(handles,'maskfile')==0
handles.maskfile=[];
end

mCorrelation = handles.mCorrelation;
x = mCorrelation.x; y = mCorrelation.y; u = mCorrelation.u; v = mCorrelation.v; snr = mCorrelation.snr; pkh = mCorrelation.pkh;
 
imshow(handles.image{1});   hold on; 
 set(handles.text_Status,'String','Wait: Filtering');drawnow;
 for choice=handles.filterChoose    
     switch choice
        case 1
            [u,v] = globfilt(x,y,u,v,handles.globtrld);
        case 2
            [u,v] = localfilt(x,y,u,v,handles.loctrld,'median');
        case 3
            [u,v] = snrfilt(x,y,u,v,snr,handles.snrtrld);
     end
 end
 
 handles.fig=quiver(x,y,u,v,handles.sizeFactor); 
 xlabel('pixel');  ylabel('pixel');
 title('Filtered Correlation');
 axis on
 zoom on
 
    %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetime = strcat(datetime,'.mat');
   folder  = fullfile(handles.FolderName,'Filtered_Correlation');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetime)
    m = matfile(FileName, 'Writable', true);
    m.x = x;
    m.y = y;
    m.u = repmat(u,1,1,1);
    m.v = repmat(v,1,1,1);
    m.snr = mCorrelation.snr;
    m.pkh = mCorrelation.pkh;
 
 set(handles.text_Status,'String','Finished');drawnow;
 guidata(hObject, handles)
end