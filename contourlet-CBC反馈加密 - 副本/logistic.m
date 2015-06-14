%%加密程序
A=imread('D:\lena.BMP');
%A=rgb2gray(A);
figure
imshow(A);
[m,n]=size(A);
x=zeros(1,m*n);
x(1)=0.2;
u=3.6;
for i=1:m*n-1
    x(i+1)=u*x(i)*(1-x(i));
end

for i=1:m*n
    if round(100*x(i))<100*x(i)
        x(i)=mod(round(1000*(100*x(i)-round(100*x(i)))),256);
    else 
        x(i)=mod(round(1000*(1-(100*x(i)-round(100*x(i))))),256);
    end
end

x=uint8(x);
c=zeros(1,m*n);
B=reshape(A,1,m*n);
B=uint8(B);
for i=1:m*n
    c(i)=bitxor(x(i),B(i));
end
B=reshape(c,m,n);
figure
imshow(mat2gray(B));
%%%下面为解密程序，其实跟上面是一样的 得出相同的混沌序列
%%用这个序列与加密图进行异或运算
%%就会得到原图
xx=zeros(1,m*n);
xx(1)=0.2;
u=3.6;
for i=1:m*n-1
    xx(i+1)=u*xx(i)*(1-xx(i));
end
for i=1:m*n
    if round(100*xx(i))<100*xx(i)
        xx(i)=mod(round(1000*(100*xx(i)-round(100*xx(i)))),256);
    else 
        xx(i)=mod(round(1000*(1-(100*xx(i)-round(100*xx(i))))),256);
    end
end
xx=uint8(xx);
B=reshape(B,1,m*n);
B=uint8(B);
for i=1:m*n
    C(i)=bitxor(x(i),B(i));
end
C1=reshape(C,m,n);
C1=double(C1);
figure
imshow(mat2gray(C1));