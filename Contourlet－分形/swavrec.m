function recx = swavrec(decx,varargin)
%单层小波重构
if ischar(varargin{1})
    [lr,hr] = wfilters(varargin{1},'r');
else
    lr = varargin{1}; hr = varargin{2}; 
end
ss=size(decx);
s=ss(1,1);
ca=decx(1:s/2,1:s/2);
ch=decx(1:s/2,s/2+1:s);
cv=decx(s/2+1:s,1:s/2);
cd=decx(s/2+1:s,s/2+1:s);

ica=supsconv2(ca,lr,lr) % Approximation.
ich=supsconv2(ch,hr,lr) % Horizontal Detail.
icv=supsconv2(cv,lr,hr)% Vertical Detail.
icd=supsconv2(cd,hr,hr);     % Diagonal Detail.
recx=ica+ ...
  ich+ ...
  icv+ ...
  icd;

