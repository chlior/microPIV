function varargout = microPIV(varargin)
% MICROPIV MATLAB code for microPIV.fig
%      MICROPIV, by itself, creates a new MICROPIV or raises the existing
%      singleton*.
%
%      H = MICROPIV returns the handle to a new MICROPIV or the handle to
%      the existing singleton*.
%
%      MICROPIV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MICROPIV.M with the given input arguments.
%
%      MICROPIV('Property','Value',...) creates a new MICROPIV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before microPIV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to microPIV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
addpath('../functions_pair')
addpath('../functions_sequence')
addpath('../gui_functions')
addpath('../gui_functions_sequence')
addpath('../additional_functions')
addpath('../additional_functions/altmany-export_fig-f13ef82')
addpath('../MatPIV')    
set(0,'defaulttextinterpreter','latex')
% Edit the above text to modify the response to help microPIV

% Last Modified by GUIDE v2.5 18-Nov-2017 14:49:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @microPIV_OpeningFcn, ...
                   'gui_OutputFcn',  @microPIV_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before microPIV is made visible.
function microPIV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to microPIV (see VARARGIN)

% Choose default command line output for microPIV
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes microPIV wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.text_Status,'String','Choose Saving Path First'); drawnow;
doc = funDoc();
set(handles.text_Information,'String',doc.Open); drawnow;
set(handles.ListboxPair,'Enable','off'); 
set(handles.ListboxSequence,'Enable','off');
set(handles.ListboxVideo,'Enable','off');

username = 'micropivgui@gmail.com' % email set BEGIN
password = '1234micropivgui1234'
stmp_server = 'smtp.gmail.com'
email = 'micropivgui@gmail.com'
setpref('Internet','SMTP_Server',stmp_server);
setpref('Internet','E_mail',email);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');
setpref('Internet', 'SMTP_Username', username);
setpref('Internet', 'SMTP_Password', password); % email set END

% handlesReset = handles;
handles.reset = handles;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = microPIV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in ListboxPair.
function ListboxPair_Callback(hObject, eventdata, handles)
% hObject    handle to ListboxPair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListboxPair contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListboxPair

handles.islist = 1;
resetEdit(hObject, eventdata, handles)
resetText(hObject, eventdata, handles)
doc = funDoc();
val = get(handles.ListboxPair, 'string'); % Determine the selected data set.
str = get(handles.ListboxPair, 'Value');
handles.functionDir = char(val(str));

switch char(val(str))
    case 'Correlation'
        set(handles.text_Information,'String',doc.Correlation);drawnow;
        if fieldCheck(hObject, eventdata, handles, char(val(str)))==1 return; end
        SetText(hObject, eventdata, handles,'Window Size','Time Gap','Overlap','Method','SizeFactor')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Mask' 
        set(handles.text_Information,'String',doc.Mask);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end
        set(handles.text_Status,'String','Wait: Create mask'); drawnow; 
    case 'Filtering'
        set(handles.text_Information,'String',doc.Filtering);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end
        SetText(hObject, eventdata, handles,'Choose Filter','Global Threshold(1)','Local Threshold(2)','Snr Threshold(3)','SizeFactor')
        updateEdit(hObject, eventdata, handles , char(val(str)));        
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Interpolate'
        set(handles.text_Information,'String',doc.Interpolate);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end        
        SetText(hObject, eventdata, handles,'SizeFactor')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Pixel2Unit'
        set(handles.text_Information,'String',doc.Pixel2Unit);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end 
        SetText(hObject, eventdata, handles,'Y Channel width [um]','Y Channel width [pixel]','X Calibration [um]','X Calibration [pixel]','Choose Convert Data','sizeFactor')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'ColorMap'
        set(handles.text_Information,'String',doc.ColorMap);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end 
        SetText(hObject, eventdata, handles,'Velocity Component','Display','Vector Display','SizeFactor')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
