function Streamline(hObject, eventdata, handles)
hold off
handles.streamlineGap = str2num(get(handles.edit1,'string')) %streamGap
% m = handles.mp;
m = handles.m; %Only for dispaly, there for using Pixels Unit

imshow(handles.image{1});
mstreamline(m.x,m.y,m.u,m.v,handles.streamlineGap);
