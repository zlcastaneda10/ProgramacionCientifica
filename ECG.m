b = fopen('1.bin');
c = fread(b,'single');
pks = findpeaks(c);
pks = pks( pks>=0 );
num = size(pks)/(250/60);
if num(1)>100
    %Esto hay que cambiarlo
    msgbox('The patient has an alert as a tachycardic patient.','Alert');
elseif num(1)<60
    msgbox('The patient has an alert as a bradychardic patient.','Alert');
end