function t= encode3(X)
%±àÂë³ÌÐò
CH1=X{1,2}{1,2};
CH2=X{1,3}{1,2};

CV1=X{1,2}{1,3};
CV2=X{1,3}{1,3};

CD1=X{1,2}{1,4};
CD2=X{1,3}{1,4};

A=mapping3(CH1);
B=mapping3(CH2);

D=mapping3(CV1);
E=mapping3(CV2);

G=mapping3(CD1);
H=mapping3(CD2);

t={A,B,D,E,G,H};