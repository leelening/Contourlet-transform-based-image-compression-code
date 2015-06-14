%主程序
x=rgb2gray(imread('Couple.bmp'));
imshow(uint8(x));
nlevels = [2,2,2] ;        % Decomposition level
pfilter = 'pkva' ;              % Pyramidal filter
dfilter = 'pkva' ;              % Directional filter
coeffs = pdfbdec( double(x), pfilter, dfilter, nlevels );%Contourlet变换后系数
m=encode3(coeffs);%编码

coeffs1=decode(m,coeffs);%解码
% coeffs2=operate(coeffs,coeffs1);
xx=pdfbrec(coeffs1,pfilter, dfilter);%图象重构
t=PSNR(x,xx)%计算峰值信躁比
figure;
imshow(uint8(xx));
