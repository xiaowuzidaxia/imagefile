clear all;
rgb = imread('car2.jpg');
gray = rgb2gray(rgb);
se = strel('line',5,100);
op = imopen(gray,se);

cd = imclose(op,se);
figure,imshow(cd);
level = graythresh(cd);
bw = ~(im2bw(cd,level));
figure,imshow(bw);
bw = imclearborder(bw,4);
figure,imshow(bw);
bw = bwareaopen(bw,7000); 
figure,imshow(bw);
bw = bwlabel(bw);
stats = regionprops(bw,'BoundingBox');
imshow(rgb);
ct = length(stats);
for i = 1:ct
    rectangle('Position',stats(i).BoundingBox,'EdgeColor','r')
end
title(['Car: ',num2str(ct)]);