function rey=UnCode(CodeOut)
%输入码流，输出灰度矩阵
varable;%定义变量，主要为霍夫曼编码表
yAcTree=MakeTree(yAcTable);%调用函数从码表生成二叉树以便于解码 
yDcTree=MakeTree(yDcTable);

%以下是解码部分
%Uncode应当与z形扫描后得到的数组完全一致
%i是码流数组的指针
%j是解码出来一维数组的指针
%blockcount指明现在正在为第几个块解码
i=1;
j=1;
blockcount=0;
tic
while(i<length(CodeOut))
    blockcount=blockcount+1;
%以下为直流解码部分，解出第blockcount块的直流成分（稍后进行差分解码）
m=UnHufCode(CodeOut(i:end),yDcTree);
%UnHufCode函数输出包含两个域，第一个域hufCodeleng代表霍夫曼码本身的长度，data代表直流幅度值编码的长度

if(m.data~=0)%直流幅度值二进制长度不为0
    dctemp=CodeOut(i+m.hufCodeleng:i+m.hufCodeleng+m.data-1);
    %dctemp取出幅度对应的码段
    if(dctemp(1)==0)%码段第一位为0，则说明幅度为负值
        dctemp=~dctemp;
        Uncode(j)=bin2dec(char(dctemp+48));%调用系统函数变换，变换前需要把数值数组变成字符数组
        Uncode(j)=-Uncode(j);
    else
        Uncode(j)=bin2dec(char(dctemp+48));
    end

    j=j+1;
    i=i+m.hufCodeleng+m.data;
else % 直流二进制幅度值为0，则幅度值编码长度也为0
    i=i+m.hufCodeleng;
    Uncode(j)=0;
    j=j+1;
end
%直流解码部分完毕
 


%以下解码交流系数,解出第blockcount块的交流成分
while(j<=64*blockcount)    
    m=UnHufCode(CodeOut(i:end),yAcTree);%m包括两个域，m.hufCodeleng表示霍夫曼码的长度，
                %m.data为一个1×2数组，分别代表零的个数（0游程）和交流幅度值二进制位数
    temp=m.data;
    if(temp==[0 0])%如果碰到EOB符号，则本块所剩交流系数均为0
        Uncode(j:64*blockcount)=zeros(1,64*blockcount-j+1);
        j=blockcount*64+1;
        i=i+m.hufCodeleng;
        break;     %跳出本块解码，继续进行下一块解码
    end
    
    for(k=1:temp(1))%temp(1)为游程长度
        Uncode(j)=0;
        j=j+1;
    end
    i=i+m.hufCodeleng;              %指针后移霍夫曼编码长度
    
    actemp=CodeOut(i:i+m.data(2)-1);%actemp提取出幅度值对应的码段
    if(m.data(2)==0) %数据为0，只有在16个0连续出现于非eob块时出现
        temp2=0;
    else
       if(actemp(1)==0)             %第一位码为0，则幅度值为负数
           actemp=~actemp;
           temp2=-bin2dec(char(actemp+48));
       else
           temp2=bin2dec(char(actemp+48));
        end
    end

    Uncode(j)=temp2;
    j=j+1;
    i=i+m.data(2);                  %指针后移幅度值编码长度
end
% 交流解码到此结束

%以下为直流差分解码
if(blockcount>=2)
Uncode(blockcount*64-63)=Uncode(blockcount*64-63)+Uncode(blockcount*64-127);
end
%差分解码完毕
end
%解码完毕，获得进行反Z形扫描的一维数组Uncode
disp('解码');
toc
tic
%以下进行反Z形扫描、反量化、idct2获得恢复的灰度矩阵rey
rey=zeros(64,64);
fun5=@antiZscan;
fun6=@antiQuanY;
fun7=@idct2;
for i=1:64/8
    rey((8*i-7):8*i,:)=blkproc(Uncode(64*8*(i-1)+1:64*8*i),[1 64],fun5);
    rey((8*i-7):8*i,:)=blkproc(rey((8*i-7):8*i,:),[8 8],fun6);
    rey((8*i-7):8*i,:)=round(blkproc(rey((8*i-7):8*i,:),[8 8],fun7));
end
disp('反Z形扫描、反量化、idct2');
toc

    
