

im1 = imread('D:\图像作业\lesson-01_采样头个数识别\01.png');
% figure(1);imshow(im1);
img1 = rgb2gray(im1);
figure(1);imshow(img1);
img1 = medfilt2(img1);
bw = im2bw(img1,0.5);
% se=[1 1 1;1 1 1;1 1 1];
% bw1=imerode(bw,se);
figure,imshow(bw1);
l1 = bwlabel(bw1);
s1 = regionprops(l1,'Area');
% regionprops(img1,Centorl


im2 = imread('D:\图像作业\lesson-01_采样头个数识别\02.png');
img2 = rgb2gray(im2);
figure(2);imshow(img2);
img2 = medfilt2(img2);
img2 = histeq(img2);
graythresh(img2)
bw2 = im2bw(img2,graythresh(img2));
se1 = strel('disk',11)
bw2 = imerode(bw2,se);
figure(2);imshow(bw2);
se = strel('disk',2);
openbw2 = imopen(bw2,se);




im3 = imread('D:\图像作业\lesson-01_采样头个数识别\03.png');
img3 = rgb2gray(im3);
figure(3);imshow(img3);
img3 = medfilt2(img3);
bw3 = im2bw(img3,0.7);
figure(3);imshow(bw3);





