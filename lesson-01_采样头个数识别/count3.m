clear all;
close all;
img2 = imread('D:\图像作业\lesson-01_采样头个数识别\01.png');
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
h(:,:,2) = 1;
h(:,:,3) = 1;
gs(:,:,1) = 1;
gs(:,:,3) = 1;
bv(:,:,1) = 1;
bv(:,:,2) = 1;
% figure,imshow(h);title('h(1)维图');
% imtool(h);
% imtool(gs);
% imtool(bv);
% imtool(Ir);
% imtool(Ig);
% imtool(Ib);
% for j=1:480
%     for i=1:640
%         if(Ir(j,i)<0.9)
%             Ic(j,i) = 0;
%         else
%             Ic(j,i) = 1;
%         end
%     end
% end
% figure,imshow(Ic);title('Ic');
% imtool(Ic);
% Igr = find(Ir ==0);

for j=1:480
    for i=1:640
        if(h(j,i,1)<0.85)
            hc(j,i) = 0;
        else
            hc(j,i) = 1;
        end
    end
end
for j=1:480
    for i=1:640
        if(gs(j,i,2)<0.85)
            gsc(j,i) = 0;
        else
            gsc(j,i) = 1;
        end
    end
end
for j=1:480
    for i=1:640
        if(bv(j,i,3)<0.85)
            bvc(j,i) = 0;
        else
            bvc(j,i) = 1;
        end
    end
end
% imtool(hc);

% 图2中亮度太强 填充会模糊掉边界
% hch = imfill(hc,'hole');
% figure,imshow(hch);


% 要先腐蚀在膨胀
% hc = imdilate(hc,strel('disk',5));
% figure,imshow(hc);

% 骨架化
% hhh = bwmorph(hc,'skel',Inf);
% figure,imshow(hhh);title('骨架化');
% hhhs = bwmorph(hhh,'thin');
% figure,imshow(hhhs);title('骨架化s');

% 腐蚀后无输出图像
% hhm = imerode(hhh,strel('disk',1));
% figure,imshow(hhm);title('骨架腐蚀后');

% hhimd = imdilate(hhh,strel('disk',10));
% figure,imshow(hhimd);

% 灰度二进制图像边缘检测
hdb = bwperim(hc);
figure,imshow(hdb);title('灰度二进制边缘检测');

hc0 = bwareaopen(hc,100);
hcl = bwlabel(hc0);
statsc = regionprops(hcl,'Area'); 

statscp = regionprops(hcl,'BoundingBox'); 
rects = cat(1,  statscp.BoundingBox);  

statscl = regionprops(hcl,'Centroid'); 
% figure,imshow(hcl);

imshow(hcl);   %先显示图片
hold on;    %画出boundingbox的矩形区域  'EdgeColor','g'
for i = 1:size(rects, 1)  
    rectangle('position', rects(i, :), 'EdgeColor', 'r');  
end  
% for i=1:length(statscp)
%     rectangle('Position',statscp.BoundingBox(i),'EdgeColor','g'); 
% end
% 高帽滤波
% imth = imtophat(hc,strel('disk',15));
% figure,imshow(imth);title('高帽滤波');
% imth = bwhitmiss(hc,strel('disk',15));
% figure,imshow(imth);title('高帽滤波1');

hc = imerode(hcl,strel('square',5));
figure,imshow(hc);title('fushi');
hc0 = bwareaopen(hc,100);
hc7 = bwlabel(hc0);
statsc7 = regionprops(hc7,'Area'); 

statscp7 = regionprops(hc7,'BoundingBox'); 
rects7 = cat(1,  statscp7.BoundingBox);  

statscl7 = regionprops(hc7,'Centroid'); 
statsch7 = regionprops(hc7,'ConvexHull'); 
rech7= cat(1,  statsch7.ConvexHull); 
% figure,imshow(hc);
imshow(hc7);   %先显示图片
hold on;    %画出boundingbox的矩形区域  'EdgeColor','g'
for i = 1:size(rects7, 1)  
    rectangle('position', rects7(i, :), 'EdgeColor', 'r');  
end  
imtool(hc7);
% 最小凸变形不行
% for i = 1:size(rech7, 1)  
%     rectangle('position', rech7(i, :), 'EdgeColor', 'r');  
% end  
imtool(hc7);

% 求区域间的最小联通距离,并将联通区域连接起来
bw2 = ismember(hc7, find([statsc7.Area] < 2500));
% 填充空洞
bw2 = imfill(bw2,'holes');
figure,imshow(bw2);title('删除面积大于2500');
% bw2 = ismember(bw21, find([statsc7.Area] >280));
% figure,imshow(bw2);title('删除面积大于280');
% bwboundaries(BW,conn)
b = bwperim(bw2);
[L,num]=bwlabel(b);
countnum = num;
z=1;
imshow(b)
hold on
for i1 = 1:num-1
    [x,y]=find(L==i1);
    c =0;
    for j1= (i1+1):num
        [x1,y1]=find(L==j1);
        for i=1:size(x,1)
            for j=1:size(x1,1)
                c(i,j)=sqrt((x(i)-x1(j))^2+(y(i)-y1(j))^2);
            end
        end
        d=min(min(c));    
        if d<11
            counth(z)=d;
            z = z+1;
            countnum = countnum-1;
            hold on;
            [x2,y2]=find(c==d);
