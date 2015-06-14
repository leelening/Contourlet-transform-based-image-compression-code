function [seq]=mseq(connections,registers,len);
%***************************************************
% 此函数用来生成最大长度线性移位寄存器序列
% connections为特征多项式向量，registers为初始值向量
% len为所需序列长度，若为0则输出一个周期
%***************************************************
m=length(connections);
L=2^m-1;     %周期长度
if len==0
    len=L;
end
fan=0;
for i=1:len
    seq(i)=registers(m);
    for j=1:m
        fan=fan +connections(j)*registers(j);
        fan=(mod(fan,2));
    end
    for t=m:-1:2  %寄存器移位
        registers(t)=registers(t-1);
    end
    registers(1)=fan;
    fan=0;
end
