function varargout = unmatched(varargin)
% UNMATCHED MATLAB code for unmatched.fig
%      UNMATCHED, by itself, creates a new UNMATCHED or raises the existing
%      singleton*.
%
%      H = UNMATCHED returns the handle to a new UNMATCHED or the handle to
%      the existing singleton*.
%
%      UNMATCHED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNMATCHED.M with the given input arguments.
%
%      UNMATCHED('Property','Value',...) creates a new UNMATCHED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before unmatched_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to unmatched_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help unmatched

% Last Modified by GUIDE v2.5 25-Nov-2017 14:21:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @unmatched_OpeningFcn, ...
                   'gui_OutputFcn',  @unmatched_OutputFcn, ...
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


% --- Executes just before unmatched is made visible.
function unmatched_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to unmatched (see VARARGIN)

% Choose default command line output for unmatched
handles.output = hObject;
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('spot7.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','on','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes unmatched wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = unmatched_OutputFcn(hObject, eventdata, handles) 
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
close unmatched;
