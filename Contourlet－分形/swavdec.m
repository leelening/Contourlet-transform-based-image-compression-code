
function [a,h,v,d,totalx]=swavdec(x,varargin);
%����С���ֽ�
%
%%%%С���˲���%%%%
if ischar(varargin{1})
    [ld,hd] = wfilters(varargin{1},'d'); 
else
    ld= varargin{1}; hd= varargin{2}; 
end
%lp
ca= wconv2('row',x,ld)%%��ͨ��ԭ�ź��о��
ca=dyaddown(ca,0,'c');%%ż���� ����

ca1= wconv2('col',ca,ld)%%��ͨ��ca�о��
ca1=dyaddown(ca1,0,'r');%%ż���г��� 

ch1=wconv2('col',ca,hd);%%��ͨ��ca���
ch1=dyaddown(ch1,0,'r');%%ż���г���
%hp
cd= wconv2('row',x,hd)%%��ͨ��ԭ�ź��о��
cd=dyaddown(cd,0,'c');%%ż���� ����

cv1= wconv2('col',cd,ld)%%��ͨ��ca�о��
cv1=dyaddown(cv1,0,'r');%%ż���г��� 

cd1=wconv2('col',cd,hd);%%��ͨ��cd���
cd1=dyaddown(cd1,0,'r');%%����

%����С���ֽ�ϵ��
a=ca1;
h=ch1;
v=cv1;
d=cd1;
totalx=[a h;v d];