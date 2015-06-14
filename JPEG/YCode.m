function codeOut=YCode(zscanOut,prevDc)
%输入z形扫描结果，1*64矩阵，输出一维长度不定码流


%定义hufman直流码表
yDcTable(1,11)=struct('code',[],'data',[]);
yDcTable(1).data=0;
yDcTable(1).code=[0 0];
yDcTable(2).data=1;
yDcTable(2).code=[0 1 0];
yDcTable(3).data=2;
yDcTable(3).code=[0 1 1];
yDcTable(4).data=3;
yDcTable(4).code=[1 0 0];
yDcTable(5).data=4;
yDcTable(5).code=[1 0 1];
yDcTable(6).data=5;
yDcTable(6).code=[1 1 0];
yDcTable(7).data=6;
yDcTable(7).code=[1 1 1 0];
yDcTable(8).data=7;
yDcTable(8).code=[1 1 1 1 0];
yDcTable(9).data=8;
yDcTable(9).code=[1 1 1 1 1 0];
yDcTable(10).data=9;
yDcTable(10).code=[1 1 1 1 1 1 0];
yDcTable(11).data=10;
yDcTable(11).code=[1 1 1 1 1 1 1 0];
yDcTable(11).data=11;
yDcTable(11).code=[1 1 1 1 1 1 1 1 0];

%直流编码
diff=zscanOut(1)-prevDc;
if(diff==0)
    dcCodeOut=[0 0 ];
else
    rangeCode=dec2bin(abs(diff));
    rangeCode=double(rangeCode)-48;
    if(diff<0)
        rangeCode=~rangeCode;
    end
    sizeCode=yDcTable(length(rangeCode)+1).code;
    dcCodeOut=[sizeCode rangeCode];
end
 

 %交流编码
 acCodeOut=AcCode(zscanOut);
 codeOut=[dcCodeOut acCodeOut];
 
     
     