%           当d的值出现两个解的时候选取第一个解为最终计算解
            if length(x2)>=2
                x2 = x2(1);
                y2 = y2(1);
            end
                
            bw2 = DrawLineImage(bw2,y(x2),x(x2),y1(y2),x1(y2));
            plot([y(x2),y1(y2)],[x(x2),x1(y2)],'r*-')
            text(y(x2),x(x2),num2str(d),'FontSize',18,'Color','b')
        end
    end
end
figure,imshow(bw2);title('直线联通区域');
hc20 = bwareaopen(bw2,500);
hc2l = bwlabel(hc20);
stat21 = regionprops(hc2l,'Area'); 
countfnum = length(stat21);
for i=1:length(stat21)
    if stat21(i).Area>5000
        countfnum = countfnum + 1;
    end
end
opencount = 0;
for i=1:length(statsc7)
    if statsc7(i).Area>2500&&statsc7(i).Area<5000
        opencount = opencount + 1;
    else if statsc7(i).Area>5000
            opencount = opencount + 2;
        end
    end
end
zzzzz = opencount + countfnum


n=1;k=1;
recta7 = cat(1,  statsc7.Area);  
for i=1:length(statsc7)
    if statsc7(i).Area<1500
        
        cent(k) = recta7(i);
        k=k+1;
        for j=(i+1):length(statsc7)
            cm = norm(statscl7(i).Centroid-statscl7(j).Centroid);
            if cm<50
                chp(n) =j; 
                p(n) = cm;
                n = n+1;
            end
        end
    end
end
% n=1
% for i=1:length(statscl7)
%     for j=i:length(statscl7)
%         p(n)=norm(statscl7(i).Centroid-statscl7(j).Centroid);
%         n = n+1;
%     end
% end



hc = imerode(hc,strel('square',5));
figure,imshow(hc);
% hch = imfill(hc,'hole');
% figure,imshow(hch);



% 
% hch = imerode(hch,strel('line',5,0));
% figure,imshow(hch);

% hc1 = imdilate(hc,strel('disk',5));
% figure,imshow(hc1);
% imtool(gsc);
% imtool(bvc);


% for j=1:480
%     for i=1:640
%         if(Ir(j,i)<0.2 )
%             if(hc(j,i)
%             hc(j,i) = 1;
%         end
%     end
% end

for j=1:480
    for i=1:640
        if(Ir(j,i)<0.2)
            Irc(j,i) = 1;
        else
            Irc(j,i) = 0;
        end
    end
end


% Ir8 = uint8(round(Ir*255));
% imtool(Ir8);
% Irc1 = bwareaopen(Irc,3500);
% imtool(Irc1);




% se = strel('disk',50);
% imrc = imerode(Irc,se);



% imrc = bwlabel(Irc);
% statsc = regionprops(imrc,'Area');    %求各连通域的大小
% areac = cat(1,statsc.Area);
% index = find(areac == max(areac));        %求最大连通域的索引
% img = ismember(imrc,find(areac>0)); 
% figure,imshow(img),title('Irc联通区域');

% imLabel = bwlabel(hc); 
% stats = regionprops(imLabel,'Area');    %求各连通域的大小
% area = cat(1,stats.Area);
% index = find(area == max(area));        %求最大连通域的索引
% img = ismember(imLabel,find(area>1200)); 
% figure,imshow(img),title('联通区域');


% se = strel('disk',20);
% bgray = imopen(sgray,se);
% egray = imsubtract(sgray,bgray);
% figure,imshow(egray);title('增强黑白图像');
% 
% sgray = rgb2gray(img2);
% sgray1 = im2double(sgray);
% imtool(sgray1);
% sgray11 = uint8(round(sgray1*255));
% hc11 = uint8(round(hc*255));
% egray = imsubtract(sgray11,hc11);
% imtool(egray);



% se = strel('disk',24);
% bgray = imopen(sgray,se);
% egray = imsubtract(sgray,bgray);
% figure,imshow(egray);title('增强黑白图像');
% imtool(egray);
% 
% adim = imadd(egray,egray);
% imtool(adim);

% fmax1=double(max(max(egray)));%egray的最大值并输出双精度型 
% fmin1=double(min(min(egray)));%egray的最小值并输出双精度型 
% level=(fmax1-(fmax1-fmin1)/3)/255;%获得最佳阈值 
% bw22=im2bw(egray,level);%转换图像为二进制图像 
% bw2=double(bw22);  
% figure;imshow(bw2);title('图像二值化');
% imtool(bw2);


% img1 = imread('D:\图像作业\lesson-01_采样头个数识别\01.png');
% % img2 = rgb2hsi(imgd2);
% h = im2double(img2);
% I1 = rgb2hsv(h);



