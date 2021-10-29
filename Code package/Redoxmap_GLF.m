function varargout = Redoxmap_GLF(varargin)
% REDOXMAP_GLF MATLAB code for Redoxmap_GLF.fig
%      REDOXMAP_GLF, by itself, creates a new REDOXMAP_GLF or raises the existing
%      singleton*.
%
%      H = REDOXMAP_GLF returns the handle to a new REDOXMAP_GLF or the handle to
%      the existing singleton*.
%
%      REDOXMAP_GLF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REDOXMAP_GLF.M with the given input arguments.
%
%      REDOXMAP_GLF('Property','Value',...) creates a new REDOXMAP_GLF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Redoxmap_GLF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Redoxmap_GLF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Redoxmap_GLF

% Last Modified by GUIDE v2.5 28-Sep-2021 07:50:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Redoxmap_GLF_OpeningFcn, ...
                   'gui_OutputFcn',  @Redoxmap_GLF_OutputFcn, ...
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


% --- Executes just before Redoxmap_GLF is made visible.
function Redoxmap_GLF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Redoxmap_GLF (see VARARGIN)

% Choose default command line output for Redoxmap_GLF
handles.output = hObject;
% ha=axes('units','normalized','pos',[0.75 0.85 0.2 0.1]);
% uistack(ha,'down');
% ii=imread('ISL.jpg');
% image(ii);
% set(ha,'handlevisibility','off','visible','off');


iii=imread('Shefcover.png');
image(iii);
set(handles.axesredox, 'visible', 'off');
axes(handles.axesredox);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Redoxmap_GLF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Redoxmap_GLF_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in pushbuttonpre.
function pushbuttonpre_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonpre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xrffilename,xrfilepath]=uigetfile;
cd(xrfilepath);
% choose_xrfredox(handles)
xrfp=h5read(xrffilename,'/xrmmap/roimap/mcasum/U La/cor');
global Xstart
global Ystart
global Xstep
global Ystep
global Xstop
global Ystop
global rowxrf
global columxrf

[rowxrf,columxrf]=size(xrfp);
Xstart=h5read(xrffilename,'/xrmmap/config/scan/start1');
Ystart=h5read(xrffilename,'/xrmmap/config/scan/start2');

Xstep=h5read(xrffilename,'/xrmmap/config/scan/step1');
Ystep=h5read(xrffilename,'/xrmmap/config/scan/step2');

Xstop=h5read(xrffilename,'/xrmmap/config/scan/stop1');
Ystop=h5read(xrffilename,'/xrmmap/config/scan/stop2');
summ=(rowxrf-2)*columxrf;
XRFX=zeros([summ,1]);
XRFY=zeros([summ,1]);
xrffp1=zeros([summ,1]);

k=1;
for i=2:(rowxrf-1)
   for  j=1:columxrf
    xrffp1(k)=xrfp(i,j);  
    XRFY(k)=Ystart+Ystep*(j-1);
    XRFX(k)=Xstart+Xstep*(i-1);
%     ABs(k)=Xstart+Xstep*(i-1);
    k=k+1;
   end
end


handles.redox.XRFY=XRFY;
handles.redox.XRFX=XRFX;
handles.redox.xrffp1=xrffp1;
% global xrffp
% xrffp=Uconcen;

set(handles.pushbuttonpre,'BackgroundColor','1,0,0');
guidata(hObject,handles)
global og;
cd(og);

% --- Executes on button press in pushbuttonf1.
function pushbuttonf1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[xrffilename,xrfilepath]=uigetfile;
cd(xrfilepath);
xrff1=h5read(xrffilename,'/xrmmap/roimap/mcasum/U La/cor');
global rowxrf
global columxrf

summ=(rowxrf-2)*columxrf;
k=1;
xrfff1=zeros([summ,1]);
for i=2:(rowxrf-1)
   for  j=1:columxrf
    xrfff1(k)=xrff1(i,j);    
    k=k+1;
   end
end


