clc;
clear;
tic;
pfilt = '9-7';
dfilt = 'pkva';
nlevs = [1,2,3];    % Number of levels for DFB at each pyramidal level

% Test image: the usual suspect...
im = imread('lena.bmp');
imshow(im);
title('原始图像');
% nim = double(im) / 256;
% imshow(im);
nim =double(im);

%%%%% Contourlet %%%%%
% Contourlet transform
y = pdfbdec(nim, pfilt, dfilt, nlevs);
[c, s] = pdfb2vec(y);

[Image,sc,dmatrix]=double2uint(c);  %调整系数
x=select(Image);
code=RLC(x);

Image=dec(code);
Image_r=uint2double(Image,sc,dmatrix);
c = Image_r;

% Reconstruction
y = vec2pdfb(c, s);
cim = pdfbrec(y, pfilt, dfilt);
cim = uint8(cim);
%cim = imshow(cim);
figure,imshow(cim);
title('重建图像');
toc;
% tt=toc;
% fprintf('elapsed time = %fs\n',tt);