%     case 'AvgVelocity'
%         set(handles.text_Information,'String',doc.AvgVelocity);drawnow;
%         if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end 
%         SetText(hObject, eventdata, handles,'Velocity Component','Average Direction' , 'Channel Width' , 'Channel Length')
%         updateEdit(hObject, eventdata, handles , char(val(str)));
%         set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'FlowRate'
        set(handles.text_Information,'String',doc.FlowRate);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end 
        SetText(hObject, eventdata, handles,'Channel Width','Channel Height','Flowrate Analysis','Velocity Component','Line axis')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Density'
        set(handles.text_Information,'String',doc.Density);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end 
        SetText(hObject, eventdata, handles,'Window Width','Window Height')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow;        
    case 'Streamline'
        set(handles.text_Information,'String',doc.Streamline);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end         
        SetText(hObject, eventdata, handles,'Starting Boundery','Streamline Gap','Start Point')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow; 
    case 'VelocityProfile'
        set(handles.text_Information,'String',doc.VelocityProfile);drawnow;
        if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end         
        SetText(hObject, eventdata, handles,'Velocity Component','Line axis' , 'Channel Width' ,'Area Length', 'nan factor', 'Section position [%]', 'Analysis', '#sections', 'Channel Height')
        updateEdit(hObject, eventdata, handles , char(val(str)));
        set(handles.text_Status,'String','Choose Parameters'); drawnow; 
% %     case 'function_name'
% %         set(handles.text_Information,'String',doc.function_name);drawnow;  %add doc.function_name
% %         if fieldCheck(hObject, eventdata, handles , char(val(str)))==1 return; end    %add fieldCheck critiria     
% %         SetText(hObject, eventdata, handles,'Velocity Component','Average Direction' , 'Channel Width' , 'Profile position [um]')
% %         updateEdit(hObject, eventdata, handles , char(val(str)));
% %         set(handles.text_Status,'String','Choose Parameters'); drawnow; 
              
end
guidata(hObject, handles)

% --- Executes during object creation, after setting all properties.
function ListboxPair_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListboxPair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_Run.
function PB_Run_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if  isfield(handles,'islist')==0  uiwait(msgbox('Choos Function to Execute!')); return; end
switch handles.islist
    case 1
        hand = RunPair(hObject, eventdata, handles)
        handles = hand;
        guidata(hObject, handles);
    case 2
        hand = RunSequence(hObject, eventdata, handles)
        handles = hand;
        guidata(hObject, handles);
    case 3
        
end

% --- Executes on selection change in ListboxSequence.
function ListboxSequence_Callback(hObject, eventdata, handles)
% hObject    handle to ListboxSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListboxSequence contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListboxSequence
handles.islist = 2;
resetEdit(hObject, eventdata, handles)
resetText(hObject, eventdata, handles)
doc = funDoc();
val = get(handles.ListboxSequence, 'string'); % Determine the selected data set.
str = get(handles.ListboxSequence, 'Value');
handles.functionDir = char(val(str));

switch char(val(str))
    case 'Correlation'
        set(handles.text_Information,'String',doc.Correlation);drawnow;
%         if fieldCheck(hObject, eventdata, handles, 1)==1 return; end
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Window Size','Time Gap','Overlap','Method','SizeFactor','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'Correlation');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Mask' 
        set(handles.text_Information,'String',doc.Mask);drawnow;
%         if fieldCheck(hObject, eventdata, handles , 2)==1 return; end
        handles.functionDir = val(str)
    case 'Filtering'
        set(handles.text_Information,'String',doc.Filtering);drawnow;
        if fieldCheck(hObject, eventdata, handles , 3)==1 return; end
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Choose Filter','Global Threshold(1)','Local Threshold(2)','Snr Threshold(3)','SizeFactor','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'Filtering');        
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Interpolate'
        set(handles.text_Information,'String',doc.Interpolate);drawnow;
        if fieldCheck(hObject, eventdata, handles , 4)==1 return; end        
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'SizeFactor','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'Interpolate');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Pixel2Unit'
        set(handles.text_Information,'String',doc.Pixel2Unit);drawnow;
        if fieldCheck(hObject, eventdata, handles , 5)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Channel width [um]','Channel width [pixel]',...
            'Y Calibration distance [um]','Y Calibration distance',...
            'Choose Convert Data','sizeFactor','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles ,'Pixel2Unit');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'ColorMap'
        set(handles.text_Information,'String',doc.ColorMap);drawnow;
        if fieldCheck(hObject, eventdata, handles , 6)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component','Analysis','vector display','sizefactor','no scale vector','fps','Display','min scale [um/s^2]/[um/s]/[1/s]','max scale [um/s^2]/[um/s]/[1/s]','Scale Color','Video')
        updateEdit_Seq(hObject, eventdata, handles , 'ColorMap');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'VelocityProfile'
        set(handles.text_Information,'String',doc.VelocityProfile);drawnow;
        if fieldCheck(hObject, eventdata, handles , 7)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component','Average Direction' , 'Channel Width' , 'Channel Length','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'VelocityProfile');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'FlowRate'
        set(handles.text_Information,'String',doc.FlowRate);drawnow;
        if fieldCheck(hObject, eventdata, handles , 8)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Channel Width','Channel Height','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'FlowRate');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 'Density'
        set(handles.text_Information,'String',doc.Density);drawnow;
        if fieldCheck(hObject, eventdata, handles , 9)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Window Width','Window Height','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'Density');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;        
    case 'Streamline'
        set(handles.text_Information,'String',doc.Streamline);drawnow;
        if fieldCheck(hObject, eventdata, handles , 10)==1 return; end         
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Streamline Gap','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'Streamline');
        set(handles.text_Status,'String','Choose Parameters'); drawnow; 
    case 'TimeFunction'
