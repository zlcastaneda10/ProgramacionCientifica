%%

imagen = imread('1.pgm', 'PGM');
original = imagen;
if  isa(imagen,'double')==0;
    imagen=double(imagen);
    h=1
end

if  ndims(imagen)==3 
imagen=rgb2gray(imagen/255);
h = 2
end
    

%imshow([original,imagen])
%%

nombre = 'Juan Perez';
x=inputdlg({'High Threshold (<=1)','Low Threshold (>=0)','Gamma'})
set((figure('Name',strcat('MRI_', nombre),'NumberTitle','off')), 'Position', [100, 100, 1880, 325]);

imagen = imread('1.pgm', 'PGM');
im = imagen;

imagen=double(imagen);

imagen=(imagen/255);

gammaImage = imagen.^str2num(x{3});

temp = imagen;
A= str2num(x{1});
B= str2num(x{2});
    imagen(find(temp>=A))=1; imagen(find(temp<=B))=0;
    imagen(find(imagen~=0 & imagen~=1))= (imagen(find(imagen~=0 & imagen~=1))-B)./A-B;
    %warning('off', 'Images:initSize:adjustingMag');
    subplot(1,3,1)
    imshow(im)
    title('ORIGINAL')
    
    subplot(1,3,2)
    imshow(imagen)
    
     title(strvcat('SELECTED INTENSITIES ',strcat('A=',x{1}),strcat('B=',x{2})))
    subplot(1,3,3)
    imshow(gammaImage)
    title(strvcat('ENHANCED',strcat('GAMMA=', x{3})))
    %imshowpair(im, imagen, 'montage')
    
    
    
    
   % imshow(imagen)

    %I=I.^2


%c= find(I>= 0.2)

%I(c) = 0

%c= find(I<= 0.00085)
%I(c) = 1
%imshow(I) 

