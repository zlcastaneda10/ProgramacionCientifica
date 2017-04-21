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
    

imshow([original,imagen])
%%
imagen = imread('1.pgm', 'PGM');
im = imagen;

    imagen=double(imagen);


original=imagen;


imagen=(imagen/255);

imshow([original,imagen, im])

temp = imagen;
A= 0.9;
B= 0.2;
    imagen(find(temp>=A))=1; imagen(find(temp<=B))=0;
    imagen(find(imagen~=0 & imagen~=1))= (imagen(find(imagen~=0 & imagen~=1))-B)./A-B;
    warning('off', 'Images:initSize:adjustingMag');
    imagencntr = imshow([original,imagen]);
   % imshow(imagen)

    %I=I.^2


%c= find(I>= 0.2)

%I(c) = 0

%c= find(I<= 0.00085)
%I(c) = 1
%imshow(I) 