handles.redox.xrfff1=xrfff1;
set(handles.pushbuttonf1,'BackgroundColor','1,0,0');
guidata(hObject,handles)
global og;
cd(og);

% --- Executes on button press in pushbuttonf2.
function pushbuttonf2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xrffilename,xrfilepath]=uigetfile;
cd(xrfilepath);
xrff2=h5read(xrffilename,'/xrmmap/roimap/mcasum/U La/cor');
global rowxrf
global columxrf

summ=(rowxrf-2)*columxrf;
k=1;
xrfff2=zeros([summ,1]);
for i=2:(rowxrf-1)
   for  j=1:columxrf
    xrfff2(k)=xrff2(i,j);    
    k=k+1;
   end
end

handles.redox.xrfff2=xrfff2;

set(handles.pushbuttonf2,'BackgroundColor','1,0,0');
guidata(hObject,handles)
global og;
cd(og);



% --- Executes on button press in pushbuttonpost1.
function pushbuttonpost1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonpost1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xrffilename,xrfilepath]=uigetfile;
cd(xrfilepath);
xrfpo1=h5read(xrffilename,'/xrmmap/roimap/mcasum/U La/cor');
global rowxrf
global columxrf
k=1;
summ=(rowxrf-2)*columxrf;

xrffpo1=zeros([summ,1]);
for i=2:(rowxrf-1)
   for  j=1:columxrf
    xrffpo1(k)=xrfpo1(i,j);    
    k=k+1;
   end
end

handles.redox.xrffpo1=xrffpo1;
set(handles.pushbuttonpost1,'BackgroundColor','1,0,0');
guidata(hObject,handles)
global og;
cd(og);

% --- Executes on button press in pushbuttonpost2.
function pushbuttonpost2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonpost2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[xrffilename,xrfilepath]=uigetfile;
cd(xrfilepath);
k=1;
xrfpo2=h5read(xrffilename,'/xrmmap/roimap/mcasum/U La/cor');
global rowxrf
global columxrf

summ=(rowxrf-2)*columxrf;

xrffpo2=zeros([summ,1]);
for i=2:(rowxrf-1)
   for  j=1:columxrf
    xrffpo2(k)=xrfpo2(i,j);    
    k=k+1;
   end
end

handles.redox.xrffpo2=xrffpo2;
set(handles.pushbuttonpost2,'BackgroundColor','1,0,0');
guidata(hObject,handles)
global og;
cd(og);


