%--------------------------------------------%
%----------------ͼ������γ̱��롪������������%
clc;
clear;
Image=imread('lena.bmp');     %����ԭʼͼ��
% fid=fopen('D:\text\b.bin','r');
% Image=fread(fid,[300,2000],'float');
binImage=im2bw(Image);        %ԭʼͼ��ת���ɶ�ֵͼ��
[Mn,Nm]=size(binImage);       %�õ�ԭʼͼ��ĳ��Ϳ�
cc=compress(binImage);        %����ѹ���ļ�
pp=release(cc);               %���ý�ѹ�ļ�
[m,n]=size(cc);               %�õ�ѹ��ͼ��Ĵ�С
rate=Mn*Nm/n                  %���ѹ����
subplot(2,1,1);               %��ʾ��ֵͼ��
imshow(binImage); 
title('��ֵͼ��')
subplot(2,1,2);               %��ʾ��ѹͼ��
imshow(pp);
title('��ѹͼ��')
