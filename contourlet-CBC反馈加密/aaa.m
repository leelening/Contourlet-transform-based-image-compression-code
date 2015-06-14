clc;
clear;
tic;
pfilt = '9-7';      % choose LP decomposition filter
dfilt = 'pkva';     % choose DFB decomposition filter
nlevs = [1,2,3];    % Number of levels for DFB at each pyramidal level

% Test image: the usual suspect...
im = imread('lena.bmp');
figure,imshow(im);
title('ԭʼͼ��');
%hold on;
%winopen('lena.bmp');
Matrixsize = 20000;

nim =double(im);

%%%%% Contourlet %%%%%
% Contourlet transform
y = pdfbdec(nim, pfilt, dfilt, nlevs);  %�������ֽ�
[c, s] = pdfb2vec(y);  %�������������˲���������ת���ɲ�ͬ�߶��µķ����Ӵ�

[Image,sc,dmatrix]=double2uint(c);  %����ϵ��
x = select(Image);  %����
x = x - 43;
[m,n]=size(x);
x1 = zeros(1,Matrixsize);
x1 = x(1:Matrixsize);
%x1((Matrixsize+1):348160) = 0;

x1 = double(x1)/255;
imwrite(x1,'ҪHuffman�����lena.bmp','bmp');

%Coding('Ҫ�γ̱����lena.bmp','rlc.txt');
%dlmwrite('rlc.txt',x1);

%CBC_cryp;
%CBC_decryp;

%image1=load('rlc1.txt');
%Decoding('rlc.txt','�γ̱���֮���lena.bmp');


Huffman();



%image1 = imread('Ҫ�γ̱����lena.bmp','bmp');


x2=zeros(1,n);
x2(1:Matrixsize)=pp(1:Matrixsize);
x2((Matrixsize+1):348160) = 0;
x2 = x2 + 43;

Image_r=uint2double(x2,sc,dmatrix);    %ϵ��������ȥ
c = Image_r;


% Reconstruction
y = vec2pdfb(c, s);  %����ͬ�߶��µķ����Ӵ�ת���ɽ����������˲���������
cim = pdfbrec(y, pfilt, dfilt);  %�������������˲��������ؽ�
cim = uint8(cim);


figure,imshow(cim);
title('�ؽ�ͼ��');
%hold on;
imwrite(cim,'ѹ����lena.bmp','bmp');
%winopen('ѹ����lena.bmp');

toc;
im = double(im);
cim = double(cim);
ratio =( 512 * 512 ) / Matrixsize
y = psnr(im, cim)

%%%%% Chaos %%%%%
%encrypt1;


%decrypt1;

