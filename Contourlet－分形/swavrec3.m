function recx = swavrec3(decx,varargin)
%三层小波重构
if ischar(varargin{1})
    [lr,hr] = wfilters(varargin{1},'r');
else
    lr = varargin{1}; hr = varargin{2}; 
end
ss=size(decx);
s=ss(1,1)
decx3=decx(1:s/4,1:s/4);
ca2=swavrec(decx3,'db1');
decx2=decx(1:s/2,1:s/2);
decx2(1:s/4,1:s/4)=ca2;
ca1=swavrec(decx2,'db1');
decx1=decx;
decx1(1:s/2,1:s/2)=ca1;
recx=swavrec(decx1,'db1');
