function [seq]=mseq(connections,registers,len);
%***************************************************
% �˺�������������󳤶�������λ�Ĵ�������
% connectionsΪ��������ʽ������registersΪ��ʼֵ����
% lenΪ�������г��ȣ���Ϊ0�����һ������
%***************************************************
m=length(connections);
L=2^m-1;     %���ڳ���
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
    for t=m:-1:2  %�Ĵ�����λ
        registers(t)=registers(t-1);
    end
    registers(1)=fan;
    fan=0;
end
