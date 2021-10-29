function varargout = XRD_2d(varargin)
% XRD_2D MATLAB code for XRD_2d.fig
%      XRD_2D, by itself, creates a new XRD_2D or raises the existing
%      singleton*.
%
%      H = XRD_2D returns the handle to a new XRD_2D or the handle to
%      the existing singleton*.
%
%      XRD_2D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XRD_2D.M with the given input arguments.
%
%      XRD_2D('Property','Value',...) creates a new XRD_2D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before XRD_2d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to XRD_2d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help XRD_2d

% Last Modified by GUIDE v2.5 25-Sep-2021 08:35:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @XRD_2d_OpeningFcn, ...
                   'gui_OutputFcn',  @XRD_2d_OutputFcn, ...
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


% --- Executes just before XRD_2d is made visible.
function XRD_2d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to XRD_2d (see VARARGIN)

% Choose default command line output for XRD_2d
handles.output = hObject;

iii=imread('Shefcover.png');
image(iii);
set(handles.axesxrd, 'visible', 'off');
axes(handles.axesxrd);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes XRD_2d wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = XRD_2d_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Load H5 file
[xrdfilename,xrdpath]=uigetfile;
cd(xrdpath);
dset=h5read(xrdfilename,'/entry/data/data');
% Load 2 theta range
theta=h5read(xrdfilename,'/entry/data/2-theta');
[thetasize,~]=size(theta);
% Load Colum range
Colu=h5read(xrdfilename,'/entry/data/col');
[col,~]=size(Colu);
% Load row range
Row=h5read(xrdfilename,'/entry/data/row');
[row1,~]=size(Row);
% Total XRD
total=zeros([thetasize,1]);

for i=1:col
  for  j=1:row1
          total=total+dset(:,i,j);
  end
end
axes(handles.axesxrd);
plot(theta,total);

handles.xrd.theta=theta;
handles.xrd.dset=dset;
handles.xrd.Row=Row;
handles.xrd.Colu=Colu;
guidata(hObject, handles);
global og;
cd(og);

% --- Executes on button press in pushbuttonxrf.
function pushbuttonxrf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonxrf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xrffilename,xrfpath]=uigetfile;
cd(xrfpath);
xrf=dlmread(xrffilename,'',2,0);
XRDY=xrf(:,1);
XRDX=xrf(:,2);
[xrfl,xrfw]=size(xrf);

handles.xrf.xrfl=xrfl;
handles.xrf.XRDX=XRDX;
handles.xrf.XRDY=XRDY;
guidata(hObject, handles);
global og;
cd(og);


% --- Executes on button press in pushbuttoncif.
function pushbuttoncif_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ciffilename,ciffilepath]=uigetfile;
cd(ciffilepath);
cif=dlmread(ciffilename,'',1,0);
Red=cif(:,8);
cifname=ciffilename(1:end-4);
set(handles.textcif1,'string',cifname);
set(handles.textcif12,'string',cifname);
set(handles.textcif13,'string',cifname);
handles.cif.Red=Red;
guidata(hObject, handles);
global og;
cd(og);






% --- Executes on button press in pushbuttoncif2.
function pushbuttoncif2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncif2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ciffilename,ciffilepath]=uigetfile;
cd(ciffilepath);
cif=dlmread(ciffilename,'',1,0);
Brown=cif(:,8);
cifname=ciffilename(1:end-4);
set(handles.textcif2,'string',cifname);
a=get(handles.textcif12,'string');
set(handles.textcif12,'string',strcat(a,'&&',cifname));
set(handles.textcif13,'string',strcat(a,'&&',cifname));
set(handles.textcif23,'string',cifname);
handles.cif.Brown=Brown;
guidata(hObject, handles);
global og;
cd(og);

