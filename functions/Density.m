function Density(hObject, eventdata, handles)
hold off  
set(handles.text_Status,'String','Wait: Calculating'); drawnow;


handles.densityWinW = str2num(get(handles.edit1,'string'));
handles.densityWinH = str2num(get(handles.edit2,'string'));

myfun = @(block_struct) ...
   uint8(mean2(block_struct.data)*...
   ones(size(block_struct.data)));
I = blockproc(handles.image{1},[handles.densityWinH handles.densityWinW],myfun);
I = im2double(I);

if isfield(handles,'maskfile')==1
if ischar(handles.maskfile)
    mss=load(handles.maskfile)
    maske=mss.maske
    1
elseif isstruct(handles.maskfile)
    maske= handles.maskfile;
    2 
else
    maske = []
end

for i=1:size(maske,2)
    maskeTemp=maske(i)
    msk =  maskeTemp.msk;
    msk=~msk;
    I = I.*msk;
    i
    clear msk maskeTemp
end
end
imagesc(I);
colormap('jet')
% colormap(flipud(colormap('jet')))
colorbar;
 set(handles.text_Status,'String','Finished');drawnow;