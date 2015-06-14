%[123;76;190;65;156;123;76;110]
clc
clear
%CBC模式
%产生密钥组
disp('欢迎使用CBC模式进行解密运算')
k1=input('请输入解密密钥:');
k=zeros(8,8);
for i=1:8
    k(i,:)=D2B(k1(i));
end
K=make_key(k);%密钥组
%读入文件并对其进行分组
a=fopen('2.txt','r');
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
for i=1:l1%把ASSIC码转化为二进制码
   e1=D2B(b(i));
   e(i,:)=e1;
end

decode=zeros(l1,8);
IV=[1 0 0 1 1 0 0 1;
    0 1 0 0 0 1 1 0;
    1 0 0 1 1 0 0 1;
    0 1 0 0 0 1 1 0;
    0 1 0 0 0 1 1 0;
    1 0 0 1 1 0 0 1;
    1 0 1 0 1 0 1 0;
    1 0 1 0 1 0 1 1];
for i=1:l1/8%DES解密
    temp=[e(8*(i-1)+1,:);e(8*(i-1)+2,:);
          e(8*(i-1)+3,:);e(8*(i-1)+4,:);
          e(8*(i-1)+5,:);e(8*(i-1)+6,:);
          e(8*(i-1)+7,:);e(8*(i-1)+8,:)];
       decryp2=decryp(temp,K);
       decryp1=mod(decryp2+IV,2);
       decode(8*(i-1)+1,:)=decryp1(1,:); decode(8*(i-1)+2,:)=decryp1(2,:);
       decode(8*(i-1)+3,:)=decryp1(3,:); decode(8*(i-1)+4,:)=decryp1(4,:);
       decode(8*(i-1)+5,:)=decryp1(5,:); decode(8*(i-1)+6,:)=decryp1(6,:);
       decode(8*(i-1)+7,:)=decryp1(7,:); decode(8*(i-1)+8,:)=decryp1(8,:);
       IV=temp;
       
end
g1=zeros(l1,1);
for i=1:l1
    f1=decode(i,:);
    g1(i)=B2D(f1);
end
h1=fopen('3.txt','wb');
fwrite(h1,g1,'uint8');
fclose(h1);