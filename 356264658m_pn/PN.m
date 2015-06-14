clear;
K=3;
a=[1 0 0 0];
m=length(a);
for k=1:K
    for i=1:2.^m-1
        s((k-1)*(2.^m-1)+i)=a(4);
        temp=xor(a(1),a(4));
        a(4)=a(3);
        a(3)=a(2);
        a(2)=a(1);
        a(1)=temp;
    end
end
n=length(s);
for i=1:n
    for j=1:64
        ss((i-1)*64+j)=s(i);
    end
end
T=length(ss);
t=[0:1:T-1];
figure
plot(t,ss)
axis([0 T-1 -0.2 1.2])





s1=s;
s1=s1*2-1;
L=length(s1);
for delta=1:n
s2=[zeros(1,delta) s1(1:L-delta)];
s2(1:delta)=s1(L-delta+1:L);
corr1(delta)=sum(s1.*s2);
end
figure
plot(corr1)
