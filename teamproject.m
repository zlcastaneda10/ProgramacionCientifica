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

%TODO cargar todos los pacientes de la carpeta
%Hacer un input para conocer el path

%Lectura de los datos de los pacientes.
    %Seleccionamos el archivo donde se encuentra la base de datos
    folder_name = uigetdir();
   
    %intentamos leer un primer archivo para garantizar que estamos en el
    %lugar correcto
    fid = fopen(strcat(folder_name,'\','000001.txt'));
    cont =1;
    ceros = '00000';
    lista = ''
    



    %while (fid ~= -1)
    while(cont<10)
        
        fclose(fid);
        %Aseguramos que la cantidad de ceros sea correcta
        if cont>9 && cont <100
            ceros = '0000';
        elseif cont >=100
            ceros = '000';
        end
        %creamos la ruta del archivo que se va a leer
        
        ruta = strcat(folder_name,'\',ceros,num2str(cont),'.txt');
      
            fid = fopen(ruta);

            %lineas = strings(6,2);
            %leemos el archivo
            for i = 1:6
               linea = fgetl(fid);
               linea = sscanf(linea, '%s');
               linea = strsplit(linea, ':');
               lineas(i,1) = linea(1);
               lineas(i,2) = linea(2);
            end
            
            I = imread(strcat(folder_name,'\',ceros,num2str(cont),'.png'));
            %assignin('base','foto',I); 


            %Cambio de String a Char 
           
                paciente(cont).PatientID = char(lineas(1,2));
                paciente(cont).Name = char(lineas(2,2));
                paciente(cont).Gender = char(lineas(3,2));
                paciente(cont).Age = char(lineas(4,2));
                paciente(cont).Weight = char(lineas(5,2));
                paciente(cont).Admittance = char(lineas(6,2));
                paciente(cont).Image = I;

           
            lista = strvcat(lista,paciente(cont).PatientID);
            
            fclose(fid);
       
        cont =cont+1;
        
        if cont>9 && cont <100
            ceros = '0000'
        elseif cont >=100
            ceros = '000'
        end
         ruta = strcat(folder_name,'\',ceros,num2str(cont),'.txt');
         fid = fopen(ruta);
    end


%pacientes = struct('ID', {'000001'},'nombre',{'Mendez Caro, Elias Brutus'},'genero',{'male'},'edad',{'15 years'},'peso',{'63 Kg.'},'fecha',{'01/02/2015'}, 'imagen')

set(handles.ID,'String',paciente(1).PatientID);
set(handles.nombre,'String',paciente(1).Name);
set(handles.genero,'String',paciente(1).Gender);
set(handles.edad,'String',paciente(1).Age);
set(handles.peso,'String',paciente(1).Weight);
set(handles.fecha,'String',paciente(1).Admittance);
assignin('base','foto',paciente(1).Image); 
axes(handles.ImagenPaciente);
imshow(paciente(1).Image);

set(handles.listaPacientes, 'String', lista);

handles.lista=lista
guidata(hObject,handles)

handles.paciente=paciente
guidata(hObject,handles)

handles.actual=1
guidata(hObject,handles)


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
s = get(handles.listaPacientes, 'Value');
handles.actual=s;
guidata(hObject,handles)


set(handles.ID,'String',handles.paciente(s).PatientID);
set(handles.nombre,'String',handles.paciente(s).Name);
set(handles.genero,'String',handles.paciente(s).Gender);
set(handles.edad,'String',handles.paciente(s).Age);
set(handles.peso,'String',handles.paciente(s).Weight);
set(handles.fecha,'String',handles.paciente(s).Admittance);


assignin('base','foto',handles.paciente(s).Image); 
axes(handles.ImagenPaciente);
imshow(handles.paciente(s).Image);
set(handles.listaPacientes, 'String', handles.lista);



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
mkdir 'ARCHIVE' 'IDS'
mkdir 'ARCHIVE' 'EGC'
mkdir 'ARCHIVE' 'MRI'
mkdir 'ARCHIVE' 'EXAMS'
folder_name = uigetdir();
folder_name
handles.actual
ruta=folder_name;

strcat(ruta,'\ACTIVE\IDS\',handles.paciente(handles.actual).PatientID,'.txt')
movefile (strcat(ruta,'\ACTIVE\IDS\',handles.paciente(handles.actual).PatientID,'.txt'), strcat(ruta,'\ARCHIVE\IDS'))

movefile (strcat(ruta,'\ACTIVE\IDS\',handles.paciente(handles.actual).PatientID,'.png'), strcat(ruta,'\ARCHIVE\IDS'))
x=str2double(handles.paciente(handles.actual).PatientID)
movefile (strcat(ruta,'\ACTIVE\ECG\',num2str(x),'.bin'), strcat(ruta,'\ARCHIVE\ECG'))
movefile (strcat(ruta,'\ACTIVE\MRI\',num2str(x),'.pgm'), strcat(ruta,'\ARCHIVE\MRI'))
exam=handles.paciente(handles.actual).Name
espacios=findstr(' ',exam)
comas=findstr(',',exam)
exam(espacios)=('_')
exam(comas)=[]
movefile (strcat(ruta,'\ACTIVE\EXAMS\',exam,'.txt'), strcat(ruta,'ARCHIVE\EXAMS'))


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Se creó una variable temporal que contenga los datos del paciente, es un arreglo de celdas
pacienteNuevo=(inputdlg({'Name','Gender','Age','Weight (Kg)','Date Of Admitance (DD/MM/YYY)'}))
[filename,user_canceled] = imgetfile


