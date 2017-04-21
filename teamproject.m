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

folder_name_exams = strcat(folder_name,'\' ,'ACTIVE','\','EXAMS');
folder_ids = strcat(folder_name,'\' ,'ACTIVE','\','IDS');
folder_name_exams
%intentamos leer un primer archivo para garantizar que estamos en el
%lugar correcto
fid = fopen(strcat(folder_ids,'\','000001.txt'));
fid
cont =1;
ceros = '00000';
lista = ''

while (fid ~= -1)
%while(cont<7)
    
    fclose(fid);
    %Aseguramos que la cantidad de ceros sea correcta
    if cont>9 && cont <100
        ceros = '0000';
    elseif cont >=100
        ceros = '000';
    end
    %creamos la ruta del archivo que se va a leer
    
    ruta = strcat(folder_ids,'\',ceros,num2str(cont),'.txt');
    
    fid = fopen(ruta);
    
    %lineas = strings(6,2);
    %leemos el archivo
    for i = 1:6
        linea = fgetl(fid);
        %linea = sscanf(linea, '%s');
        linea = strsplit(linea, ':');
        lineas(i,1) = linea(1);
        lineas{i,2} = strtrim(linea{2});
    end
    
    I = imread(strcat(folder_ids,'\',ceros,num2str(cont),'.png'));
    %assignin('base','foto',I);
    
    
    %Cambio de String a Char
    
    paciente(cont).PatientID = char(lineas(1,2));
    paciente(cont).Name = lineas(2,2);
    paciente(cont).Gender = char(lineas(3,2));
    paciente(cont).Age = char(lineas(4,2));
    paciente(cont).Weight = char(lineas(5,2));
    paciente(cont).Admittance = char(lineas(6,2));
    paciente(cont).Image = I;
    
    lista = strvcat(lista,paciente(cont).PatientID);
    
    fclose(fid);
%cerrar archivo del paciente
%lectura de examenes
    nombre1 = paciente(cont).Name;
    nombre1 = strrep(nombre1,' ', '_');
    nombre1 = strrep(nombre1,',', '');
    
    archivo = strcat(folder_name_exams,'\',nombre1,'.txt');
    fid = fopen(char(archivo));
    
    %escaneo del archivo txt
    M2 = textscan(fid , '%s', 6, 'Delimiter', '\t','MultipleDelimsAsOne',1);
    contador = 0;
    i = 1;
    %Crear el array de cells con los datos
    while ~isempty(M2{i});
        i = i + 1;
        A = textscan(fid, '%s',6, 'Delimiter', '\t','MultipleDelimsAsOne',1);
        M2{i} = A{1};
        contador = contador + 1;
    end
    
    
    %Asignar los datos de cada categoria a un arreglo de strings
    Dates = '';
    for i=1:contador-1
        y = M2{i+1}{1};
        Dates = strvcat(Dates, y);
    end
    
    
    Temp = '';
    for i=1:contador-1
        y = M2{i+1}{3};
        Temp = strvcat(Temp, y);
    end
    tempPromedio1 = Temp/contador-1;
    
    
    Plow = '';
    for i=1:contador-1
        y = M2{i+1}{4};
         Plow = strvcat(Plow, y);
    end
    
    Phigh = '';
    for i=1:contador-1
        y = M2{i+1}{5};
        Phigh = strvcat(Phigh, y);
    end
    
    
    Beats = '';
    for i=1:contador-1
        y = M2{i+1}{6};
          Beats = strvcat(Beats, y);
    end
    
    
    examenes(cont).Dates = Dates
    examenes(cont).Plow = Plow;
    examenes(cont).Temp = tempPromedio1
    examenes(cont).Phigh = Phigh
    examenes(cont).Beats = Beats
    fclose(fid);
    cont =cont+1;
     if cont>9 && cont <100
        ceros = '0000';
    elseif cont >=100
        ceros = '000';
    end
    ruta = strcat(folder_ids,'\',ceros,num2str(cont),'.txt');
    fid = fopen(ruta);
    fid
    
   
end

tempTotal =0
for i = 1:cont-1
    tempTotal = tempTotal + str2double(examenes(i).Temp );
end
tempPromedio = tempTotal/cont;
handles.MeanTemp = tempPromedio;
handles.ultimoID=cont;
guidata(hObject,handles);

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

%lista de los pacientes en el listbox  
handles.lista=lista;
guidata(hObject,handles);

%estructura de pacientes
handles.paciente=paciente;
guidata(hObject,handles);

%variable que almacena el paciente actual 
handles.actual=1;
guidata(hObject,handles);

%ruta?
handles.rutaPrincipal=folder_name;
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
set(handles.listaPacientes, 'String', handles.lista);
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
%Abrir archivo con los datos de los ex?menes

folder_name = strcat(handles.rutaPrincipal,'\' ,'ACTIVE','\','EXAMS');
nombre1 = handles.paciente(handles.actual).Name;
nombre1 = strrep(nombre1,' ', '_');
nombre1 = strrep(nombre1,',', '');
archivo = strcat(folder_name,'\',nombre1,'.txt')

fid = fopen(char(archivo));
%escaneo del archivo txt
M2 = textscan(fid , '%s', 6, 'Delimiter', '\t','MultipleDelimsAsOne',1);
contador = 0;
i = 1;
%Crear el array de cells con los datos
while ~isempty(M2{i});
    i = i + 1;
    A = textscan(fid, '%s',6, 'Delimiter', '\t','MultipleDelimsAsOne',1);
    M2{i} = A{1};
    contador = contador + 1;
end

%Asignar los datos de cada categoria a un arreglo de strings
Dates = '';
for i=1:contador-1
    y = M2{i+1}{1};
    Dates = strvcat(Dates, y);
end


Temp = '';
for i=1:contador-1
    y = M2{i+1}{3};
    Temp = strvcat(Temp, y);
end

Plow = '';
for i=1:contador-1
    y = M2{i+1}{4};
    Plow = strvcat(Plow, y);
end

Phigh = '';
for i=1:contador-1
    y = M2{i+1}{5};
    Phigh = strvcat(Phigh, y);
end


Beats = '';
for i=1:contador-1
    y = M2{i+1}{6};
    Beats = strvcat(Beats, y);
end

numeroBra = 0;
numeroTac = 0;

figure
subFigure1 = subplot(3,1,1);
sizeTemp =size(Temp);
x1 = (1:sizeTemp(1));
y1 = '';
for i = 1:sizeTemp(1);
    y1 = strvcat(y1,Temp(i,:));
end

plot(subFigure1,x1,str2num(y1),'y',x1,handles.MeanTemp,'b')
xlabel('Date')
ylabel('Temperature (?C)')

subFigure2 = subplot(3,1,2);
sizePhigh = size(Phigh);
sizePlow = size(Plow);
x1 = (1:sizePhigh(1));
y1 = '';
for i = 1:sizePhigh(1);
    y1 = strvcat(y1,Phigh(i,:));
end
y2 = '';
for i = 1:sizePlow(1);
    y2 = strvcat(y2,Plow(i,:));
end
y3 = '';
for i = 1:sizePlow(1);
    suma1 = str2num(y1(i,:));
    suma2 = str2num(y2(i,:));
    mean = (suma1+suma2)/2;
    y3 = strvcat(y3,num2str(mean));
end
plot(subFigure2,x1,str2num(y1),'r',x1,str2num(y2),'r',x1,str2num(y3),'y')
xlabel('Date')
ylabel('Pressure (mmHg)')

subFigure3 = subplot(3,1,3);
sizeBeats = size(Beats);
x1 = (1:sizeBeats(1));
y1 = '';
for i = 1:sizeBeats(1);
    y1 = strvcat(y1,Beats(i,:));
end
plot(subFigure3,x1,str2num(y1),'y')
xlabel('Date')
ylabel('Heart Rate (bpm)')



for i = 1:sizeBeats(1);
    if str2num(Beats(i,:))<60
        numeroBra = numeroBra + 1;
    elseif str2num(Beats(i,:))>100
        numeroTac = numeroTac + 1;
    end
end

if numeroBra>0 && numeroTac>0
    msgbox(['The patient has ', num2str(numeroBra), ' alerts as a bradychardic patient, and ', num2str(numeroTac)] , ' alerts as a tachycardic patient.','Alert')
elseif numeroBra>0
    msgbox(['The patient has ', num2str(numeroBra), ' alerts as a bradychardic patient.'],'Alert');
elseif numeroTac>0
    msgbox(['The patient has ', num2str(numeroTac), ' alerts as a tachycardic patient.'],'Alert');
end



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

folder_name = strcat(handles.rutaPrincipal,'\' ,'ACTIVE','\','EXAMS');
folder_archivo = strcat(handles.rutaPrincipal,'\ARCHIVE')

mkdir (folder_archivo, 'IDS')
mkdir (folder_archivo, 'EGC')
mkdir (folder_archivo,'MRI')
mkdir (folder_archivo, 'EXAMS')

ruta=handles.rutaPrincipal;

strcat(ruta,'\ACTIVE\IDS\',handles.paciente(handles.actual).PatientID,'.txt')
movefile (strcat(ruta,'\ACTIVE\IDS\',handles.paciente(handles.actual).PatientID,'.txt'), strcat(ruta,'\ARCHIVE\IDS'))

movefile (strcat(ruta,'\ACTIVE\IDS\',handles.paciente(handles.actual).PatientID,'.png'), strcat(ruta,'\ARCHIVE\IDS'))
x=str2double(handles.paciente(handles.actual).PatientID)
movefile (strcat(ruta,'\ACTIVE\ECG\',num2str(x),'.bin'), strcat(ruta,'\ARCHIVE\ECG'))
movefile (strcat(ruta,'\ACTIVE\MRI\',num2str(x),'.pgm'), strcat(ruta,'\ARCHIVE\MRI'))
exam=handles.paciente(handles.actual).Name
regexprep(exam,',','')
regexprep(exam,' ','_')

strcat(ruta,'\ACTIVE\EXAMS\',exam,'.txt')
st= strcat(ruta,'\ARCHIVE\EXAMS')


%TODO eliminar pacientes de la lista

%movefile (strcat(ruta,'\ACTIVE\EXAMS\',exam,'.txt'), strcat(ruta,'\ARCHIVE\EXAMS\'))
%handles.lista(handles.actual,:)= 'eliminado'
%handles.actual=1;
%handles.listaPacientes.value =1

set(handles.listaPacientes, 'String', handles.lista);
guidata(hObject,handles);


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Se cre?? una variable temporal que contenga los datos del paciente, es un arreglo de celdas

ruta= handles.rutaIDS;
x=inputdlg({'Name','Gender','Age','Weight (Kg)','Date Of Admittance (DD/MM/YYY)'})
if ~isstring(x{1})||~isstring(x{2})||~isnumeric(x{3})||~isnumeric(x{4})
k= msgbox('your input mismatch with the needed input, remember name and gender should be strings and the rest should be numerical.','Add Patient','Warning');
end
id=handles.ultimoID
handles.ultimoID= handles.ultimoID+1
idn=sprintf('%06d',id);
(strcat(ruta,'\',idn,'.txt'))
fid=fopen((strcat(ruta,'\',idn,'.txt')),'w');
fprintf(fid,'Patient ID:\t%s\nName:  \t%s\nGender:  \t%s\nAge:  \t%s\nWeight:  \t%s\nAdmittance:  \t%s\n',idn,x{1},x{2},x{3},x{4},x{5});
fclose (fid);

[filename,user_canceled] = imgetfile
%revisar
I = imread(filename);
imshow(I)
%print(I, '-dpng', (strcat(ruta,'\',idn,'.png')));
imwrite(I,(strcat(ruta,'\',idn,'.png')), 'PNG')

handles.paciente(id).PatientID = idn;
handles.paciente(id).Name =x{1};
handles.paciente(id).Gender = x{2};
handles.paciente(id).Age = x{3};
handles.paciente(id).Weight = x{4};
handles.paciente(id).Admittance = x{5};
handles.paciente(id).Image = I;
handles.lista = strvcat(handles.lista, num2str(idn))
handles.lista
set(handles.listaPacientes, 'String', handles.lista);
guidata(hObject,handles);


