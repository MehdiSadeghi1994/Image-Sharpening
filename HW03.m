function varargout = HW03(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @HW03_OpeningFcn, ...
    'gui_OutputFcn',  @HW03_OutputFcn, ...
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
function HW03_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
set(handles.axes1,'xtick',[],'ytick',[])
set(handles.axes2,'xtick',[],'ytick',[])
varargout{1} = handles.output;

function varargout = HW03_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function pushbutton1_Callback(hObject, eventdata, handles)
[Name path] = uigetfile({'*.*'},'Select Your Image');
Image = imread([path Name]);
handles.img = Image;
guidata(hObject, handles);
axes(handles.axes1)
imshow(Image);


function edit1_Callback(hObject, eventdata, handles)

function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function pushbutton2_Callback(hObject, eventdata, handles)
Image = handles.img;
KindFilter=get(handles.uibuttongroup5,'SelectedObject');
Filter=get(KindFilter,'TooltipString');
if strcmp(Filter,'Laplasian')
    Filters=get(handles.uibuttongroup4,'SelectedObject');
    KindOfFilter=get(Filters,'TooltipString');
    Scale=str2num(get(handles.edit2,'String'));
    [ Sharp_Image , Edge_Image ] = Laplasian(Image,KindOfFilter,Scale);
    
else
    Filters=get(handles.uibuttongroup2,'SelectedObject');
    KindOfFilter=get(Filters,'TooltipString');
    SelectedOBject=get(handles.uibuttongroup1,'SelectedObject');
    FilterSize=str2num(get(SelectedOBject,'TooltipString'));
    Rate=str2num(get(handles.edit1,'String'));
    [ Sharp_Image  , Edge_Image , Blur_Image] = Sharpening(Image,FilterSize,Rate,KindOfFilter);
    handles.blimg = Blur_Image;
end

axes(handles.axes2)
imshow(Sharp_Image);
set(handles.text3,'Visible','On')
pause(3)
set(handles.text3,'Visible','Off')
handles.shimg = Sharp_Image;
handles.edimg = Edge_Image;

guidata(hObject, handles);
set(handles.pushbutton4,'Enable','On')
set(handles.pushbutton5,'Enable','On')
if strcmp(Filter,'Smoothing')
set(handles.pushbutton7,'Enable','On')
end

function uibuttongroup5_SelectionChangedFcn(hObject, eventdata, handles)
KindFilter=get(handles.uibuttongroup5,'SelectedObject');
Filter=get(KindFilter,'TooltipString');
if strcmp(Filter,'Laplasian')
    set(handles.pushbutton7,'Enable','Off')
    set(handles.edit2,'Enable','On')
    set(handles.radiobutton7,'Enable','On')
    set(handles.radiobutton8,'Enable','On')
    set(handles.radiobutton1,'Enable','Off')
    set(handles.radiobutton2,'Enable','Off')
    set(handles.radiobutton3,'Enable','Off')
    set(handles.radiobutton4,'Enable','Off')
    set(handles.radiobutton5,'Enable','Off')
    set(handles.radiobutton6,'Enable','Off')
    set(handles.radiobutton11,'Enable','Off')
    set(handles.edit1,'Enable','Off')
    
else
    set(handles.pushbutton7,'Enable','On')
    set(handles.radiobutton1,'Enable','On')
    set(handles.radiobutton2,'Enable','On')
    set(handles.radiobutton3,'Enable','On')
    set(handles.radiobutton4,'Enable','On')
    set(handles.radiobutton5,'Enable','On')
    set(handles.radiobutton6,'Enable','On')
    set(handles.radiobutton11,'Enable','On')
    set(handles.edit1,'Enable','On')
    set(handles.radiobutton7,'Enable','Off')
    set(handles.radiobutton8,'Enable','Off')
    set(handles.edit2,'Enable','Off')
end



function edit2_Callback(hObject, eventdata, handles)
function edit2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function axes1_ButtonDownFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

figure;
Sharp_Image = handles.shimg;
imshow(Sharp_Image,[]);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uibuttongroup2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton1,'Enable','Off')
set(handles.radiobutton2,'Enable','Off')
set(handles.radiobutton3,'Enable','Off')
set(handles.radiobutton4,'Enable','Off')
% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'Enable','On')
set(handles.radiobutton2,'Enable','On')
set(handles.radiobutton3,'Enable','On')
set(handles.radiobutton4,'Enable','On')
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
set(handles.radiobutton1,'Enable','On')
set(handles.radiobutton2,'Enable','On')
set(handles.radiobutton3,'Enable','On')
set(handles.radiobutton4,'Enable','On')
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
figure;
Edge_Image = handles.edimg;
imshow(Edge_Image);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
figure;
Blur_Image = handles.blimg;
imshow(Blur_Image);
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
