%===========================================
%designer������Զ 
%date��2009-5-16
%===========================================
clc;
clear;
close;
xr=imread('����.bmp'); %����ԭʼͼ������
figure(1);              %��ʾͼ��
imshow(xr);
title('ԭʼ��ֵ��ɫͼ��');
[Mn,Nm]=size(xr);                            %�õ�ͼ�񳤿�
RE=comp(xr,Mn);                              %����ѹ���ӳ���
(Mn*Nm)/(length(RE)*8)                       %��ѹ����
MX=decop(RE,Mn,Nm);                          %���ý�ѹ�ӳ���
figure(2);
imshow(MX);
title('ѹ����ԭ�Ķ�ֵ��ɫͼ��');             %��ʾͼ��