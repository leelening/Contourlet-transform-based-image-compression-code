
function [c,s]=swavdec3(x,varargin);
%三层小波分解
%
%%%%小波滤波器%%%%
if ischar(varargin{1})
    [ld,hd] = wfilters(varargin{1},'d'); 
else
    ld= varargin{1}; hd= varargin{2}; 
end

ss = [size(x)];
s=ss(1,1);
temca=x;
c=zeros(s);
[ca1,ch1,cv1,cd1,totalx1]=swavdec(temca,ld,hd);
[ca2,ch2,cv2,cd2,totalx2]=swavdec(ca1,ld,hd);
[ca3,ch3,cv3,cd3,totalx3]=swavdec(ca2,ld,hd);
totalx2(1:s/4,1:s/4)=totalx3;
totalx1(1:s/2,1:s/2)=totalx2;
c=totalx1;
s=[s(1,1)/4,s(1,1)/2,s(1,1)];
