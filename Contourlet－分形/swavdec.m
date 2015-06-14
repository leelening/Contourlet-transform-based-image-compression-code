
function [a,h,v,d,totalx]=swavdec(x,varargin);
%单层小波分解
%
%%%%小波滤波器%%%%
if ischar(varargin{1})
    [ld,hd] = wfilters(varargin{1},'d'); 
else
    ld= varargin{1}; hd= varargin{2}; 
end
%lp
ca= wconv2('row',x,ld)%%低通和原信号行卷积
ca=dyaddown(ca,0,'c');%%偶数列 抽样

ca1= wconv2('col',ca,ld)%%低通和ca列卷积
ca1=dyaddown(ca1,0,'r');%%偶数行抽样 

ch1=wconv2('col',ca,hd);%%高通和ca卷积
ch1=dyaddown(ch1,0,'r');%%偶数行抽样
%hp
cd= wconv2('row',x,hd)%%高通和原信号行卷积
cd=dyaddown(cd,0,'c');%%偶数列 抽样

cv1= wconv2('col',cd,ld)%%低通和ca列卷积
cv1=dyaddown(cv1,0,'r');%%偶数行抽样 

cd1=wconv2('col',cd,hd);%%高通和cd卷积
cd1=dyaddown(cd1,0,'r');%%抽样

%返回小波分解系数
a=ca1;
h=ch1;
v=cv1;
d=cd1;
totalx=[a h;v d];