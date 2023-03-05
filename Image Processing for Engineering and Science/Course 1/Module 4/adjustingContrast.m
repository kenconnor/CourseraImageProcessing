clear
clc
close all

img = imread("../../data/Data/Concrete Crack Images/00035.jpg");
imgBin = ~imbinarize(im2gray(img));
%imshow(imgBin)
montage({img,imgBin})
nnz(imgBin)

%%
grayImg = im2gray(img);
img2 = imread("img2.bmp");
%imhist(img2)
imgBin2 = ~imbinarize(img2);
%imshow(imgBin2)
montage({img,imgBin2})
nnz(imgBin2)
%%
grayImg = im2gray(img);
imgEq = ~imbinarize(histeq(grayImg));
%imshow(imgEq)
montage({img,imgEq})
nnz(imgEq)
%%
grayImg = im2gray(img);
imgAd = ~imbinarize(adapthisteq(grayImg));
%imshow(imgAd)
montage({img,imgAd})
nnz(imgAd)


%%
clear
clc
close all

img = imread("car_3.jpg");
imgLB = imlocalbrighten(img);
montage({img,imgLB})
disp(mean2(im2gray(imgLB)) - mean2(im2gray(img)))

%%
img = imread("car_2.jpg");
res = im2double(rgb2hsv(img));
res(:,:,3) = histeq(res(:,:,3));
postimg = im2uint8(hsv2rgb(res));
%montage({img,postimg})
disp(mean2(im2gray(postimg)) - mean2(im2gray(img)))

%%
img = imread("../../data/Data/MathWorks Images/mountain2.jpg");
imgRH = imreducehaze(img);
%montage({img,imgRH})
disp(mean2(im2gray(imgRH)) - mean2(im2gray(img)))

%%
img = imread("../../data/Data/MathWorks Images/picks.jpg");
grayImg = im2gray(img);
imshow(imlocalbrighten(grayImg))
% res: 14