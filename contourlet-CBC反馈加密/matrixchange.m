%����任��������ͨ����ʼ�������һ���µľ���
function [c]=matrixchange(a,k)
[row column]=size(k);
c=k;
b=a';
for i=1:row*column
    c(i)=b(k(i));
end
