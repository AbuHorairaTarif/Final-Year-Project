function varargout = option(varargin)
% OPTION MATLAB code for option.fig
%      OPTION, by itself, creates a new OPTION or raises the existing
%      singleton*.
%
%      H = OPTION returns the handle to a new OPTION or the handle to
%      the existing singleton*.
%
%      OPTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPTION.M with the given input arguments.
%
%      OPTION('Property','Value',...) creates a new OPTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before option_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to option_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help option

% Last Modified by GUIDE v2.5 24-Nov-2017 22:25:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @option_OpeningFcn, ...
                   'gui_OutputFcn',  @option_OutputFcn, ...
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


% --- Executes just before option is made visible.
function option_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to option (see VARARGIN)

% Choose default command line output for option
handles.output = hObject;
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('spot2.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','on','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');



% Update handles structure
guidata(hObject, handles);
[Y, FS]=audioread('selectdatabase.mp3');
  sound(Y,FS);
% UIWAIT makes option wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = option_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.


% --- Executes on button press in casiapushbutton.
function casiapushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to casiapushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
varargout{1} = handles.output;
fileName=casiairis;
handles.fileName=fileName;
%set(handles.IrisRecognitionButton,'KeyPressFcn',num2str(fileName));
guidata(hObject, handles);
close option;
% --- Executes on button press in mydatabasepushbutton.
function mydatabasepushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to mydatabasepushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;
fileName=irissegment;
handles.fileName=fileName;
%set(handles.IrisRecognitionButton,'KeyPressFcn',num2str(fileName));
guidata(hObject, handles);
close option;
% --- Executes on button press in cancelpushbutton.
function cancelpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close option;
