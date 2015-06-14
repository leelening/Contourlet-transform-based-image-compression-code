clc;
clear;
x=imread('lena','bmp');
figure(1);
imshow(x);
xdct=blkproc(x,[8,8], @dct2);
figure(2);
imshow(xdct);
xdctlh=blkproc(xdct,[8,8],@lianghua);
figure(3);
imshow(xdctlh);
xdctlhmin=min(xdctlh(:));
xdctlhmax=max(xdctlh(:));
k=xdctlhmax-xdctlhmin+1;
p=zeros(1,k);
q=zeros(1,k);
[m,n]=size(xdctlh);
for i=1:m
    for j=1:n
        for l=1:k
            if xdctlh(i,j)==xdctlhmin+l-1
                p(l)=p(l)+1/(m*n);
            end
        end
    end
end      
l=0;
for i=1:k
    if p(i)~=0
        l=l+1;
        q(l)=p(i);
    end
end
symbols=zeros(1,l);
prob=zeros(1,l);
for i=1:l
    symbols(i)=i;
    prob(i)=q(i);
end
dict=huffmandict(symbols,prob);
xdctlhf=blkproc(xdctlh,[8,8],@flianghua);
y=blkproc(xdctlhf,[8,8], @idct2);
y=uint8(y);
figure(4);
imshow(y);
