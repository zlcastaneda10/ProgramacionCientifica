I = imread('1.pgm', 'PGM');
I= im2double(I);
I = I/255;
imshow(I) 
I=I.^2
c= find(I>= 0.2)

I(c) = 0

c= find(I<= 0.00085)
I(c) = 1
imshow(I) 