%         set(handles.text_Information,'String',doc.TimeFunction);drawnow;
        if fieldCheck(hObject, eventdata, handles , 10)==1 return; end         
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component','Average Direction' , 'Channel Width' , 'Channel Length', 'nan', 'section','analysis','span','height','fps','Display')
        updateEdit_Seq(hObject, eventdata, handles , 'Streamline');
        set(handles.text_Status,'String','Choose Parameters'); drawnow;       
        
end
guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function ListboxSequence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListboxSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ListboxVideo.
function ListboxVideo_Callback(hObject, eventdata, handles)
% hObject    handle to ListboxVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListboxVideo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListboxVideo


% --- Executes during object creation, after setting all properties.
function ListboxVideo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListboxVideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_LoadPair.
function PB_LoadPair_Callback(hObject, eventdata, handles)
% hObject    handle to PB_LoadPair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'FolderName')==0
    handles.FolderName = 'Temp'
    handles.path_name = ''
end
[filename, pathname, filterindex] = uigetfile(fullfile(handles.path_name,'*.jpg;*.png;*.bmp;*.tif'),'Pick pair of images', 'MultiSelect', 'on')
handles.path_name = pathname;
% [filename, pathname, filterindex] = uigetfile(...
% {'*.jpg;*.bmp;*.tif;*.png','Use Shift key'} ,'Pick two images, use shift button','Pick pair of images', 'MultiSelect', 'on');
%Tip imcontrast()   'C:\Work\setpos1.png' 

if size(filename,2)~=2
uiwait(msgbox('Load pair of images first!'));
return
end
imagefile = fullfile(char(pathname), char(filename(1)))

im1=imread(imagefile);
if ndims(im1) == 3, im1 = rgb2gray(im1); end
handles.image{1} = im1;
imshow(im1);

imagefile = fullfile(char(pathname), char(filename(2)));
im2=imread(imagefile);
if ndims(im2) == 3, im2 = rgb2gray(im2); end
handles.image{2} = im2;
handles.isvideo=0;
set(handles.radiobutton1,'Value',1);
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.ListboxPair,'Enable','on')
set(handles.ListboxSequence,'Enable','off')
set(handles.ListboxVideo,'Enable','off')
guidata(hObject, handles)
% set(handles.text_video,'BackgroundColor',[0.94 0.94 0.94]);
% set(handles.text_images,'BackgroundColor','green');
% set(handles.text15,'String','Pair loaded');drawnow;
set(handles.text_Status,'String','Choose Command From The List'); drawnow;



% --- Executes on button press in PB_LoadSequence.
function PB_LoadSequence_Callback(hObject, eventdata, handles)
% hObject    handle to PB_LoadSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'FolderName')==0
    handles.FolderName = 'Temp';
end
[filename, pathname, filterindex] = uigetfile(fullfile(handles.path_name,...
 '*.jpg;*.png;*.bmp;*.tif') ,'Pick two images, use shift button', 'MultiSelect', 'on');
handles.path_name = pathname;

%Tip imcontrast()

if isstr(filename)==1
uiwait(msgbox('Sequence Is More Then One Images!'));
return
end


