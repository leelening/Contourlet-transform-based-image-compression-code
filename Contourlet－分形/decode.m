function XX=decode(m,X)
%�������


H1=X{1,2}{1,2};
H2=X{1,3}{1,2};

V1=X{1,2}{1,3};
V2=X{1,3}{1,3};

D1=X{1,2}{1,4};
D2=X{1,3}{1,4};

n=m{1,1};
CH1=rebuild(n,H1);
X{1,2}{1,2}=CH1;
n=m{1,2};
CH2=rebuild(n,H2);
X{1,3}{1,2}=CH2;

n=m{1,3};
CV1=rebuild(n,V1);
X{1,2}{1,3}=CV1;
n=m{1,4};
CV2=rebuild(n,V2);
X{1,3}{1,3}=CV2;

n=m{1,5};
CD1=rebuild(n,D1);
X{1,2}{1,4}=CD1;
n=m{1,6};
CD2=rebuild(n,D2);
X{1,3}{1,4}=CD2;


XX=X;
