function varargout = matched(varargin)
% MATCHED MATLAB code for matched.fig
%      MATCHED, by itself, creates a new MATCHED or raises the existing
%      singleton*.
%
%      H = MATCHED returns the handle to a new MATCHED or the handle to
%      the existing singleton*.
%
%      MATCHED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATCHED.M with the given input arguments.
%
%      MATCHED('Property','Value',...) creates a new MATCHED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matched_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matched_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matched

% Last Modified by GUIDE v2.5 25-Nov-2017 14:12:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matched_OpeningFcn, ...
                   'gui_OutputFcn',  @matched_OutputFcn, ...
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


% --- Executes just before matched is made visible.
function matched_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matched (see VARARGIN)

% Choose default command line output for matched
handles.output = hObject;
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('spot8.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','on','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes matched wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = matched_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in closepushbutton.
function closepushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to closepushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close matched;