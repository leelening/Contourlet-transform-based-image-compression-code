%[123;76;190;65;156;123;76;110]
clc
clear
%CBCģʽ
%������Կ��
disp('��ӭʹ��CBCģʽ���м�������')
k1=input('�����������Կ:');
k=zeros(8,8);
for i=1:8
    k(i,:)=D2B(k1(i));
end
K=make_key(k);%��Կ��
%�����ļ���������з���
a=fopen('rlc.txt','r');
b=fread(a,'uint8');
l=length(b);
c=floor(l/8);
d=mod(l,8);
if d==0;
    d1=0;
else
    d1=1;
end
l1=8*(c+d1);
e=zeros(l1,8);
e1=zeros(1,8);
for i=1:l%��ASSIC��ת��Ϊ��������
   e1=D2B(b(i));
   e(i,:)=e1;
end
for i=l+1:l1%��ʣ�ಿ���ÿո����
    f=D2B(32);
    for j=1:8    
    e(i,j)=f(j);
    end
end
cryp=zeros(l1,8);
IV=[1 0 0 1 1 0 0 1;
    0 1 0 0 0 1 1 0;
    1 0 0 1 1 0 0 1;
    0 1 0 0 0 1 1 0;
    0 1 0 0 0 1 1 0;
    1 0 0 1 1 0 0 1;
    1 0 1 0 1 0 1 0;
    1 0 1 0 1 0 1 1];
for i=1:l1/8%DES����
    temp=[e(8*(i-1)+1,:);e(8*(i-1)+2,:);e(8*(i-1)+3,:);e(8*(i-1)+4,:);
          e(8*(i-1)+5,:);e(8*(i-1)+6,:);e(8*(i-1)+7,:);e(8*(i-1)+8,:)];
    temp1=mod(temp+IV,2);
       cryp1=encryp(temp1,K);
       cryp(8*(i-1)+1,:)=cryp1(1,:); cryp(8*(i-1)+2,:)=cryp1(2,:);
       cryp(8*(i-1)+3,:)=cryp1(3,:); cryp(8*(i-1)+4,:)=cryp1(4,:);
       cryp(8*(i-1)+5,:)=cryp1(5,:); cryp(8*(i-1)+6,:)=cryp1(6,:);
       cryp(8*(i-1)+7,:)=cryp1(7,:); cryp(8*(i-1)+8,:)=cryp1(8,:);
       IV=cryp1;
end
g=zeros(l1,1);
for i=1:l1
    f=cryp(i,:);
    g(i)=B2D(f);
end
h=fopen('secrettext.txt','wb');
fwrite(h,g,'uint8');
fclose(h);