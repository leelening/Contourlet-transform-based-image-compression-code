clc;
clear;
tic;
pfilt = '9-7';      % choose LP decomposition filter
dfilt = 'pkva';     % choose DFB decomposition filter
nlevs = [1,2,3];    % Number of levels for DFB at each pyramidal level

% Test image: the usual suspect...
im = imread('lena.bmp');
figure,imshow(im);
title('原始图像');
%hold on;
%winopen('lena.bmp');
Matrixsize = 20000;

nim =double(im);

%%%%% Contourlet %%%%%
% Contourlet transform
y = pdfbdec(nim, pfilt, dfilt, nlevs);  %轮廓波分解
[c, s] = pdfb2vec(y);  %将金字塔方向滤波器组的输出转化成不同尺度下的方向子带

[Image,sc,dmatrix]=double2uint(c);  %调整系数
x = select(Image);  %量化
x = x - 43;
[m,n]=size(x);
x1 = zeros(1,Matrixsize);
x1 = x(1:Matrixsize);
%x1((Matrixsize+1):348160) = 0;

x1 = double(x1)/255;
imwrite(x1,'要Huffman编码的lena.bmp','bmp');

%Coding('要游程编码的lena.bmp','rlc.txt');
%dlmwrite('rlc.txt',x1);

%CBC_cryp;
%CBC_decryp;

%image1=load('rlc1.txt');
%Decoding('rlc.txt','游程编码之后的lena.bmp');


Huffman();



%image1 = imread('要游程编码的lena.bmp','bmp');


x2=zeros(1,n);
x2(1:Matrixsize)=pp(1:Matrixsize);
x2((Matrixsize+1):348160) = 0;
x2 = x2 + 43;

Image_r=uint2double(x2,sc,dmatrix);    %系数调整回去
c = Image_r;


% Reconstruction
y = vec2pdfb(c, s);  %将不同尺度下的方向子带转化成金字塔方向滤波器组的输出
cim = pdfbrec(y, pfilt, dfilt);  %将金字塔方向滤波组的输出重建
cim = uint8(cim);


figure,imshow(cim);
title('重建图像');
%hold on;
imwrite(cim,'压缩的lena.bmp','bmp');
%winopen('压缩的lena.bmp');

toc;
im = double(im);
cim = double(cim);
ratio =( 512 * 512 ) / Matrixsize
y = psnr(im, cim)

%%%%% Chaos %%%%%
%encrypt1;


%decrypt1;

