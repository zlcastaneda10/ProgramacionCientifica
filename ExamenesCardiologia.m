%Abrir archivo con los datos de los ex?menes
fid = fopen('Angel_Barreto_Miguel_Walter.txt');
%escaneo del archivo txt
M2 = textscan(fid, '%s', 6, 'Delimiter', '\t','MultipleDelimsAsOne',1);
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
Dates = string.empty;
for i=1:contador-1
y = M2{i+1}{1};
Dates(1,i) = y;
end
 
Temp = strings(1,10);
for i=1:contador-1
y = M2{i+1}{3};
Temp(1,i) = y;
end
 
Plow = strings(1,10);
for i=1:contador-1
y = M2{i+1}{4};
Plow(1,i) = y;
end
 
Phigh = strings(1,10);
for i=1:contador-1
y = M2{i+1}{5};
Phigh(1,i) = y;
end
 
Beats = strings(1,10);
for i=1:contador-1
y = M2{i+1}{6};
Beats(1,i) = y;
end
 
%Llamar los arreglos de strings con los datos
Dates
numeroBra = 0;
numeroTac = 0;

figure
subFigure1 = subplot(3,1,1);
x1 = (1:size(Temp));
for i = 1:size(Temp);
    y1(i) = Temp(i);
end
plot(subFigure1,x1,y1,'y')
xlabel('Date')
ylabel('Temperature (?C)')

subFigure2 = subplot(3,1,2);
x1 = (1:size(Phigh));
for i = 1:size(Phigh);
    y1(i) = Phigh(i);
end
for i = 1:size(Plow);
    y2(i) = Plow(i);
end
for i = 1:size(Plow);
    y3(i) = ((Plow(i)+Phigh(i))/2); 
end
plot(subFigure2,x1,y1,'r',x1,y2,'r',x1,y3,'y')
xlabel('Date')
ylabel('Pressure (mmHg)')

subFigure3 = subplot(3,1,3);
x1 = (1:size(Beats));
for i = 1:size(Beats);
    y1(i) = Beats(i);
end
plot(subFigure3,x1,y1,'y')
xlabel('Date')
ylabel('Heart Rate (bpm)')

for i = 1:size(Beats);
    if Beats(i)<60
        numeroBra = numeroBra + 1;
    elseif Beats(i)>100
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