function editpre_Callback(hObject, eventdata, handles)
% hObject    handle to editpre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editpre as text
%        str2double(get(hObject,'String')) returns contents of editpre as a double
energypre=str2double(get(hObject, 'String'));
if isnan(energypre)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.energypre=energypre;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editpre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editpre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editf1_Callback(hObject, eventdata, handles)
% hObject    handle to editf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editf1 as text
%        str2double(get(hObject,'String')) returns contents of editf1 as a double
energyf1=str2double(get(hObject, 'String'));
if isnan(energyf1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.energyf1=energyf1;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editf2_Callback(hObject, eventdata, handles)
% hObject    handle to editf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editf2 as text
%        str2double(get(hObject,'String')) returns contents of editf2 as a double
energyf2=str2double(get(hObject, 'String'));
if isnan(energyf2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.energyf2=energyf2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function editpo1_Callback(hObject, eventdata, handles)
% hObject    handle to editpo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editpo1 as text
%        str2double(get(hObject,'String')) returns contents of editpo1 as a double
energypo1=str2double(get(hObject, 'String'));
if isnan(energypo1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.energypo1=energypo1;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editpo1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editpo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function editpo2_Callback(hObject, eventdata, handles)
% hObject    handle to editpo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editpo2 as text
%        str2double(get(hObject,'String')) returns contents of editpo2 as a double
energypo2=str2double(get(hObject, 'String'));
if isnan(energypo2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.energypo2=energypo2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editpo2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editpo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editxanes1_Callback(hObject, eventdata, handles)
% hObject    handle to editxanes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editxanes1 as text
%        str2double(get(hObject,'String')) returns contents of editxanes1 as a double
xanesinp1=get(hObject, 'String');
handles.redox.xanesinp1=xanesinp1;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editxanes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editxanes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editxanes2_Callback(hObject, eventdata, handles)
% hObject    handle to editxanes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editxanes2 as text
%        str2double(get(hObject,'String')) returns contents of editxanes2 as a double
xanesinp2=get(hObject, 'String');
handles.redox.xanesinp2=xanesinp2;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function editxanes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editxanes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonref.
function pushbuttonref_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[xanesfilename,xanespath]=uigetfile;
cd(xanespath);
addornot=get(handles.Reflistbox,'string');
% xanesinp2=handles.redox.xanesinp2;
% xanesinp1=handles.redox.xanesinp1;
fid = fopen(xanesfilename);
      scxanes=0;
      while ~feof(fid)
       tline = fgetl(fid);
       Line=regexp(tline,'#  energy');
       scxanes=scxanes+1;
        if Line~=0
            Tit2=regexp(tline,'  ','split');
%             [bool,inx]=ismember(xanesinp1,Tit2);
%             [bool2,inx2]=ismember(xanesinp2,Tit2);
         break
        end
      end
      
      [rt,colt]=size(Tit2);

    if isempty(addornot)
      set(handles.Reflistbox,'String',Tit2(:,3:colt));
    elseif addornot==Tit2(:,3:colt)
        set(handles.Reflistbox,'String',Tit2(:,3:colt));
    else
    set(handles.Reflistbox,'String',vertcat(addornot,Tit2(:,3:colt)));
    
    end

      
%       xanesxrf1=dlmread(xanesfilename,'',scxanes,0);
%      
%       energyf1=handles.redox.energyf1;
%       energyf2=handles.redox.energyf2;
%       [a,b]=size(xanesxrf1);
%        xaneserff1=0;
%        xaneserff2=0; 
%       for i=1:(a-2)
%           if xanesxrf1(i,1)<energyf1&&xanesxrf1(i+1,1)>energyf1
%               xaneserff1=xanesxrf1(i,inx-1);
%                xaneserf2f1=xanesxrf1(i,inx2-1);
%               
%           end
%           if xanesxrf1(i,1)<energyf2&&xanesxrf1(i+1,1)>energyf2
%             xaneserff2=xanesxrf1(i,inx-1);
%              xaneserf2f2=xanesxrf1(i,inx2-1);
%           end
%       end
%      handles.redox.xaneserff1=xaneserff1;
%      handles.redox.xaneserff2=xaneserff2;
%      handles.redox.xaneserf2f1=xaneserf2f1;
%      handles.redox.xaneserf2f2=xaneserf2f2;
%      
guidata(hObject,handles)
global og;
cd(og);


function oxs1_Callback(hObject, eventdata, handles)
% hObject    handle to oxs1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oxs1=str2double(get(hObject, 'String'));
if isnan(oxs1)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.oxs1=oxs1;
guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of oxs1 as text
%        str2double(get(hObject,'String')) returns contents of oxs1 as a double


% --- Executes during object creation, after setting all properties.
function oxs1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oxs1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function oxs2_Callback(hObject, eventdata, handles)
% hObject    handle to oxs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oxs2=str2double(get(hObject, 'String'));
if isnan(oxs2)
    set(hObject, 'String', 0);
    errordlg('Input must be a number','Error');
end
handles.redox.oxs2=oxs2;
guidata(hObject,handles)

% Hints: get(hObject,'String') returns contents of oxs2 as text
%        str2double(get(hObject,'String')) returns contents of oxs2 as a double


% --- Executes during object creation, after setting all properties.
function oxs2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to oxs2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonfinal.
function pushbuttonfinal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonfinal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global xrffpo1
% global xrfff1
% global xrfff2
% global xrffp
global scxanes
global xanesfilename;
global xanespath;
cd(xanespath);
xanesinp2=handles.redox.xanesinp2;
xanesinp1=handles.redox.xanesinp1;
fid = fopen(xanesfilename);
      scxanes=0;
      while ~feof(fid)
       tline = fgetl(fid);
       Line=regexp(tline,'#  energy');
       scxanes=scxanes+1;
        if Line~=0
            Tit2=regexp(tline,'  ','split');
            [bool,inx]=ismember(xanesinp1,Tit2);
            [bool2,inx2]=ismember(xanesinp2,Tit2);
         break
        end
      end

      xanesxrf1=dlmread(xanesfilename,'',scxanes,0);
     
      energyf1=handles.redox.energyf1;
      energyf2=handles.redox.energyf2;
      [a,b]=size(xanesxrf1);
       xaneserff1=0;
       xaneserff2=0; 
      for i=1:(a-2)
          if xanesxrf1(i,1)<energyf1&&xanesxrf1(i+1,1)>energyf1
              xaneserff1=xanesxrf1(i,inx-1);
               xaneserf2f1=xanesxrf1(i,inx2-1);
              
          end
          if xanesxrf1(i,1)<energyf2&&xanesxrf1(i+1,1)>energyf2
            xaneserff2=xanesxrf1(i,inx-1);
             xaneserf2f2=xanesxrf1(i,inx2-1);
          end
      end
%      handles.redox.xaneserff1=xaneserff1;
%      handles.redox.xaneserff2=xaneserff2;
%      handles.redox.xaneserf2f1=xaneserf2f1;
%      handles.redox.xaneserf2f2=xaneserf2f2;

assignin('base','handles',handles);
xrfff1=handles.redox.xrfff1;
xrfff2=handles.redox.xrfff2;
xrffpo1=handles.redox.xrffpo1;
% 
% xaneserff2=handles.redox.xaneserff2;
% xaneserff1=handles.redox.xaneserff1;
% xaneserf2f2=handles.redox.xaneserf2f2;
% xaneserf2f1=handles.redox.xaneserf2f1;
Uf1=xrfff1./xrffpo1;
Uf2=xrfff2./xrffpo1;



XRFY=handles.redox.XRFY;
XRFX=handles.redox.XRFX;

R=Uf2-Uf1;

% xrffp1=handles.redox.xrffp1;
% disp(size(xrffp1))

oxs1=handles.redox.oxs1;
oxs2=handles.redox.oxs2;

if oxs1<oxs2
    oxs=oxs1;
else
    oxs=oxs2;
end

jd=abs((oxs1)-(oxs2));

V1=oxs+jd*(R-(xaneserff2-xaneserff1))./((xaneserf2f2-xaneserf2f1)-(xaneserff2-xaneserff1));
axes(handles.axesredox);


scatter(XRFX, XRFY, 40 , V1 ,'s', 'filled');
axis off;
set(gca,'tickdir','out');
colormap jet;
colorbar;


global Figu2
Figu2=figure(2);
set(figure(2),'visible','off');
figure(2);
scatter(XRFX, XRFY, 40 , V1 ,'s', 'filled');
axis off;
set(gca,'tickdir','out');
colormap jet;
colorbar;
global og;
cd(og);


% --- Executes on selection change in Reflistbox.
function Reflistbox_Callback(hObject, eventdata, handles)
% hObject    handle to Reflistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% Hints: contents = cellstr(get(hObject,'String')) returns Reflistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Reflistbox


% --- Executes during object creation, after setting all properties.
function Reflistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Reflistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Saveit_Callback(hObject, eventdata, handles)
% hObject    handle to Saveit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Figu2

filter={'*.tiff';'*.jpg';'*.fig'};
[FileName,PathName]=uiputfile(filter,'Save File');
if PathName == 0 
 return 
end 
Savef=fullfile(PathName,FileName);
Fig2=getframe(Figu2);
imwrite(Fig2.cdata,Savef);
global og;
cd(og);
