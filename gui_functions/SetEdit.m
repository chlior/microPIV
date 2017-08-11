function SetEdit(hObject, eventdata, handles,str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14)

% for i=4:nargin
%     str = strcat('handles.edit',num2str(i-3))
%     str_edit = eval(str)
%     str = strcat('str',num2str(i-3))
%     str_i = eval(str);
%     set(str_edit,'String',str_i);drawnow;
% end        

if nargin>=4 set(handles.edit1,'String',str1);drawnow; else set(handles.edit1,'String','');drawnow;end
if nargin>=5 set(handles.edit2,'String',str2);drawnow; else set(handles.edit2,'String','');drawnow;end
if nargin>=6 set(handles.edit3,'String',str3);drawnow; else set(handles.edit3,'String','');drawnow;end
if nargin>=7 set(handles.edit4,'String',str4);drawnow; else set(handles.edit4,'String','');drawnow;end
if nargin>=8 set(handles.edit5,'String',str5);drawnow; else set(handles.edit5,'String','');drawnow;end
if nargin>=9 set(handles.edit6,'String',str6);drawnow; else set(handles.edit6,'String','');drawnow;end
if nargin>=10 set(handles.edit7,'String',str7);drawnow; else set(handles.edit7,'String','');drawnow;end
if nargin>=11 set(handles.edit8,'String',str8);drawnow; else set(handles.edit8,'String','');drawnow;end
if nargin>=12 set(handles.edit9,'String',str9);drawnow; else set(handles.edit9,'String','');drawnow;end
if nargin>=13 set(handles.edit10,'String',str10);drawnow; else set(handles.edit10,'String','');drawnow;end
if nargin>=14 set(handles.edit11,'String',str11);drawnow; else set(handles.edit11,'String','');drawnow;end
if nargin>=15 set(handles.edit12,'String',str12);drawnow; else set(handles.edit12,'String','');drawnow;end
if nargin>=16 set(handles.edit13,'String',str13);drawnow; else set(handles.edit13,'String','');drawnow;end
if nargin>=17 set(handles.edit14,'String',str14);drawnow; else set(handles.edit14,'String','');drawnow;end

end