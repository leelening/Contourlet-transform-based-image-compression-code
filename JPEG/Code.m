function yCodeOut=Code(y)

row=64;
col=64;

fun1=@QuantyY;% 量化函数

fun3=@dct2;

tic
%%%先进行DCT变换
ydct=blkproc(y,[8,8],fun3);
disp('DCT');
toc

%%%%%%%量化
tic
quanity_y=round(blkproc(ydct,[8,8],fun1));
disp('量化');
toc

%%%%%%%Z形扫描
tic
zscan_y=zeros(1,64*64);
zscan=@Zscan;%Zscan为Z形扫描函数
zscan_y=blkproc(quanity_y,[8 8],zscan);
zscan_y=zscan_y'; %转置
disp('ｚ形扫描');
toc


tic
%%%%%%%%%%编码
yCodeOut=YCode(zscan_y(1:64),0);
for i=2:(row*col/64)
    m=YCode(zscan_y(64*i-63:64*i),zscan_y(64*(i-1)-63));
    yCodeOut=[yCodeOut m];
end
disp('编码');
toc


