%矩阵变换函数可以通过初始矩阵产生一个新的矩阵
function [c]=matrixchange(a,k)
[row column]=size(k);
c=k;
b=a';
for i=1:row*column
    c(i)=b(k(i));
end
