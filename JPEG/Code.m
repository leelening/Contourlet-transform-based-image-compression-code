function yCodeOut=Code(y)

row=64;
col=64;

fun1=@QuantyY;% ��������

fun3=@dct2;

tic
%%%�Ƚ���DCT�任
ydct=blkproc(y,[8,8],fun3);
disp('DCT');
toc

%%%%%%%����
tic
quanity_y=round(blkproc(ydct,[8,8],fun1));
disp('����');
toc

%%%%%%%Z��ɨ��
tic
zscan_y=zeros(1,64*64);
zscan=@Zscan;%ZscanΪZ��ɨ�躯��
zscan_y=blkproc(quanity_y,[8 8],zscan);
zscan_y=zscan_y'; %ת��
disp('����ɨ��');
toc


tic
%%%%%%%%%%����
yCodeOut=YCode(zscan_y(1:64),0);
for i=2:(row*col/64)
    m=YCode(zscan_y(64*i-63:64*i),zscan_y(64*(i-1)-63));
    yCodeOut=[yCodeOut m];
end
disp('����');
toc

