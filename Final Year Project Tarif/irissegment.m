function varargout = irissegment(varargin)
% IRISSEGMENT M-file for irissegment.fig
%      IRISSEGMENT, by itself, creates a new IRISSEGMENT or raises the existing
%      singleton*.
%
%      H = IRISSEGMENT returns the handle to a new IRISSEGMENT or the handle to
%      the existing singleton*.
%
%      IRISSEGMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IRISSEGMENT.M with the given input arguments.
%
%      IRISSEGMENT('Property','Value',...) creates a new IRISSEGMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before irissegment_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to irissegment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.


% Edit the above text to modify the response to help irissegment

% Last Modified by GUIDE v2.5 23-Nov-2017 19:30:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @irissegment_OpeningFcn, ...
                   'gui_OutputFcn',  @irissegment_OutputFcn, ...
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


% --- Executes just before irissegment is made visible.
function irissegment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to irissegment (see VARARGIN)

% Choose default command line output for irissegment
handles.output = hObject;

ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('spot5.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','on','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');


a = ones(256,256);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);
axes(handles.axes4);
imshow(a);
axes(handles.axes5);
imshow(a);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes irissegment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = irissegment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path] = uigetfile('*.bmp;*.jpg;*.png;*.gif;*.tif','Pick an Image File');
if isequal(file,0) | isequal(path,0)
    errordlg({'You did not select image';'Please select your image'},'WARNING');
else
    inputimage = imread(file);
    
    
    
    
    axes(handles.axes1);
    imshow(inputimage);
   % title('Input Image');
        [Y, FS]=audioread('browse.wav');
      sound(Y,FS);
    handles.file = file;
    handles.inputimage = inputimage;
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in irislocate.
function irislocate_Callback(hObject, eventdata, handles)
% hObject    handle to irislocate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 global DIAGPATH
 DIAGPATH = 'alldata';



eyeimage_filename = handles.file;
eyeimage = imread(eyeimage_filename); 
%[temp1 mask1]=createiristemplate(eyeimage_filename);

savefile = [eyeimage_filename,'-mmu.mat'];

[stat,mess]=fileattrib(savefile);

if stat == 1
    % if this file has been processed before
    % then load the circle parameters and
    % noise information for that file.
    load(savefile);
    
else
    
    % if this file has not been processed before
    % then perform automatic segmentation and
    % save the results to a file
    
    [circleiris circlepupil imagewithnoise] = segmentiris(eyeimage);
  %  save(savefile,'circleiris','circlepupil','imagewithnoise');
    
 end

% WRITE NOISE IMAGE
%

imagewithnoise2 = uint64(imagewithnoise);
imagewithcircles = uint64(eyeimage);

%get pixel coords for circle around iris
[x,y] = circlecoords([circleiris(2),circleiris(1)],circleiris(3),size(eyeimage));
ind2 = sub2ind(size(eyeimage),double(y),double(x)); 

%get pixel coords for circle around pupil
[xp,yp] = circlecoords([circlepupil(2),circlepupil(1)],circlepupil(3)+2,size(eyeimage));
ind1 = sub2ind(size(eyeimage),double(yp),double(xp));


% % Part_dist = round(Dist_rad/4);
Part_dist = 8;

Con_cir1 = circlepupil(3) + Part_dist+2;
[xc1,yc1] = circlecoords([circleiris(2),circleiris(1)],Con_cir1,size(eyeimage));
ind3 = sub2ind(size(eyeimage),double(yc1),double(xc1));


Con_cir2 = Con_cir1 + Part_dist;
[xc2,yc2] = circlecoords([circleiris(2),circleiris(1)],Con_cir2,size(eyeimage));
ind4 = sub2ind(size(eyeimage),double(yc2),double(xc2));


Con_cir3 = Con_cir2 + Part_dist;
[xc3,yc3] = circlecoords([circleiris(2),circleiris(1)],Con_cir3,size(eyeimage));
ind5 = sub2ind(size(eyeimage),double(yc3),double(xc3));

% Write noise regions
imagewithnoise2(ind2) = 255;
imagewithnoise2(ind1) = 255;
imagewithnoise2(ind3) = 255;
imagewithnoise2(ind4) = 255;
imagewithnoise2(ind5) = 255;
% Write circles overlayed
imagewithcircles(ind2) = 255;
imagewithcircles(ind1) = 255;
imagewithcircles(ind3) = 255;

imagewithcircles(ind4) = 255;

imagewithcircles(ind5) = 255;

axes(handles.axes2);
imshow(imagewithcircles,[]);

