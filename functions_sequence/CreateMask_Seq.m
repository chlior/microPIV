function [handles] = CreateMask(hObject, eventdata, handles)

% Construct a questdlg with three options
choice = questdlg('Do you already have a Maskfile?', ...
	'Maskfile','Yes','No','What is Maskfile','Yes');
% Handle response
switch choice
    case 'Yes'
        handles.maskfile = uigetfile('Select mask.mat')         
        if ischar(handles.maskfile)     %two type of mask exist
            mss = load(handles.maskfile)
%             maske = mss.maske
            handles.maskfile = mss.maske;
        elseif isstruct(handles.maskfile) 
%             maske = handles.maskfile;
            2 
        end    
        set(handles.text_Status,'String','Maskfile is loaded');drawnow;
    case 'No'
        choice1 = questdlg('create one','choos your answer','yes','no','no');
        switch choice1
            case 'yes'
               str1 = 'Mark your polygon points with the left mouse button.';
               str2 = 'Double press the middle button when you are finished.';
               str3 = 'Press <BACKSPACE> or <DELETE> to remove the previously selected vertex.';
               str = strcat(str1,str2,str3);
               uiwait(msgbox(str))
               handles.maskfile = maskfunc_Seq(hObject, eventdata, handles)
%              handles.maskfile=maskGui(handles.image{1},'worldco.mat')
               set(handles.text_Status,'String','Maskfile is ready');drawnow;
            case 'no'
               handles.maskfile=[]; 
               set(handles.text_Status,'String','Empty mask');
        end
    case 'What is Maskfile'
        uiwait(msgbox('Maskfile is...'))       
end
guidata(hObject,handles)