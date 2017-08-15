function [handles] = Interpolate(hObject, eventdata, handles)

handles.sizeFactor = str2num(get(handles.edit1,'string'));
set(handles.text_Status,'String','Wait: Interpolating');drawnow;

m = handles.mFiltering;

[m.u,m.v] = naninterp(m.u,m.v,'linear',handles.maskfile,m.x,m.y);
 set(handles.text_Status,'String','Finished');
 
 cla(handles.axes1);
 imshow(handles.image{1});   hold on; 
 handles.fig=quiver(m.x,m.y,m.u,m.v,handles.sizeFactor); 
 xlabel('pixel'); ylabel('pixel');
 title('Filtered And Interpolated Correlation');
 axis tight
 axis on
 zoom on
 
    %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   datetime = strcat(datetime,'.mat');
   folder  = fullfile(handles.FolderName,'Interpolated');   
   if exist(folder)==0 mkdir(folder); end
   FileName = fullfile(folder,datetime);
    mn = matfile(FileName, 'Writable', true);
    mn.x = m.x;
    mn.y = m.y;
    mn.u = m.u;
    mn.v = m.v;
    mn.snr = m.snr;
    mn.pkh = m.pkh;
    handles.mInterpolate = mn;
    handles.m = m; %Global use;
        
    %save to image
    datetime = strcat(datetime,'.png');
    FileName = fullfile(folder,datetime)
    a = getframe(gca)
    imwrite(a.cdata,FileName)
    
    guidata(hObject, handles)
end