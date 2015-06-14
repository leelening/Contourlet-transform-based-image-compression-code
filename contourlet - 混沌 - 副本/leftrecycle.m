%循环左移函数可以对行循环左移，可以对列循环上移
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