% --- Executes on button press in pushbuttoncif3.
function pushbuttoncif3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncif3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ciffilename,ciffilepath]=uigetfile;
cd(ciffilepath);
cif=dlmread(ciffilename,'',1,0);
Blue=cif(:,8);
cifname=ciffilename(1:end-4);
set(handles.textcif3,'string',cifname);
b=get(handles.textcif23,'string');
set(handles.textcif23,'string',strcat(b,'&&',cifname));

b=get(handles.textcif13,'string');
set(handles.textcif13,'string',strcat(b,'&&',cifname));

handles.cif.Blue=Blue;
guidata(hObject, handles);
global og;
cd(og);

% --- Executes on button press in pushbuttoncif4.
function pushbuttoncif4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncif4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ciffilename,ciffilepath]=uigetfile;
cd(ciffilepath);
cif=dlmread(ciffilename,'',1,0);
Yellow=cif(:,8);
cifname=ciffilename(1:end-4);
set(handles.textcif4,'string',cifname);
handles.cif.Yellow=Yellow;
guidata(hObject, handles);
global og;
cd(og);

% --- Executes on button press in pushbuttoncif5.
function pushbuttoncif5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttoncif5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ciffilename,ciffilepath]=uigetfile;
cd(ciffilepath);
cif=dlmread(ciffilename,'',1,0);
Green=cif(:,8);
cifname=ciffilename(1:end-4);
set(handles.textcif5,'string',cifname);
handles.cif.Green=Green;
guidata(hObject, handles);
global og;
cd(og);

function cifwave_Callback(hObject, eventdata, handles)
% hObject    handle to cifwave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cifw=str2double(get(hObject, 'String'));
if isnan(cifw)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.cif.cifw=cifw;
guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of cifwave as text
%        str2double(get(hObject,'String')) returns contents of cifwave as a double


% --- Executes during object creation, after setting all properties.
function cifwave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cifwave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xrdwave_Callback(hObject, eventdata, handles)
% hObject    handle to xrdwave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xrdw=str2double(get(hObject, 'String'));
if isnan(xrdw)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.cif.xrdw=xrdw;
guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of xrdwave as text
%        str2double(get(hObject,'String')) returns contents of xrdwave as a double


