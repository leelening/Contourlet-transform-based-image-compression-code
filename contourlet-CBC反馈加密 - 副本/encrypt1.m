clear;
%clc;
x=imread('压缩后的lena.bmp','bmp');
[a b c]=size(x);
N=a*b;
m(1)=input('请输入密钥:   ');
disp('加密中...');
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
imwrite(e,'加密后的lena.bmp','bmp');
figure,imshow(e);
title('加密后的图像');
%hold on;
%winopen('加密后的lena.bmp');
disp('加密成功');
