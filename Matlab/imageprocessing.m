function varargout = imageprocessing(varargin)
% IMAGEPROCESSING MATLAB code for imageprocessing.fig
%      IMAGEPROCESSING, by itself, creates a new IMAGEPROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSING returns the handle to a new IMAGEPROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEPROCESSING.M with the given input arguments.
%
%      IMAGEPROCESSING('Property','Value',...) creates a new IMAGEPROCESSING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageprocessing_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageprocessing_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageprocessing

% Last Modified by GUIDE v2.5 19-Nov-2012 13:49:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @imageprocessing_OutputFcn, ...
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


% --- Executes just before imageprocessing is made visible.
function imageprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageprocessing (see VARARGIN)

% Choose default command line output for imageprocessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageprocessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageprocessing_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global X;
global xd;
global rc;
siz = size(X);

%to convert RGB image into gray scale
if(siz(3) == 3)
    X = rgb2gray(X);
end;

% inputting the decomposition level and name of the wavelet
n=4;
wname = 'haar';
 
x = double(X);
NbColors = 255;
map = gray(NbColors);
 x = uint8(x);

 
% A wavelet decomposition of the image
[c,s] = wavedec2(x,n,wname);

% wdcbm2 for selecting level dependent thresholds  
alpha = 1.5; m = 2.7*prod(s(1,:));
[thr,nkeep] = wdcbm2(c,s,alpha,m)

% Compression
[xd,cxd,sxd,perf0,perfl2] = wdencmp('lvd',c,s,wname,n,thr,'h');
disp('Compression Ratio');
disp(perf0);

% Decompression
R = waverec2(c,s,wname);
 rc = uint8(R);
 
% Plot original and compressed images.
            subplot(221), image(x); 
            colormap(map); 
            title('Original image')
             subplot(222), image(xd); 
             colormap(map);
title('Compressed image')

% Displaying the results
xlab1 = ['2-norm rec.: ',num2str(perfl2)];
xlab2 = [' %  -- zero cfs: ',num2str(perf0), ' %'];
xlabel([xlab1 xlab2]);
subplot(223), image(rc); 
colormap(map);

title('Reconstructed image');
%Computing the image size
      % disp('Original Image');
      %imwrite(x,'original.tif');
      %imfinfo('original.tif')
disp('Compressed Image');
      %imwrite(xd,'compressed.tif');
      %imfinfo('compressed.tif')
      %disp('Decompressed Image');
      %imwrite(rc,'decompressed.tif');
      %imfinfo('decompressed.tif')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global rc;
global X;
global xd;

subplot(221);
imhist(rc);
subplot(222);


imhist(xd);
subplot(223);
imhist(X);



% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
about;


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function New_Callback(hObject, eventdata, handles)
global X;
[filename, pathname] = uigetfile('*.m', 'Pick a MATLAB code file');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
        
      X=imread(filename);
      imshow(X);
    end


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
delete(get(0,'Children'))


% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
im4=imread('C:\Program Files\MATLAB\R2012a\bin\project\image2.jpg');
imshow(im4);


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
im3=imread('C:\Program Files\MATLAB\R2012a\bin\project\im3.png');
imshow(im3);


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
im1=imread('C:\Program Files\MATLAB\R2012a\bin\project\im1.jpeg');
imshow(im1);