NumberOfImages = size(filename,2);
index = NumberOfImages-1;
handles.seq = index;
images = cell(index,1);


  % load the images
  for k = 1 : NumberOfImages  
   imagefile = fullfile(char(pathname), char(filename(k)));
   im = imread(imagefile);
   if ndims(im) == 3, im = rgb2gray(im); end
   images{k} = im;
%    imshow(im);  Temporaly!!
%    set(handles.text_Status,'String',k); drawnow;     
   set(handles.text_Status,'String',sprintf('Wait:  %d / %d',k,NumberOfImages)); drawnow;
  end
imshow(im);  
handles.images = images;
set(handles.radiobutton1,'Value',0);
set(handles.radiobutton2,'Value',1);
set(handles.radiobutton3,'Value',0);
set(handles.ListboxPair,'Enable','off')
set(handles.ListboxSequence,'Enable','on')
set(handles.ListboxVideo,'Enable','off')
guidata(hObject, handles)


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_SaveFolder.
function PB_SaveFolder_Callback(hObject, eventdata, handles)
% hObject    handle to PB_SaveFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'path_name')    
    handles.path_name = uigetdir(handles.path_name); 
else
    handles.path_name = uigetdir; 
end
if handles.path_name==0
   uiwait(msgbox('Choose Saving Location!'))
   return
end
datetime=datestr(now);
datetime=strrep(datetime,':','_'); %Replace colon with underscore
datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
datetime=strrep(datetime,' ','_');%Replace space with underscore

handles.FolderName = fullfile(handles.path_name,datetime);
if exist(handles.FolderName)==0 mkdir(handles.FolderName); end
guidata(hObject, handles)
set(handles.text_Status,'String','Load File'); drawnow;



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PB_Reset.
function PB_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
cla(handles.axes1,'reset');
resetTemp = handles.reset;
if isfield(handles,'path_name') resetTemp.path_name = handles.path_name; end
 handles = handles.reset;
handles.reset = resetTemp;


% if isfield(handles,'image')==1  handles=rmfield(handles,{'image'}); end
% if isfield(handles,'FolderName')==1  handles=rmfield(handles,{'FolderName'}); end
% if isfield(handles,'mCorrelation')==1  handles=rmfield(handles,{'mCorrelation'}); end
% if isfield(handles,'islist')==1  handles=rmfield(handles,{'islist'}); end
% if isfield(handles,'m')==1  handles=rmfield(handles,{'m'}); end
% if isfield(handles,'mp')==1  handles=rmfield(handles,{'mp'}); end
% if isfield(handles,'w')==1  handles=rmfield(handles,{'w'}); end
% if isfield(handles,'maskfile')==1  handles=rmfield(handles,{'maskfile'}); end
% if isfield(handles,'isvideo')==1  handles=rmfield(handles,{'isvideo'}); end
% if isfield(handles,'videObj')==1  handles=rmfield(handles,{'videObj'}); end
% if isfield(handles,'functionDir')==1  handles=rmfield(handles,{'functionDir'}); end
% if isfield(handles,'wins')==1  handles=rmfield(handles,{'wins'}); end
% if isfield(handles,'deltaT')==1  handles=rmfield(handles,{'deltaT'}); end
% if isfield(handles,'overlap')==1  handles=rmfield(handles,{'overlap'}); end
% if isfield(handles,'method')==1  handles=rmfield(handles,{'method'}); end
% if isfield(handles,'sizeFactor')==1  handles=rmfield(handles,{'sizeFactor'}); end
% if isfield(handles,'channelLength')==1  handles=rmfield(handles,{'channelLength'}); end
% if isfield(handles,'channelLength')==1  handles=rmfield(handles,{'channelLength'}); end
% 
resetEdit(hObject, eventdata, handles)
resetText(hObject, eventdata, handles)
set(handles.radiobutton1,'Value',0);
set(handles.radiobutton2,'Value',0);
set(handles.radiobutton3,'Value',0);
set(handles.ListboxPair,'Enable','off')
set(handles.ListboxSequence,'Enable','off')
set(handles.ListboxVideo,'Enable','off')

%text
set(handles.text_Status,'String','Choose Saving Path First');drawnow;
set(handles.text_Information,'String','');drawnow;
set(handles.text_Data,'String','');drawnow;
set(handles.text_Results,'String','');drawnow;

guidata(hObject, handles)
handles
% clear all;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_session_Callback(hObject, eventdata, handles)
% hObject    handle to save_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName, path_name]= uiputfile({'*.mat'}, 'Save as');
if path_name==0
   uiwait(msgbox('Choose Saving Location!'))
   return
