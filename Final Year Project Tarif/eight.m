% RGB = imread('01_L.bmp')
% [X,map] = rgb2ind(RGB, 256);
% imwrite(X,map,'01.bmp');
% K=imread('01.bmp');
% imshow(K);
 rgb_img = imread('IMG_20171118_213347 - Copy.jpg');
% image(r)
% axis image ;
%imtool=('01_L.bmp');
 I= 0.2989 *rgb_img(:,:,1)...
 + 0.5870 * rgb_img(:,:,2)...
 + 0.1140 * rgb_img(:,:,3);
%I= imread('01_L.bmp');
level = graythresh(I);
BW = im2bw(I, level);
%[X,map]=ind2gray(I,255);
%imwrite('I','101.bmp');
I=imresize(I,[280,320]);
imshow(I)
imwrite(I,'1016.bmp');