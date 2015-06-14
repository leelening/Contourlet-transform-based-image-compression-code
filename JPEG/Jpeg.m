%function rey = Jpeg()
%返回解码所得灰度矩阵

tic
y=imread('1.tif');
y=y(1:64,1:64);

codeout=Code(y);
disp('读取编码时间:');
toc

%码流文件
length1 =length(codeout)+3;
pad =8-rem(length1,8);
if pad~=8
    pad =pad;
else 
    pad = 0;
end
pad_bin = dec2bin(pad,3);
pad_bin = str2num(pad_bin(:))';
codeout = [pad_bin codeout];
fid = fopen('pic.dat','wb');
fwrite(fid,codeout,'uint1');
fclose(fid);

fid = fopen('pic.dat','rb');
codeout = fread(fid,'uint1');
pad_bin = codeout(1:3);
pad =0;
 for i =1:3
     pad = pad_bin(i)*2^(i-1) + pad;
 end
codeout =codeout(4:end-pad);
codeout = codeout';
fclose(fid);

tic
rey=UnCode(codeout);
disp('解码时间');
toc

show(y,rey);

disp('压缩倍数');
64*64*8/length(codeout)
disp('峰值信噪比(dB)');
deta=mean(mean((rey-double(y)).^2))/255^2;
PSNR=-10*log10(deta)
