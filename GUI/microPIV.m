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
% Edit the above text to modify the response to help microPIV

% Last Modified by GUIDE v2.5 15-Aug-2017 16:28:51

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
set(handles.text_Information,'String','(1)Load file. (2)Choose function from the list. (3)Run. Note: for new anslys press ''Reset''. Default saving location is TEMP in the current folder otherwise location is given'); drawnow;
set(handles.ListboxPair,'Enable','off'); 
set(handles.ListboxSequence,'Enable','off');
set(handles.ListboxVideo,'Enable','off');

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
switch str;
    case 1
        set(handles.text_Information,'String',doc.Correlation);drawnow;
        if fieldCheck(hObject, eventdata, handles, 1)==1 return; end
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Window Size','Time Gap','Overlap','Method','SizeFactor')
        updateEdit(hObject, eventdata, handles , 1);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 2 
        set(handles.text_Information,'String',doc.Mask);drawnow;
        if fieldCheck(hObject, eventdata, handles , 2)==1 return; end
        handles.functionDir = val(str)
    case 3
        set(handles.text_Information,'String',doc.Filtering);drawnow;
        if fieldCheck(hObject, eventdata, handles , 3)==1 return; end
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Choose Filter','Global Threshold(1)','Local Threshold(2)','Snr Threshold(3)','SizeFactor')
        updateEdit(hObject, eventdata, handles , 3);        
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 4
        set(handles.text_Information,'String',doc.Interpolate);drawnow;
        if fieldCheck(hObject, eventdata, handles , 4)==1 return; end        
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'SizeFactor')
        updateEdit(hObject, eventdata, handles , 4);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 5
        set(handles.text_Information,'String',doc.Pixel2Unit);drawnow;
        if fieldCheck(hObject, eventdata, handles , 5)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Channel width [um]','Channel width [pixel]','Y Calibration distance [um]','Y Calibration distance','Choose Convert Data','sizeFactor')
        SetEdit(hObject, eventdata, handles,600,1000,600,1000,'Interpolate',3)
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 6
        set(handles.text_Information,'String',doc.Magnitude);drawnow;
        if fieldCheck(hObject, eventdata, handles , 6)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component')
        updateEdit(hObject, eventdata, handles , 6);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 7
        set(handles.text_Information,'String',doc.AvgVelocity);drawnow;
        if fieldCheck(hObject, eventdata, handles , 7)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component','Average Direction' , 'Channel Width' , 'Channel Length')
        updateEdit(hObject, eventdata, handles , 7);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 8
        set(handles.text_Information,'String',doc.FlowRate);drawnow;
        if fieldCheck(hObject, eventdata, handles , 8)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Channel Width','Channel Height')
        updateEdit(hObject, eventdata, handles , 8);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 9
        set(handles.text_Information,'String',doc.Density);drawnow;
        if fieldCheck(hObject, eventdata, handles , 9)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Window Width','Window Height')
        updateEdit(hObject, eventdata, handles , 9);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;        
    case 10
        set(handles.text_Information,'String',doc.Streamline);drawnow;
        if fieldCheck(hObject, eventdata, handles , 10)==1 return; end         
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Streamline Gap')
        updateEdit(hObject, eventdata, handles , 10);
        set(handles.text_Status,'String','Choose Parameters'); drawnow; 
        
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

if isfield(handles,'maskfile')==0
handles.maskfile=[];
end

if strcmp(handles.functionDir,'Correlation')
    [hand] = Correlation(hObject, eventdata,handles);
    handles = hand;
    guidata(hObject , handles)    
elseif strcmp(handles.functionDir,'Mask')
    hand = CreateMask(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'Filtering')  
    [hand] = Filtering(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)   
elseif strcmp(handles.functionDir,'Interpolate') 
    hand = Interpolate(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)  
elseif strcmp(handles.functionDir,'Pixel2Unit') 
    hand = pix2unit(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'Magnitude') 
    hand = Magnitude(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'AvgVelocity') 
    hand = AvgVelocity(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles) 
elseif strcmp(handles.functionDir,'FlowRate') 
    hand = FlowRate(hObject, eventdata, handles);
    handles = hand;
    guidata(hObject , handles)
elseif strcmp(handles.functionDir,'Density') 
    Density(hObject, eventdata, handles);
elseif strcmp(handles.functionDir,'Streamline')
    Streamline(hObject, eventdata, handles);
end

infoData(hObject, eventdata, handles)
infoResults(hObject, eventdata, handles)
guidata(hObject, handles)


% --- Executes on selection change in ListboxSequence.
function ListboxSequence_Callback(hObject, eventdata, handles)
% hObject    handle to ListboxSequence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListboxSequence contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListboxSequence
handles.islist = 1;
resetEdit(hObject, eventdata, handles)
resetText(hObject, eventdata, handles)
doc = funDoc();
val = get(handles.ListboxPair, 'string'); % Determine the selected data set.
str = get(handles.ListboxPair, 'Value');
switch str;
    case 1
        set(handles.text_Information,'String',doc.Correlation);drawnow;
