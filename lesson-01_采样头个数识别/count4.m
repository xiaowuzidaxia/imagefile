clear all;
close all;
img2 = imread('D:\图像作业\lesson-01_采样头个数识别\03.png');
h = im2double(img2);
h(:,:,2) = 1;
h(:,:,3) = 1;
for j=1:480
    for i=1:640
        if(h(j,i,1)<0.85)
            hc(j,i) = 0;
        else
            hc(j,i) = 1;
        end
    end
end

hc0 = bwareaopen(hc,100);
hcl = bwlabel(hc0);
statsc = regionprops(hcl,'Area'); 
statscp = regionprops(hcl,'BoundingBox'); 
rects = cat(1,  statscp.BoundingBox);  
statscl = regionprops(hcl,'Centroid'); 
imshow(hcl);   %先显示图片
hold on;    %画出boundingbox的矩形区域  'EdgeColor','g'
for i = 1:size(rects, 1)  
    rectangle('position', rects(i, :), 'EdgeColor', 'r');  
end  

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
figure,imshow(hc7);title('元素正方形5腐蚀后，框出联通区域');   %先显示图片
hold on;    %画出boundingbox的矩形区域  'EdgeColor','g'
for i = 1:size(rects7, 1)  
    rectangle('position', rects7(i, :), 'EdgeColor', 'r');  
end  

% 求区域间的最小联通距离,并将联通区域连接起来
bw2 = ismember(hc7, find([statsc7.Area] < 2500));
% 填充空洞
bw2 = imfill(bw2,'holes');
figure,imshow(bw2);title('删除面积大于2500');
statbw2 = regionprops(bw2,'Area','Centroid'); 
b = bwperim(bw2);
[L,num]=bwlabel(b);
countnum = num;
z=1;
imshow(b)
hold on
for i1 = 1:num-1
    [x,y]=find(L==i1);
%     statbw2(8).Area
    c =0;
    stari1 = (statbw2(i1).Area>2000);
    for j1= (i1+1):num
        [x1,y1]=find(L==j1);
%         statbw2(9).Area
        for i=1:size(x,1)
            for j=1:size(x1,1)
                c(i,j)=sqrt((x(i)-x1(j))^2+(y(i)-y1(j))^2);
            end
        end
        d=min(min(c));    
        starj1 = (statbw2(j1).Area>2000);
        if d<11&&(~(stari1&&starj1))
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
stat21 = regionprops(hc2l,'Area','Centroid'); 
Icent1 = cat(1,stat21.Centroid);
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

hca25 = bwareaopen(hc7,2500);
hca5 = bwareaopen(hc7,5000);
figure,imshow(hca5);title('面积大于5000');
hcasub = imsubtract(hca25,hca5);
hcasub = bwlabel(hcasub);
stathca51s = regionprops(hcasub,'Area','Centroid');
Icent2 = cat(1,stathca51s.Centroid);
figure,imshow(hcasub);title('面积大于2500小于5000');

hca5 = imerode(hca5,strel('square',15));
figure,imshow(hca5);title('被腐蚀');
% hca51 = imdilate(hca5,strel('disk',4));
% figure,imshow(hca51);title('结构元素圆10膨胀');
% hca52 = imopen(hca5,strel('disk',10));
% figure,imshow(hca52);title('开操作');
stathca5 = regionprops(hca5,'Area','Centroid'); 
if length(stathca5)
    [Lca5,numca5]=bwlabel(hca5);
    for u=1:numca5
    %     hca5n{i} = ismember(hca5,find(Lca5==i));
    %     hca5n{i} = find(Lca5==i);
    %     for j=1:480
    %          for i=1:640
    %                 h(j,i)= find(Lca5==i);
    %          end
    %     end
        [x,y]=find(Lca5==u);
        for j=1:480
             for i=1:640
                 hca5s(j,i) = 0;
             end
        end
        for k=1:length(x);
             for j=1:480
                 for i=1:640
                     hca5s(x(k),y(k)) = 1;
                 end
             end
        end
        II{u} = hca5s;

    end


    for i=1:numca5
    % %     hcanum = imdilate(hca5n{i},strel('square',15));
    % %     imtool(hcanum);
       II{i} = imdilate(II{i},strel('square',15));
       figure(i),imshow(II{i});
       Ic{i} = regionprops(II{i},'Centroid');
       Icent3(i,:) = cat(1,  Ic{i}.Centroid); 
       Icent=[Icent1;Icent2;Icent3];
    end
else
    Icent=[Icent1;Icent2];
end

figure,imshow(hc);title(strcat('连接识别出的物体,物体数量',int2str(zzzzz)));   %先显示图片
hold on;    %画出boundingbox的矩形区域  'EdgeColor','g'
plot(Icent(:,1),Icent(:,2),'r*-');


