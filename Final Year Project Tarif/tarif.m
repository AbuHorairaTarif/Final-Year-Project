function varargout = tarif(varargin)
% TARIF MATLAB code for tarif.fig
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tarif_OpeningFcn, ...
                   'gui_OutputFcn',  @tarif_OutputFcn, ...
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


% --- Executes just before tarif is made visible.
function tarif_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tarif (see VARARGIN)

% Choose default command line output for tarif
handles.output = hObject;
% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('spot9.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','on','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');

% Update handles structure
guidata(hObject, handles);
[Y, FS]=audioread('welcome.mp3');
  sound(Y,FS);

% bg_image = imread('exit.png');
% set(handles.pb_with_bg, 'CData', bg_image);
% guidata(hObject, handles);

% Update handles structure
% UIWAIT makes tarif wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = tarif_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure





% --- Executes on button press in pb_with_bg.
function pb_with_bg_Callback(hObject, eventdata, handles)
% hObject    handle to pb_with_bg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close tarif;

% --- Executes on button press in IrisRecognitionButton.
function IrisRecognitionButton_Callback(hObject, eventdata, handles)
% hObject    handle to IrisRecognitionButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of IrisRecognitionButton
%set(handles.fileName);
varargout{1} = handles.output;
fileName=option;
handles.fileName=fileName;
%set(handles.IrisRecognitionButton,'KeyPressFcn',num2str(fileName));
guidata(hObject, handles);


% --- Executes on key press with focus on IrisRecognitionButton and none of its controls.
function IrisRecognitionButton_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to IrisRecognitionButton (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on key press with focus on pb_with_bg and none of its controls.
function pb_with_bg_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pb_with_bg (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
function pb_with_bg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tarif (see VARARGIN)
% bg_image = imread('exit.png');
% set(handles.pb_with_bg, 'CData', bg_image);
% % Update handles structure
% guidata(hObject, handles);

% UIWAIT makes tarif wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Executes during object creation, after setting all properties.
function pb_with_bg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pb_with_bg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function openaxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to openaxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate openaxes

%  for k=1:11
%      [img,map] = imread('crystal.gif','frames',k);
%      imshow(img,map);
%  end
 
    
