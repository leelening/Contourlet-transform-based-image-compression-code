function acCodeOut=AcCode(zScanOut)
%����ϵ������
%���һ����Ľ�������
%����z��ɨ�������������
N=8;
num=N*N+1;i=N*N;
b=cell(1,N*N);
%b{j}O�����������֣�b{j}(1)��ʾ���������b{j}{2}��ʾ����

%�γ̱��뿪ʼ
while(i>1)%ȷ��EOBǰϵ���ĳ���
    if(zScanOut(i)==0)num=num-1;i=i-1;
    else break;
    end
end

i=2;
j=1;
while(i<num)
    zeroNum=0;
    while(zScanOut(i)==0)%ȷ���������
        zeroNum=zeroNum+1;
        i=i+1;
        if(zeroNum==16)
            b{j}=[15 0];
            j=j+1;
            zeroNum=0;
        end
    end
    b{j}=[zeroNum zScanOut(i)];%b{j}(1)��ʾ���������b{j}{2}��ʾ����
    j=j+1;
    i=i+1;
end
b{j}=[0 0];%EOB�����

%�γ̱������

binacRange=cell(1,1);%����ֵ�����Ʊ���
forHuf=cell(1,1);%Hufman��������������ÿ��Ԫ�ذ����������֣��γ̳��Ⱥ�binacRange����
hufCodeOut=cell(1,1);
out=cell(1,1);
for i=1:j
    binacRange{i}=dec2bin(abs(b{i}(2)));
    binacRange{i}=binacRange{i}-48;
    if(b{i}(2)<0)
        binacRange{i}=~binacRange{i};
    end
    
    acBits(i)=length(binacRange{i});%binacRange����
    if(b{i}(2)==0) acBits(i)=0;
    end
    forHuf{i}=[b{i}(1) acBits(i)];%forHufΪ"�г�/�ߴ�"
end


for i=1:j
    hufCodeOut{i}=YAcHufCode(forHuf{i});%"�г�/�ߴ�Ļ�������
    out{i}=[hufCodeOut{i} binacRange{i}];%����������֣����г�/�ߴ�Ļ�������ͷ���ֵ����
    if(b{i}(2)==0)out{i}=hufCodeOut{i}; %����Ϊ0��������볤��Ϊ0
    end
end


acCodeOut=out{1};
for i=2:j
    acCodeOut=[acCodeOut out{i}];
end
    

