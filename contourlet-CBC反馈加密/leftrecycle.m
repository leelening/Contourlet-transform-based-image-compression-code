%ѭ�����ƺ������Զ���ѭ�����ƣ����Զ���ѭ������
function [a]=leftrecycle(c,d)
l=length(d);
for j=1:c
temp=d(1);
for i=1:l-1
    d(i)=d(i+1);
end
d(l)=temp;
end
a=d;
end