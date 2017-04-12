function varargout = teamproject(varargin)
% TEAMPROJECT MATLAB code for teamproject.fig
%      TEAMPROJECT, by itself, creates a new TEAMPROJECT or raises the existing
%      singleton*.
%
%      H = TEAMPROJECT returns the handle to a new TEAMPROJECT or the handle to
%      the existing singleton*.
%
%      TEAMPROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEAMPROJECT.M with the given input arguments.
%
%      TEAMPROJECT('Property','Value',...) creates a new TEAMPROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before teamproject_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to teamproject_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help teamproject

% Last Modified by GUIDE v2.5 05-Apr-2017 08:49:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @teamproject_OpeningFcn, ...
                   'gui_OutputFcn',  @teamproject_OutputFcn, ...
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


% --- Executes just before teamproject is made visible.
function teamproject_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to teamproject (see VARARGIN)

% Choose default command line output for teamproject
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes teamproject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = teamproject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listaPacientes.
function listaPacientes_Callback(hObject, eventdata, handles)
% hObject    handle to listaPacientes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listaPacientes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listaPacientes


% --- Executes during object creation, after setting all properties.
function listaPacientes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listaPacientes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plotExams.
function plotExams_Callback(hObject, eventdata, handles)
% hObject    handle to plotExams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in AnalyseMRI.
function AnalyseMRI_Callback(hObject, eventdata, handles)
% hObject    handle to AnalyseMRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%comentario rafael%


% --- Executes on button press in dischargePatiente.
function dischargePatiente_Callback(hObject, eventdata, handles)
% hObject    handle to dischargePatiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%comentario%

% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
