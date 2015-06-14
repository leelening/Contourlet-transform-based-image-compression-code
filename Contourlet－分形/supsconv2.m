function y = supsconv2(x,lr,hr)
%²åÖµ¾í»ý³ÌÐò
sx = 2*size(x);
lf = length(lr);
s = sx-lf+2;
y=x;
y = wconv2('col',dyadup(y,'row',0),lr);
y = wconv2('row',dyadup(y,'col',0),hr);
y = wkeep2(y,s,'c',[0 0]);