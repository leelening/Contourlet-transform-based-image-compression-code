clear;
%clc;
x=imread('ѹ�����lena.bmp','bmp');
[a b c]=size(x);
N=a*b;
m(1)=input('��������Կ:   ');
disp('������...');
for i=1:N-1
    m(i+1)=4*m(i)-4*m(i)^2;
end
m=mod(1000*m,256);
m=uint8(m);
n=1;
for i=1:a
    for j=1:b
        e(i,j)=bitxor(m(n),x(i,j));
        n=n+1;
    end
end
imwrite(e,'���ܺ��lena.bmp','bmp');
figure,imshow(e);
title('���ܺ��ͼ��');
%hold on;
%winopen('���ܺ��lena.bmp');
disp('���ܳɹ�');
