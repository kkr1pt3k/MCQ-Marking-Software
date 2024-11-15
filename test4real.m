%% MCQ Marking Software
% Author: Emmanuel Asante (BSc Mathematics, UMaT)
% Version: 1.0
% Created on: 11/04/16


function varargout = test4real(varargin)
% TEST4REAL MATLAB code for test4real.fig
%      TEST4REAL, by itself, creates a new TEST4REAL or raises the existing
%      singleton*.
%
%      H = TEST4REAL returns the handle to a new TEST4REAL or the handle to
%      the existing singleton*.
%
%      TEST4REAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST4REAL.M with the given input arguments.
%
%      TEST4REAL('Property','Value',...) creates a new TEST4REAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test4real_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test4real_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test4real

% Last Modified by GUIDE v2.5 18-Apr-2016 08:34:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test4real_OpeningFcn, ...
                   'gui_OutputFcn',  @test4real_OutputFcn, ...
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


% --- Executes just before test4real is made visible.
function test4real_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test4real (see VARARGIN)

% Choose default command line output for test4real
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test4real wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test4real_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadscheme.
function loadscheme_Callback(hObject, eventdata, handles)

global x;

axes(handles.axes1);
% hObject    handle to loadscheme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*', 'Select the marking scheme'); % read the input image
if filename == 0;
    msgbox('No image selected')
    return;
end

x = imread([pathname,filename]);
x = imresize(x, [240, 640]);

imshow(x);




% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla reset;
axes(handles.axes2);
cla reset;
axes(handles.axes3);
cla reset;
axes(handles.axes4);
cla reset;
set(handles.displayresults, 'String', 'Results');




% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in loadstudent.
function loadstudent_Callback(hObject, eventdata, handles)

%% the student's test
global y;
axes(handles.axes3);
% hObject    handle to loadstudent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, pname] = uigetfile('*', 'Select the student test'); % read the input image
if fname == 0;
    msgbox('No image selected')
    return;
end

y = imread([pname,fname]);
y = imresize(y, [240, 640]);

imshow(y);


% --- Executes on button press in saveastext.
function saveastext_Callback(hObject, eventdata, handles)
global str3;
global Str1;
global Str2;
global Str6;

% hObject    handle to saveastext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[newfile, pathName] = uiputfile('*.txt', 'Save the results in a text file');
 fid = fopen(newfile, 'w');
 

fprintf(fid, Str1);
fprintf(fid, Str2);
fprintf(fid, str3);
%fprintf(fid, Str6);
fclose(fid);
    



% --- Executes on button press in mark.
function mark_Callback(hObject, eventdata, handles)
global x;
global y;
global Str2;
global Str1;
global str3;
global num;
global num1;
%global score;
global Str6;

% hObject    handle to mark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% the marking scheme
grayadjust = imadjust(x(:,:,1));
gthresh = graythresh(grayadjust);
binary = 1 - im2bw(grayadjust, gthresh);

% applying the morphologoy
binary1 = imopen(binary, strel('square', 8)); % morphological opening (working well so far)
%binary1 = imclearborder(binary1, 8); this function also removes the blobs
%on the borders and that's not the goal of this software
[Ilabel1, num1] = bwlabel(binary1, 8);

% creating the bounding boxes
Iprt = regionprops(Ilabel1, 'BoundingBox');
boundbox = round(reshape([Iprt.BoundingBox], 4, []).');


% the student's test
gadjust = imadjust(y(:,:,1));
gt = graythresh(gadjust);
bimage = 1 - im2bw(gadjust, gt);

% applying the morphological opening
bimage1 = imopen(bimage, strel('square', 10)); %morphological opening (working well so far)
%bimage1 = imclearborder(bimage1, 8); %removing borders to single out shaded regions
[Ilabel, num] = bwlabel(bimage1, 8);

% measuring image properties and using them to create bounding boxes
Iprt1 = regionprops(Ilabel, 'BoundingBox');
bbox = round(reshape([Iprt1.BoundingBox], 4, []).');


%% displaying the results
axes(handles.axes2);
imshow(x);
for i = 1 : num1
        rectangle('Position', boundbox(i,:), 'edgecolor', 'green');
end

Str1 = ['Total number of questions:          ' num2str(num1) '\r\n'];

%% Now for the feature detection and extraction
corner1  = detectMSERFeatures(bimage1);
corner2  = detectMSERFeatures(binary1);

% extracting neighborhood features
[neifi1, point1] = extractFeatures(bimage1, corner1);
[neifi2, point2] = extractFeatures(binary1, corner2);

% matching features
pairindex = matchFeatures(neifi1, neifi2);

% re-acquiring location of corresponding points
mpoints1 = point1(pairindex(:, 1), :);
mpoints2 = point2(pairindex(:, 2), :);


% drawing a magenta box around selected answers on student's test
axes(handles.axes4);

% showing matched results. The marking scheme is overlayed with the 
% student's test to detect the matched results. The unmatched ones are
% faint
showMatchedFeatures(x, y, mpoints1, mpoints2);

for idx = 1 : num
    if num1 < num;
         score = 0;
       Str6 = ['Student has selected too many boxes! ', ' Score = ', score];
       set(handles.displayresults, 'String', Str6);
       
        return;
    end
    rectangle('Position', bbox(idx,:), 'edgecolor', 'magenta');
end
Str2 = ['Total number of answered questions: ', num2str(num), '\r\n'];
score = (num/num1)*100;
score = sprintf('%0.1f', score);
str3 = ['Percentage Score:                   ', num2str(score), '%'];
set(handles.displayresults, 'String', Str2);
set(handles.displayresults, 'String', str3);




% --- Executes during object creation, after setting all properties.
function displayresults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to displayresults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called