end
save = fullfile(path_name,FileName);
if exist(path_name)==0 mkdir(path_name); end
% guidata(hObject, handles)

 m = matfile(save, 'Writable', true);
 m.handles = handles;
 set(handles.text_Status,'String','Saved session'); drawnow;
% 
%   m = matfile(save, 'Writable', true);
%     if isfield(handles,'wins') m.wins = handles.wins; end
%     if isfield(handles,'overlap') m.overlap = handles.overlap; end
%     if isfield(handles,'deltaT') m.deltaT = handles.deltaT; end
%     if isfield(handles,'method') m.method = handles.method; end    
%     if isfield(handles,'m') m.m = handles.m; end
%     if isfield(handles,'mCorrelation') m.mCorrelation = handles.mCorrelation; end
%     if isfield(handles,'mFiltering') m.mFiltering = handles.mFiltering; end
%     if isfield(handles,'mInterpolate') m.mInterpolate = handles.mInterpolate; end
%     if isfield(handles,'channelWitdh') m.channelWitdh = handles.channelWitdh; end
%     if isfield(handles,'channelLength') m.channelLength = handles.channelLength; end
%     if isfield(handles,'cal') m.mInterpolate = handles.cal; end
%     if isfield(handles,'magitudeComponent') m.magitudeComponent = handles.magitudeComponent; end
%     if isfield(handles,'avgComponent') m.avgComponent = handles.avgComponent; end
%     if isfield(handles,'avgDirection') m.avgDirection = handles.avgDirection; end
%     if isfield(handles,'avgV') m.avgV = handles.avgV; end
%     if isfield(handles,'channeHeight') m.channeHeight = handles.channeHeight; end
%     if isfield(handles,'Q') m.Q = handles.Q; end    
%     if isfield(handles,'w') m.w = handles.w; end
%     if isfield(handles,'mphysical') m.mphysical = handles.mphysical; end
%     if isfield(handles,'mp') m.mp = handles.mp; end
%     if isfield(handles,'image') m.image = handles.image; end
%     if isfield(handles,'images') m.images = handles.images; end
%     if isfield(handles,'islist') m.islist = handles.islist; end
%     if isfield(handles,'functionDir') m.functionDir = handles.functionDir; end
%     if isfield(handles,'maskfile') m.maskfile = handles.maskfile; end
%     if isfield(handles,'sizeFactor') m.sizeFactor = handles.sizeFactor; end
%     if isfield(handles,'filterChoose') m.filterChoose = handles.filterChoose; end
%     if isfield(handles,'globtrld') m.globtrld = handles.globtrld; end
%     if isfield(handles,'loctrld') m.loctrld = handles.loctrld; end
%     if isfield(handles,'snrtrld') m.snrtrld = handles.snrtrld; end
    clear m

% set(handles.text_Status,'String','Load File'); drawnow;

% --------------------------------------------------------------------
function load_session_Callback(hObject, eventdata, handles)
% hObject    handle to load_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% uiopen('load')
% uigetfile

% close;

[FileName, path_name, FilterIndex]= uigetfile({'*.mat'}, 'Load Session');
if path_name==0
   uiwait(msgbox('Choose Session mat file!'))
   return
end
 set(handles.text_Status,'String','Waite: Load and refreshing'); drawnow;
loadf = fullfile(path_name,FileName);
m = load(loadf);
% PB_Reset_Callback(hObject, eventdata, handles)
% waitbar(0,'Waite: Load and refreshing')
%  uiwait(msgbox('The software will open in few minutes, press ok'))
handles = m.handles;
refresh;
% close


