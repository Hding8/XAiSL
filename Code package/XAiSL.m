function varargout = XAiSL(varargin)
% XAISL MATLAB code for XAiSL.fig
%      XAISL, by itself, creates a new XAISL or raises the existing
%      singleton*.
%
%      H = XAISL returns the handle to a new XAISL or the handle to
%      the existing singleton*.
%
%      XAISL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in XAISL.M with the given input arguments.
%
%      XAISL('Property','Value',...) creates a new XAISL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before XAiSL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to XAiSL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help XAiSL

% Last Modified by GUIDE v2.5 07-Oct-2021 03:16:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @XAiSL_OpeningFcn, ...
                   'gui_OutputFcn',  @XAiSL_OutputFcn, ...
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


% --- Executes just before XAiSL is made visible.
function XAiSL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to XAiSL (see VARARGIN)

% Choose default command line output for XAiSL
handles.output = hObject;
ha=axes('units','normalized','pos',[0.75 0.85 0.2 0.1]);
uistack(ha,'down');
ii=imread('ISL.jpg');
image(ii);
set(ha,'handlevisibility','off','visible','off');


iii=imread('Shefcover.png');
image(iii);
set(handles.xrfaxes, 'visible', 'off');
axes(handles.xrfaxes);
global og;
og=pwd;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes XAiSL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = XAiSL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Fileme_Callback(hObject, eventdata, handles)
% hObject    handle to Fileme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Analysisme_Callback(hObject, eventdata, handles)
% hObject    handle to Analysisme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Openxrfme_Callback(hObject, eventdata, handles)
% hObject    handle to Openxrfme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

choose_xrffile(handles);
global og;
cd(og);

% --------------------------------------------------------------------
function OpenXANES_Callback(hObject, eventdata, handles)
% hObject    handle to OpenXANES (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choose_xanesfile(handles);
global og;
cd(og);

% --------------------------------------------------------------------
function openxrd_Callback(hObject, eventdata, handles)
% hObject    handle to openxrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choose_xrdfile(handles);
global og;
cd(og);

% --------------------------------------------------------------------
function Saveme_Callback(hObject, eventdata, handles)
% hObject    handle to Saveme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in button1.
% save_figure(handles);
global Figu

filter={'*.tiff';'*.jpg';'*.fig'};
[FileName,PathName]=uiputfile(filter,'Save File');
if PathName == 0 
 return 
end 
Savef=fullfile(PathName,FileName);
Fig=getframe(Figu);
imwrite(Fig.cdata,Savef);
global og;
cd(og);





% --- Executes on selection change in xrfbox.
function xrfbox_Callback(hObject, eventdata, handles)
% hObject    handle to xrfbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: contents = cellstr(get(hObject,'String')) returns xrfbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xrfbox
show_xrfelement(handles);
global og;
cd(og);


% --- Executes during object creation, after setting all properties.
function xrfbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xrfbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.



if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in xrfelementbox.
function xrfelementbox_Callback(hObject, eventdata, handles)
% hObject    handle to xrfelementbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xrfelementbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xrfelementbox
show_xrf(handles);
global og;
cd(og);

% --- Executes during object creation, after setting all properties.
function xrfelementbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xrfelementbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over xrfbox.
function xrfbox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to xrfbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gca,'XColor',get(gca,'Color')) ;
set(gca,'YColor',get(gca,'Color'));
 
set(gca,'XTickLabel',[]); 
set(gca,'YTickLabel',[]);


% --------------------------------------------------------------------
function Redoxmap_Callback(hObject, eventdata, handles)
% hObject    handle to Redoxmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)








% --- Executes on selection change in xanesbox.
function xanesbox_Callback(hObject, eventdata, handles)
% hObject    handle to xanesbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xanesbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xanesbox
show_xanes(handles);
global og;
cd(og);


% --- Executes during object creation, after setting all properties.
function xanesbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xanesbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Linearfunction_Callback(hObject, eventdata, handles)
% hObject    handle to Linearfunction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Redoxmap_GLF;
global og;
cd(og);


% --------------------------------------------------------------------
function XRDconstruction_Callback(hObject, eventdata, handles)
% hObject    handle to XRDconstruction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
XRD_2d;
global og;
cd(og);


% --- Executes on selection change in listboxxrd.
function listboxxrd_Callback(hObject, eventdata, handles)
% hObject    handle to listboxxrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listboxxrd contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listboxxrd


% --- Executes during object creation, after setting all properties.
function listboxxrd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxxrd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function NLR_Callback(hObject, eventdata, handles)
% hObject    handle to NLR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Redoxmap_NLR;
global og;
cd(og);
