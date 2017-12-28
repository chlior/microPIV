function Streamline(hObject, eventdata, handles)
hold off

handles.startStreamLine = get(handles.edit1,'string');
handles.streamlineGap = str2num(get(handles.edit2,'string')) %streamGap
handle.streamLevel = str2num(get(handles.edit3,'string'));
timerVal = tic  
% m = handles.mp;
m = handles.mp; %Only for dispaly, there for using Pixels Unit
imshow(handles.image{1});
% 

if strcmp(handles.startStreamLine,'left')
[sx,sy] = meshgrid(m.x(1,handle.streamLevel),m.y(:,1));
streamline(m.x,m.y,m.u,m.v,sx,sy)
elseif strcmp(handles.startStreamLine,'up')
[sx,sy] = meshgrid(m.x(1,:),m.y(handle.streamLevel,1));
streamline(m.x,m.y,m.u,m.v,sx,sy)
else
mstreamline(m.x,m.y,m.u,m.v,handles.streamlineGap);
end

 elapsedTime = toc(timerVal)
 str = sprintf('Finished Correlation , %.2fsec',elapsedTime)
 set(handles.text_Status,'String',str); drawnow;

end