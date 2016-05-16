% img2 = imread('D:\图像作业\lesson-01_采样头个数识别\02.png');
% img2 = rgb2gray(img2);
% hist_im = imhist(img2);
% bar(hist_im);
% plot(hist_im);
% imtool(img2);
close all;
clear all;

img2 = imread('D:\图像作业\lesson-01_采样头个数识别\03.png');
imgh2 = rgb2gray(img2);
h1 = histeq(imgh2);
% figure(20);imshow(imgh2);
% figure(21);imhist(imgh2);
% figure(22);imhist(h1);
% figure(23);imshow(h1);
% h = im2double(img2);
% img2 = rgb2hsi(imgd2);
% hist_im = imhist(img2);
% bar(hist_im);
% plot(hist_im);
% imtool(img2);
% I1 = rgb2hsv(h);
% Ir = I1(:,:,1);
% Ig = I1(:,:,2);
% Ib = I1(:,:,3);

% figure(2);imshow(Ir);
% figure(3);imshow(Ig);
% hIg = imhist(Ig);
% imshow(hIg);
% figure(4);imshow(Ib);
% bw = im2bw(Ir,0.6);
% figure(5);imshow(bw);
% Ir = edge(Ir,'sobel');
% figure(7);imshow(Ir);
% se=[1 1 1;1 1 1;1 1 1];
% bw=imerode(bw,se);
% figure(6);imshow(bw);
% imtool(Ig);
% for j=1:480
%     for i=1:640
%         Ic(j,i) = Ig(j,i)*0.2;
%     end
% end
% 
% if (Ic(j,i)>0.065)
%     fhIc(j,i) = Ic(j,i);
% end
% hIc = imhist(Ic);
% figure(71);imhist(Ic);
% figure(72);imshow(fhIc);
% % fhIc = find(Ic>0.05);
% 
% figure(7);imshow(Ic);



%20160511下午
% img2 = imread('D:\图像作业\lesson-01_采样头个数识别\02.png');
% imgh2 = rgb2gray(img2);
% % se = [1 1 1 1;1 1 1 1;1 1 1 1];
% % imgh2 = imerode(imgh2,se);
% % figure(2);imtool(imgh2);
% se = strel('rectangle',[2,2]);
% imgh2 = imclose(imgh2,se);
% figure(1);imshow(imgh2);
% subplot(2,3,1);imshow(imgh2);title('orgin image');
% bimg1 = edge(imgh2,'roberts');
% subplot(2,3,2);imshow(bimg1);title('roberts');
% % figure(11);imshow(bimg1);
% bimg2 = edge(imgh2,'sobel');
% % figure(12);imshow(bimg2);
% subplot(2,3,3);imshow(bimg2);title('sobel');
% bimg3 = edge(imgh2,'canny');
% % figure(13);imshow(bimg3);
% subplot(2,3,4);imshow(bimg3);title('canny');
% bimg4 = edge(imgh2,'log');
% % figure(14);imshow(bimg4);
% subplot(2,3,5);imshow(bimg4);title('log');


img2 = imread('D:\图像作业\lesson-01_采样头个数识别\03.png');
% img2 = rgb2hsi(imgd2);
% h = im2double(img2);
% I1 = rgb2hsv(h);
% Ir = I1(:,:,1);
% Ig = I1(:,:,2);
% Ib = I1(:,:,3);
% subplot(2,2,1);imshow(Ir);title('h');
% subplot(2,2,2);imshow(Ig);title('s');
% subplot(2,2,3);imshow(Ib);title('v');
% hs(:,:,1) = Ir;
% hs(:,:,2) = 1;
% hs(:,:,3) = 1;
% rgb2 = hsv2rgb(hs);
% rgb2 = rgb2gray(rgb2);
% figure,imshow(Ir);title('Ir图像');
% figure(10);imshow(rgb2);title('Ir灰度图');
% se = strel('disk',1);
% rgb21 = imerode(rgb2,se);
% % figure(11);imshow(rgb21);title('Ir开操作');



sgray = rgb2gray(img2);
c=imhist(sgray);
plot(c);

for j=1:480
    for i=1:640
        sgrayh(j,i) = sgray(j,i)*0.4;
        sgray1(j,i) = sgray(j,i);
        if(sgray(j,i)>50 && sgray(j,i)<150)
            sgray2(j,i)=1;
        else
            sgray2(j,i)=0;
        end
    end
end
% figure,imshow(sgray);title('点运算增强亮度');
% figure,imshow(sgray2);title('sgray2');
% figure(20);imshow(sgray);
% sgray = sgrayh;
se = strel('disk',20);
bgray = imopen(sgray,se);
egray = imsubtract(sgray,bgray);
figure,imshow(egray);title('增强黑白图像');
figure,imshow(~egray);title('取反增强黑白图像');

% h = ones(3,3)/9;
% egray = imfilter(egray,h);
% figure,imshow(egray);title('均值滤波');


fmax1=double(max(max(egray)));%egray的最大值并输出双精度型 
fmin1=double(min(min(egray)));%egray的最小值并输出双精度型 
level=(fmax1-(fmax1-fmin1)/3)/255;%获得最佳阈值 
bw22=im2bw(egray,level);%转换图像为二进制图像 
bw2=double(bw22);  
figure;imshow(bw2);title('图像二值化');
imtool(bw2);


bimg1 = edge(egray,'roberts');
figure(40),subplot(2,3,2);imshow(bimg1);title('roberts');
% figure(11);imshow(bimg1);
bimg2 = edge(egray,'sobel');
% figure(12);imshow(bimg2);
subplot(2,3,3);imshow(bimg2);title('sobel');
bimg3 = edge(egray,'canny');
% figure(13);imshow(bimg3);
subplot(2,3,4);imshow(bimg3);title('canny');
bimg4 = edge(egray,'log');
% figure(14);imshow(bimg4);
subplot(2,3,5);imshow(bimg4);title('log');
bimg5 = edge(egray,'prewitt');
% figure(14);imshow(bimg4);
subplot(2,3,1);imshow(bimg5);title('prewitt')



