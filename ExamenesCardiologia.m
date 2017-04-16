infoPacienteT = [40.1 ;32.5 ;39 ;37.2 ;33.9 ;42.9 ;41.1 ;36.9 ;37.2 ;38.2];
infoPacientePHigh = [67 ;57 ;50 ;48 ;45 ;64 ;59 ;63 ;66 ;82];
infoPacientePLow = [106 ;126 ;109 ;112 ;130 ;127 ;103 ;97 ;118 ;117];
infoPacienteHR = [72 ; 62 ; 60 ; 62 ; 60 ; 52 ; 44 ; 52 ; 45 ; 61];
numeroBra = 0;
numeroTac = 0;

figure
subFigure1 = subplot(3,1,1);
x1 = (1:size(infoPacienteHR));
for i = 1:size(infoPacienteHR);
    y1(i) = infoPacienteHR(i);
end
plot(subFigure1,x1,y1,'y')
xlabel('Date')
ylabel('Heart Rate (bpm)')

subFigure1 = subplot(3,1,2);
x1 = (1:size(infoPacientePHigh));
for i = 1:size(infoPacientePHigh);
    y1(i) = infoPacientePHigh(i);
end
for i = 1:size(infoPacientePLow);
    y2(i) = infoPacientePLow(i);
end
for i = 1:size(infoPacientePLow);
    y3(i) = ((infoPacientePLow(i)+infoPacientePHigh(i))/2); 
end
plot(subFigure1,x1,y1,'r',x1,y2,'r',x1,y3,'y')
xlabel('Date')
ylabel('Pressure (mmHg)')

subFigure1 = subplot(3,1,3);
x1 = (1:size(infoPacienteHR));
for i = 1:size(infoPacienteHR);
    y1(i) = infoPacienteHR(i);
end
plot(subFigure1,x1,y1,'y')
xlabel('Date')
ylabel('Heart Rate (bpm)')

for i = 1:size(infoPacienteHR);
    if infoPacienteHR(i)<60
        numeroBra = numeroBra + 1;
    elseif infoPacienteHR(i)>100
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