% m = load(loadf);
%     if isfield(m,'wins') handles.wins = m.wins; end
%     if isfield(m,'overlap') handles.overlap = m.overlap; end
%     if isfield(m,'deltaT') handles.deltaT = m.deltaT; end
%     if isfield(m,'method') handles.method = m.method; end    
%     if isfield(m,'m') handles.m = m.m; end
%     if isfield(m,'mCorrelation') handles.mCorrelation = m.mCorrelation; end
%     if isfield(m,'mFiltering') handles.mFiltering = m.mFiltering; end
%     if isfield(m,'mInterpolate') handles.mInterpolate = m.mInterpolate; end
%     if isfield(m,'channelWitdh') handles.channelWitdh = m.channelWitdh; end
%     if isfield(m,'channelLength') handles.channelLength = m.channelLength; end
%     if isfield(m,'cal') handles.mInterpolate = m.cal; end
%     if isfield(m,'magitudeComponent') handles.magitudeComponent = m.magitudeComponent; end
%     if isfield(m,'avgComponent') handles.avgComponent = m.avgComponent; end
%     if isfield(m,'avgDirection') handles.avgDirection = m.avgDirection; end
%     if isfield(m,'avgV') handles.avgV = m.avgV; end
%     if isfield(m,'channeHeight') handles.channeHeight = m.channeHeight; end
%     if isfield(m,'Q') handles.Q = m.Q; end    
%     if isfield(m,'w') handles.w = m.w; end
%     if isfield(m,'mphysical') m.mphysical = m.mphysical; end
%     if isfield(m,'mp') handles.mp = m.mp; end
%     if isfield(m,'image') handles.image = m.image; end
%     if isfield(m,'images') handles.images = m.images; end
%     if isfield(m,'islist') handles.islist = m.islist; end
%     if isfield(m,'functionDir') handles.functionDir = m.functionDir; end
%     if isfield(m,'maskfile') handles.maskfile = m.maskfile; end
%     if isfield(m,'sizeFactor') handles.sizeFactor = m.sizeFactor; end
%     if isfield(m,'filterChoose') handles.filterChoose = m.filterChoose; end
%     if isfield(m,'globtrld') handles.globtrld = m.globtrld; end
%     if isfield(m,'loctrld') handles.loctrld = m.loctrld; end
%     if isfield(m,'snrtrld') handles.snrtrld = m.snrtrld; end
%     
%     clear m;
% 
%   if handles.islist==1
%     set(handles.radiobutton1,'Value',1);
%     set(handles.ListboxPair,'Enable','on')
%   end
%   if handles.islist==2
%     set(handles.radiobutton2,'Value',0);
%     set(handles.ListboxSequence,'Enable','on')
%   end
%   if handles.islist==3 
%     set(handles.radiobutton3,'Value',0);
%     set(handles.ListboxVideo,'Enable','on')
%   end


% --- Executes on key press with focus on PB_Run and none of its controls.
function PB_Run_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to PB_Run (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% % keyPressed = eventdata.Key;
% %  if strcmpi(keyPressed,'r')
% %      PB_Run_Callback(hObject, eventdata, handles)
% % %      % set focus to the button
% % %      uicontrol(handles.pushbutton1);% 
% % %      % call the callback
% % %     PB_Run_Callback(handles.pushbutton1,[],handles);%   pushbutton1_Callback(handles.pushbutton1,[],handles);
% %  end


% --------------------------------------------------------------------
function PrintScreen_Callback(hObject, eventdata, handles)
% hObject    handle to PrintScreen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'FolderName')==0
    handles.FolderName = 'Temp'
end
   %Save
   datetime=datestr(now);
   datetime=strrep(datetime,':','_'); %Replace colon with underscore
   datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
   datetime=strrep(datetime,' ','_');%Replace space with underscore 
   folderf  = fullfile(handles.FolderName,'Print Screen');   
   if exist(folderf)==0 mkdir(folderf); end
  

      %save to image
   folder  = fullfile(folderf,'Plot');   
   if exist(folder)==0 mkdir(folder); end
    datetimef = strcat(datetime,'_PrintScreen'); %.png
    FileName = fullfile(folder,datetimef)
% %     a = getframe(gca)
% %     imwrite(a.cdata,FileName)
%     set(gcf, 'Color', 'w');
a = handles.axes1;
b = a.Children;
c = a.Parent;
%      export_fig(a,FileName,  '-png', '-q101');
     export_fig(a,FileName,  '-pdf', '-transparent');
%         save2pdf(FileName,a,600)
%      set(gcf, 'Color', [0.94 0.94 0.94]);
    
    
    %screen capture
      folder  = fullfile(folderf,'Screen');   
   if exist(folder)==0 mkdir(folder); end
   
    datetimef = strcat(datetime,'_Plot.png');
    FileName = fullfile(folder,datetimef)
    export_fig(FileName,  '-png', '-q101');
 %%%%%%%%%%%%%%%%%%%%%%%%%%