% --- Executes during object creation, after setting all properties.
function xrdwave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xrdwave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonbuild.
function pushbuttonbuild_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonbuild (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dset=handles.xrd.dset;
Row=handles.xrd.Row;
Colu=handles.xrd.Colu;
[col,~]=size(Colu);
[row1,~]=size(Row);
Yellow=handles.cif.Yellow;
Red=handles.cif.Red;
Blue=handles.cif.Blue;
Brown=handles.cif.Brown;
Green=handles.cif.Green;
xrfl=handles.xrf.xrfl;
colour=zeros([xrfl,3]);
theta=handles.xrd.theta;
xrdw=handles.cif.xrdw;
cifw=handles.cif.cifw;
theta=asin(sin(theta/360*pi)*cifw./xrdw)*360/pi;



for i=1:col
  for  j=1:row1
    pixel=dset(:,i,j);
    number=(j-1)*col+i;
    
   [peakh,peakl]=findpeaks(pixel,theta,'SortStr','descend','NPeaks',3);
    
    for z=1:size(Red)
         thetadev1=abs(peakl-Red(z));
        for t=1:size(thetadev1)
         if thetadev1(t)<0.1
             if peakl(t)<38.6
              colour(number,1)=1;
             end
         end
        end
    end
     
     for z=1:size(Brown)
         thetadev2=abs(peakl-Brown(z));
        for t=1:size(thetadev2)
         if thetadev2(t)<0.1
             if peakl(t)<38.6
              colour(number,2)=1;
             end
         end
        end
     end
     
     
     for z=1:size(Blue)
         thetadev3=abs(peakl-Blue(z));
        for t=1:size(thetadev3)
         if thetadev3(t)<0.1
             if peakl(t)<38.6
              colour(number,3)=1;
             end
         end
        end
     end
     
     for z=1:size(Yellow)
         thetadev4=abs(peakl-Yellow(z));
        for t=1:size(thetadev4)
         if thetadev4(t)<0.1
             if peakl(t)<38.6
              colour(number,1)=0.5;
              colour(number,2)=0;
              colour(number,3)=0;
             end
         end
        end
     end
  
      for z=1:size(Green)
         thetadev5=abs(peakl-Green(z));
        for t=1:size(thetadev5)
         if thetadev5(t)<0.1
             if peakl(t)<38.6
              colour(number,1)=0;
              colour(number,2)=0.5;
              colour(number,3)=0;
             end
         end
        end
      end
     
   end
end

  for i=1:xrfl
%     Glass
   if colour(i,1)==0 && colour(i,2)==0 &&  colour(i,3)==0
       colour(i,3)=0.5;
          colour(i,2)=0.5;
          colour(i,1)=0.5; 
   end
   
%  Red
     if colour(i,1)==1  && colour(i,2)==0 &&  colour(i,3)==0
          colour(i,3)=0.25;
          colour(i,2)=0.07;
          colour(i,1)=0.82;
     end
     

     
% Brown
      if colour(i,1)==0  && colour(i,2)==0.5 &&  colour(i,3)==0

          colour(i,3)=0.15;
          colour(i,2)=0.35;
          colour(i,1)=0.65;
      end
     
% Blue      
     if  colour(i,1)==0 && colour(i,2)==0 && colour(i,3)==1 
                  
          colour(i,3)=0.86;
          colour(i,2)=0.07;
          colour(i,1)=0.25;   
     end
     
     

     
  % Red & Blue
    if colour(i,1)==1  && colour(i,2)==0 &&  colour(i,3)==1
          colour(i,3)=0;
          colour(i,2)=0.7;
          colour(i,1)=0.8;
    end
    
% Red & Brown
     if colour(i,1)==1  && colour(i,2)==1 &&  colour(i,3)==0
          colour(i,3)=0.2;
          colour(i,2)=0.45;
          colour(i,1)=0.95;
     end
     
   % Brown & Blue
    if colour(i,1)==1  && colour(i,2)==0 &&  colour(i,3)==1
          colour(i,3)=0.86;
          colour(i,2)=0.07;
          colour(i,1)=0.25;
    end
  
  % All
    if colour(i,1)==1  && colour(i,2)==0 &&  colour(i,3)==1
          colour(i,3)=0;
          colour(i,2)=0.7;
          colour(i,1)=0.8;
    end
  
  
%      Yellow
    if colour(i,1)==0.5  && colour(i,2)==0 &&  colour(i,3)==0
          colour(i,3)=0.15;
          colour(i,2)=0.77;
          colour(i,1)=1;
    end
    
%      Green
    if colour(i,1)==0  && colour(i,2)==0.5 &&  colour(i,3)==0
          colour(i,3)=0;
          colour(i,2)=0.69;
          colour(i,1)=0.35;
    end    
    
        
  end
 

XRDX=handles.xrf.XRDX;
XRDY=handles.xrf.XRDY;

axes(handles.axesxrd);
scatter(XRDX,XRDY,30,colour,'s','filled');
axis off;

global Figu3
Figu3=figure(3);
set(figure(3),'visible','off');
figure(3);
axes(handles.axesxrd);
scatter(XRDX,XRDY,30,colour,'s','filled');
axis off;
global og;
cd(og);

       






% --------------------------------------------------------------------
function Saveit_Callback(hObject, eventdata, handles)
% hObject    handle to Saveit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Figu3

filter={'*.tiff';'*.jpg';'*.fig'};
[FileName,PathName]=uiputfile(filter,'Save File');
if PathName == 0 
 return 
end 
Savef=fullfile(PathName,FileName);
Fig3=getframe(Figu3);
imwrite(Fig3.cdata,Savef);
global og;
cd(og);