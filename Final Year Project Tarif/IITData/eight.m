rgb_img = imread('111111 (4).bmp');
 I= 0.2989 *rgb_img(:,:,1)...
 + 0.5870 * rgb_img(:,:,2)...
 + 0.1140 * rgb_img(:,:,3);
level = graythresh(I);
BW = im2bw(I, level);
I=imresize(I,[280,320]);
imshow(I)
imwrite(I,'1114_2.bmp');