handles.ind1 = ind1;
handles.ind3 = ind3;
handles.ind4 = ind4;
handles.ind5 = ind5;

[Y, FS]=audioread('localization.mp3');
  sound(Y,FS);

warndlg('Localization Completed');
% Update handles structure
guidata(hObject, handles);




% --- Executes on button press in featureextract.
function featureextract_Callback(hObject, eventdata, handles)
% hObject    handle to featureextract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ind1 = handles.ind1;
ind3 = handles.ind3;
ind4 = handles.ind4;
ind5 = handles.ind5;
eyeimage_filename = handles.file;
a = double(imread(eyeimage_filename));
[temp1 mask1]=createiristemplatemmu(eyeimage_filename);
%[template mask] = encode(polar_array, noise_array, nscales, minWaveLength, mult, sigmaOnf); 
%TEMP1=pdist2(temp1,mask1);
%fprintf('%d',temp1);
%%%%%%%%%%%%%%Mean Feature
Mean_f1 = mean(a(ind1));
Mean_f2 = mean(a(ind3));
Mean_f3 = mean(a(ind4));
Mean_f4 = mean(a(ind5));


%%%%%%%%%%%%%% Median Feature....
Median_f1 = median(a(ind1));
Median_f2 = median(a(ind3));
Median_f3 = median(a(ind4));
Median_f4 = median(a(ind5));

%%%%%%%%%%%%%% Variance Feature

Var_f1 = var(a(ind1));
Var_f2 = var(a(ind3));
Var_f3 = var(a(ind4));
Var_f4 = var(a(ind5));


%%%%%%%%%%%%%%% Standard Deviation Feature
Std_f1 = std(a(ind1));
Std_f2 = std(a(ind3));
Std_f3 = std(a(ind4));
Std_f4 = std(a(ind5));


%Query_feature = [Mean_f1 Mean_f2 Mean_f3 Mean_f4 Median_f1 Median_f2 Median_f3 Median_f4 Var_f1 Var_f2 Var_f3 Var_f4];
Query_feature=temp1;
mask1=mask1;
%fprintf('%d',Query_feature);

handles.Query_feature = Query_feature;
handles.mask1 = mask1;
[Y, FS]=audioread('feature.mp3');
  sound(Y,FS);
warndlg('Feature Extraction For The Process Is Completed');
% Update handles structure
guidata(hObject, handles);










% --- Executes on button press in loaddata.
function loaddata_Callback(hObject, eventdata, handles)
% hObject    handle to loaddata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data;
[Y, FS]=audioread('database.mp3');
  sound(Y,FS);
warndlg('Database Loaded');




% --- Executes on button press in recognize.
function recognize_Callback(hObject, eventdata, handles)
% hObject    handle to recognize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Query_feature = handles.Query_feature;
mask1 = handles.mask1;

global DIAGPATH
DIAGPATH = 'MMUData';

     % Results matrix...
resultNames = {};
i = 1;     
fid = fopen('database.txt');
while 1
    imagename = fgetl(fid);
    if ~ischar(imagename), break, end  
eyeimage_filename = imagename;
[temp2 mask2]=createiristemplatemmu(eyeimage_filename);
%TEMP2=pdist2(temp2,mask2);

eyeimage = imread(eyeimage_filename); 
axes(handles.axes4);
imshow(eyeimage);
savefile = [eyeimage_filename,'-mmu.mat'];
[stat,mess]=fileattrib(savefile);

if stat == 1
    % if this file has been processed before
    % then load the circle parameters and
    % noise information for that file.
    load(savefile);
    
else
    
    % if this file has not been processed before
    % then perform automatic segmentation and
    % save the results to a file
    
     [circleiris circlepupil imagewithnoise] = segmentiris(eyeimage);
    save(savefile,'circleiris','circlepupil','imagewithnoise');
    
end

% WRITE NOISE IMAGE
imagewithnoise2 = uint64(imagewithnoise);
imagewithcircles = uint64(eyeimage);


%get pixel coords for circle around iris
[x,y] = circlecoords([circleiris(2),circleiris(1)],circleiris(3),size(eyeimage));
ind2 = sub2ind(size(eyeimage),double(y),double(x)); 

%get pixel coords for circle around pupil
[xp,yp] = circlecoords([circlepupil(2),circlepupil(1)],circlepupil(3)+2,size(eyeimage));
ind1 = sub2ind(size(eyeimage),double(yp),double(xp));


% % Part_dist = round(Dist_rad/4);
Part_dist = 8;

