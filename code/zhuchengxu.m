%--------------------------------------------%
%----------------图像进行游程编码———————%
clc;
clear;
Image=imread('lena.bmp');     %读入原始图像
% fid=fopen('D:\text\b.bin','r');
% Image=fread(fid,[300,2000],'float');
binImage=im2bw(Image);        %原始图像转换成二值图像
[Mn,Nm]=size(binImage);       %得到原始图像的长和宽
cc=compress(binImage);        %调用压缩文件
pp=release(cc);               %调用解压文件
[m,n]=size(cc);               %得到压缩图像的大小
rate=Mn*Nm/n                  %求解压缩率
subplot(2,1,1);               %显示二值图像
imshow(binImage); 
title('二值图像')
subplot(2,1,2);               %显示解压图像
imshow(pp);
title('解压图像')
