function SetText(hObject, eventdata, handles,str1,str2,str3,str4,str5,str6,str7,str8,str9,str10,str11,str12,str13,str14)

% for i=4:nargin
%     str = strcat('handles.text',num2str(i-3))
%     str_text = eval(str)
%     str = strcat('str',num2str(i-3))
%     str_i = eval(str)
%     set(str_text,'String',str_i);drawnow;
% end
nargin
if nargin>=4 set(handles.text1,'String',str1);drawnow; else set(handles.text1,'String','');drawnow;end
if nargin>=5 set(handles.text2,'String',str2);drawnow; else set(handles.text2,'String','');drawnow;end
if nargin>=6 set(handles.text3,'String',str3);drawnow; else set(handles.text3,'String','');drawnow;end
if nargin>=7 set(handles.text4,'String',str4);drawnow; else set(handles.text4,'String','');drawnow;end
if nargin>=8 set(handles.text5,'String',str5);drawnow; else set(handles.text5,'String','');drawnow;end
if nargin>=9 set(handles.text6,'String',str6);drawnow; else set(handles.text6,'String','');drawnow;end
if nargin>=10 set(handles.text7,'String',str7);drawnow; else set(handles.text7,'String','');drawnow;end
if nargin>=11 set(handles.text8,'String',str8);drawnow; else set(handles.text8,'String','');drawnow;end
if nargin>=12 set(handles.text9,'String',str9);drawnow; else set(handles.text9,'String','');drawnow;end
if nargin>=13 set(handles.text10,'String',str10);drawnow; else set(handles.text10,'String','');drawnow;end
if nargin>=14 set(handles.text11,'String',str11);drawnow; else set(handles.text11,'String','');drawnow;end
if nargin>=15 set(handles.text12,'String',str12);drawnow; else set(handles.text12,'String','');drawnow;end
if nargin>=16 set(handles.text13,'String',str13);drawnow; else set(handles.text13,'String','');drawnow;end
if nargin>=17 set(handles.text14,'String',str14);drawnow; else set(handles.text14,'String','');drawnow;end

end