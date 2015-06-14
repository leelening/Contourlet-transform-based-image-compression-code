function [a]=H2B(b)
a=zeros(1,4);
a(1)=floor(b/8);
a(2)=floor((b-a(1)*8)/4);
a(3)=floor((b-a(1)*8-a(2)*4)/2);
a(4)=b-a(1)*8-a(2)*4-a(3)*2;
end
