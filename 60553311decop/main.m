%===========================================
%designer：陈自远 
%date：2009-5-16
%===========================================
clc;
clear;
close;
xr=imread('名字.bmp'); %读入原始图像数据
figure(1);              %显示图像
imshow(xr);
title('原始二值单色图像');
[Mn,Nm]=size(xr);                            %得到图像长宽
RE=comp(xr,Mn);                              %调用压缩子程序
(Mn*Nm)/(length(RE)*8)                       %求压缩比
MX=decop(RE,Mn,Nm);                          %调用解压子程序
figure(2);
imshow(MX);
title('压缩后还原的二值单色图像');             %显示图像