%         if fieldCheck(hObject, eventdata, handles, 1)==1 return; end
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Window Size','Time Gap','Overlap','Method','SizeFactor')
        updateEdit(hObject, eventdata, handles , 1);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 2 
        set(handles.text_Information,'String',doc.Mask);drawnow;
        if fieldCheck(hObject, eventdata, handles , 2)==1 return; end
        handles.functionDir = val(str)
    case 3
        set(handles.text_Information,'String',doc.Filtering);drawnow;
        if fieldCheck(hObject, eventdata, handles , 3)==1 return; end
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Choose Filter','Global Threshold(1)','Local Threshold(2)','Snr Threshold(3)','SizeFactor')
        updateEdit(hObject, eventdata, handles , 3);        
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 4
        set(handles.text_Information,'String',doc.Interpolate);drawnow;
        if fieldCheck(hObject, eventdata, handles , 4)==1 return; end        
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'SizeFactor')
        updateEdit(hObject, eventdata, handles , 4);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 5
        set(handles.text_Information,'String',doc.Pixel2Unit);drawnow;
        if fieldCheck(hObject, eventdata, handles , 5)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Channel width [um]','Channel width [pixel]','Y Calibration distance [um]','Y Calibration distance','Choose Convert Data','sizeFactor')
        SetEdit(hObject, eventdata, handles,600,1000,600,1000,'Interpolate',3)
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 6
        set(handles.text_Information,'String',doc.Magnitude);drawnow;
        if fieldCheck(hObject, eventdata, handles , 6)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component')
        updateEdit(hObject, eventdata, handles , 6);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 7
        set(handles.text_Information,'String',doc.AvgVelocity);drawnow;
        if fieldCheck(hObject, eventdata, handles , 7)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Velocity Component','Average Direction' , 'Channel Width' , 'Channel Length')
        updateEdit(hObject, eventdata, handles , 7);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 8
        set(handles.text_Information,'String',doc.FlowRate);drawnow;
        if fieldCheck(hObject, eventdata, handles , 8)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Channel Width','Channel Height')
        updateEdit(hObject, eventdata, handles , 8);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;
    case 9
        set(handles.text_Information,'String',doc.Density);drawnow;
        if fieldCheck(hObject, eventdata, handles , 9)==1 return; end 
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Window Width','Window Height')
        updateEdit(hObject, eventdata, handles , 9);
        set(handles.text_Status,'String','Choose Parameters'); drawnow;        
    case 10
        set(handles.text_Information,'String',doc.Streamline);drawnow;
        if fieldCheck(hObject, eventdata, handles , 10)==1 return; end         
        handles.functionDir = val(str)
        SetText(hObject, eventdata, handles,'Streamline Gap')
        updateEdit(hObject, eventdata, handles , 10);
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
end

[filename, pathname, filterindex] = uigetfile( ...
 {'*.jpg;*.bmp','Use Shift key'} ,'Pick two images, use shift button','Pick pair of images', 'MultiSelect', 'on');
%Tip imcontrast()

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

[filename, pathname, filterindex] = uigetfile( ...
 {'*.jpg;*.bmp','Use Shift key'} ,'Pick two images, use shift button','Pick pair of images', 'MultiSelect', 'on');
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
   imshow(im);
   set(handles.text_Status,'String',k); drawnow;
  end
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


% --- Executes on button press in PB_SaveFolder.
function PB_SaveFolder_Callback(hObject, eventdata, handles)
% hObject    handle to PB_SaveFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path_name = uigetdir;
if path_name==0
   uiwait(msgbox('Choose Saving Location!'))
   return
end
datetime=datestr(now);
datetime=strrep(datetime,':','_'); %Replace colon with underscore
datetime=strrep(datetime,'-','_');%Replace minus sign with underscore
datetime=strrep(datetime,' ','_');%Replace space with underscore

handles.FolderName = fullfile(path_name,datetime);
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

if isfield(handles,'image')==1  handles=rmfield(handles,{'image'}); end
if isfield(handles,'FolderName')==1  handles=rmfield(handles,{'FolderName'}); end
if isfield(handles,'mCorrelation')==1  handles=rmfield(handles,{'mCorrelation'}); end
if isfield(handles,'islist')==1  handles=rmfield(handles,{'islist'}); end
if isfield(handles,'m')==1  handles=rmfield(handles,{'m'}); end
if isfield(handles,'mp')==1  handles=rmfield(handles,{'mp'}); end
if isfield(handles,'w')==1  handles=rmfield(handles,{'w'}); end
if isfield(handles,'maskfile')==1  handles=rmfield(handles,{'maskfile'}); end
if isfield(handles,'isvideo')==1  handles=rmfield(handles,{'isvideo'}); end
if isfield(handles,'videObj')==1  handles=rmfield(handles,{'videObj'}); end
if isfield(handles,'functionDir')==1  handles=rmfield(handles,{'functionDir'}); end
if isfield(handles,'wins')==1  handles=rmfield(handles,{'wins'}); end
if isfield(handles,'deltaT')==1  handles=rmfield(handles,{'deltaT'}); end
if isfield(handles,'overlap')==1  handles=rmfield(handles,{'overlap'}); end
if isfield(handles,'method')==1  handles=rmfield(handles,{'method'}); end
if isfield(handles,'sizeFactor')==1  handles=rmfield(handles,{'sizeFactor'}); end
if isfield(handles,'channelLength')==1  handles=rmfield(handles,{'channelLength'}); end
if isfield(handles,'channelLength')==1  handles=rmfield(handles,{'channelLength'}); end

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
clear all;
