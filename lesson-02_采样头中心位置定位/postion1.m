clear all;
close all;
img2 = imread('D:\图像作业\lesson-02_采样头中心位置定位\02.png');
figure,imshow(img2);
% img2 = rgb2hsi(imgd2);
h = im2double(img2);
gs = h;
bv = h;
I1 = rgb2hsv(h);
Ir = I1(:,:,1);
Ig = I1(:,:,2);
Ib = I1(:,:,3);
% subplot(2,2,1);imshow(Ir);title('h');
% subplot(2,2,2);imshow(Ig);title('s');
% subplot(2,2,3);imshow(Ib);title('v');
% figure,imshow(Ir);title('Ir');
h(:,:,2)=1;
h(:,:,3)=1;
figure,imshow(h);
imtool(h);
for j=1:480
	for i=1:640
		if(h(j,i,1)<0.85)
			hc(j,i)=0;
		else
			hc(j,i)=1;
		end
	end
end
imtool(hc);







