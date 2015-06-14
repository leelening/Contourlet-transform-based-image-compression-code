clear all;
clc;
%�趨����
pfilt = '9-7';            % choose LP decomposition filter
dfilt = 'pkva';           % choose DFB decomposition filter
nlevs = [1,2,3];    % Number of levels for DFB at each pyramidal level
                            % nlevs: vector of numbers of directional filter bank decomposition levels 
                            %  at each pyramidal level (from coarse to fine scale).                            
th = 3;                     % lead to 3*sigma threshold denoising
 rho=3;
% ����ͼ��
im = imread('lena512.bmp');
im = double(im)/256 ;

sig = std(im(:));
sigma = sig / rho;
% Contourlet �任
% �ֽ�
y = pdfbdec(im, pfilt, dfilt, nlevs);
[c, s] = pdfb2vec(y);
nvar = pdfb_nest(size(im,1), size(im, 2), pfilt, dfilt, nlevs); %nstd = pdfb_nest(nrows, ncols, pfilt, dfilt, nlevs)

cth = th * sigma * sqrt(nvar);
% ϵ������
c = c .* (abs(c) > cth);
% �ع�
y = vec2pdfb(c, s);
cim = pdfbrec(y, pfilt, dfilt);
%��ʾͼ��
range = [0, 1];
colormap(gray);
subplot(1,1,1),imagesc(cim(41:168, 181:308), range); axis image off
colormap(gray);
set(gca, 'FontSize', 8);
title('Contourlets decomposition', 'FontSize', 10)
