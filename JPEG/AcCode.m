function acCodeOut=AcCode(zScanOut)
%交流系数编码
%完成一个块的交流编码
%输入z形扫描结果，输出码流
N=8;
num=N*N+1;i=N*N;
b=cell(1,N*N);
%b{j}O包括两个部分，b{j}(1)表示连零个数，b{j}{2}表示幅度

%游程编码开始
while(i>1)%确定EOB前系数的长度
    if(zScanOut(i)==0)num=num-1;i=i-1;
    else break;
    end
end

i=2;
j=1;
while(i<num)
    zeroNum=0;
    while(zScanOut(i)==0)%确定连零个数
        zeroNum=zeroNum+1;
        i=i+1;
        if(zeroNum==16)
            b{j}=[15 0];
            j=j+1;
            zeroNum=0;
        end
    end
    b{j}=[zeroNum zScanOut(i)];%b{j}(1)表示连零个数，b{j}{2}表示幅度
    j=j+1;
    i=i+1;
end
b{j}=[0 0];%EOB块编码

%游程编码完毕

binacRange=cell(1,1);%幅度值二进制编码
forHuf=cell(1,1);%Hufman编码的输入参数，每个元素包括两个部分：游程长度和binacRange长度
hufCodeOut=cell(1,1);
out=cell(1,1);
for i=1:j
    binacRange{i}=dec2bin(abs(b{i}(2)));
    binacRange{i}=binacRange{i}-48;
    if(b{i}(2)<0)
        binacRange{i}=~binacRange{i};
    end
    
    acBits(i)=length(binacRange{i});%binacRange长度
    if(b{i}(2)==0) acBits(i)=0;
    end
    forHuf{i}=[b{i}(1) acBits(i)];%forHuf为"行程/尺寸"
end


for i=1:j
    hufCodeOut{i}=YAcHufCode(forHuf{i});%"行程/尺寸的霍夫曼码
    out{i}=[hufCodeOut{i} binacRange{i}];%码包括两部分，即行程/尺寸的霍夫曼码和幅度值编码
    if(b{i}(2)==0)out{i}=hufCodeOut{i}; %幅度为0，则其编码长度为0
    end
end


acCodeOut=out{1};
for i=2:j
    acCodeOut=[acCodeOut out{i}];
end
    