Con_cir1 = circlepupil(3) + Part_dist+2;
[xc1,yc1] = circlecoords([circleiris(2),circleiris(1)],Con_cir1,size(eyeimage));
ind3 = sub2ind(size(eyeimage),double(yc1),double(xc1));


Con_cir2 = Con_cir1 + Part_dist;
[xc2,yc2] = circlecoords([circleiris(2),circleiris(1)],Con_cir2,size(eyeimage));
ind4 = sub2ind(size(eyeimage),double(yc2),double(xc2));


Con_cir3 = Con_cir2 + Part_dist;
[xc3,yc3] = circlecoords([circleiris(2),circleiris(1)],Con_cir3,size(eyeimage));
ind5 = sub2ind(size(eyeimage),double(yc3),double(xc3));

% Write noise regions
imagewithnoise2(ind2) = 255;
imagewithnoise2(ind1) = 255;
imagewithnoise2(ind3) = 255;
imagewithnoise2(ind4) = 255;
imagewithnoise2(ind5) = 255;
% Write circles overlayed
imagewithcircles(ind2) = 255;
imagewithcircles(ind1) = 255;
imagewithcircles(ind3) = 255;

imagewithcircles(ind4) = 255;

imagewithcircles(ind5) = 255;

axes(handles.axes5);
imshow(imagewithcircles,[]);
a = double(eyeimage);

%%%%%%%%%%%%%%Mean Feature
Mean_f1 = mean(a(ind1));
Mean_f2 = mean(a(ind3));
Mean_f3 = mean(a(ind4));
Mean_f4 = mean(a(ind5));


%%%%%%%%%%%%%% Median Feature....
Median_f1 = median(a(ind1));
Median_f2 = median(a(ind3));
Median_f3 = median(a(ind4));
Median_f4 = median(a(ind5));

%%%%%%%%%%%%%% Variance Feature

Var_f1 = var(a(ind1));
Var_f2 = var(a(ind3));
Var_f3 = var(a(ind4));
Var_f4 = var(a(ind5));


%%%%%%%%%%%%%%% Standard Deviation Feature
Std_f1 = std(a(ind1));
Std_f2 = std(a(ind3));
Std_f3 = std(a(ind4));
Std_f4 = std(a(ind5));

%Data_feature = [Mean_f1 Mean_f2 Mean_f3 Mean_f4 Median_f1 Median_f2 Median_f3 Median_f4 Var_f1 Var_f2 Var_f3 Var_f4];
%Data_feature =[temp2 mask2];
% createiristemplatemmu(TEMP1,TEMP2);
result_feature=gethammingdistance(Query_feature,mask1,temp2,mask2,1);
%fprintf('%d\n',result_feature);
%result_feature = sum((Query_feature-Data_feature).^2).^0.5;
resultValues(i) = {result_feature};
i = i+1;
end
handles.resultValues = resultValues;
% Update handles structure
guidata(hObject, handles);
[Y, FS]=audioread('picture.mp3');
  sound(Y,FS);
warndlg('Process Complete');



% --- Executes on button press in match.
function match_Callback(hObject, eventdata, handles)
% hObject    handle to match (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resultValues = handles.resultValues;

[resultValues_final ind] = sort(cell2mat(resultValues));
%hd=gethammingdistance(a,b,c,d,20);

hd = resultValues_final(1);
 % hd=gethammingdistance(temp1,mask1,temp2,mask2,1);
  fprintf('Hamming distance%d',hd);
set(handles.ans,'String',num2str(hd));
if (hd>0.35) 
  set(handles.ans, 'String', ['HAMMING DISTANCE=',get(handles.ans,'String'), '  SUBJECT IS NOT AUTHENTICATED! ']);
  [Y, FS]=audioread('unmatched.mp3');
  sound(Y,FS);
  fileName=unmatched;
  handles.fileName=fileName;
  guidata(hObject, handles);
 % unmatchdialog();
else
  set(handles.ans, 'String', ['HAMMING DISTANCE=',get(handles.ans,'String'), ' SUBJECT IS AUTHENTICATED! ']); 
  [Y, FS]=audioread('matched.mp3');
  sound(Y,FS);
  fileName=matched;
  handles.fileName=fileName;
  guidata(hObject, handles);
%  matchdialog();
end

% --- Executes on button press in clearbrowse.
function clearbrowse_Callback(hObject, eventdata, handles)
% hObject    handle to clearbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = ones(256,256);
axes(handles.axes1);
imshow(a);
axes(handles.axes2);
imshow(a);
axes(handles.axes4);
imshow(a);
axes(handles.axes5);
imshow(a);


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close irissegment;

