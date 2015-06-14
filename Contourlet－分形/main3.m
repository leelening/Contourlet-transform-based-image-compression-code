%������
x=rgb2gray(imread('Couple.bmp'));
imshow(uint8(x));
nlevels = [2,2,2] ;        % Decomposition level
pfilter = 'pkva' ;              % Pyramidal filter
dfilter = 'pkva' ;              % Directional filter
coeffs = pdfbdec( double(x), pfilter, dfilter, nlevels );%Contourlet�任��ϵ��
m=encode3(coeffs);%����

coeffs1=decode(m,coeffs);%����
% coeffs2=operate(coeffs,coeffs1);
xx=pdfbrec(coeffs1,pfilter, dfilter);%ͼ���ع�
t=PSNR(x,xx)%�����ֵ�����
figure;
imshow(uint8(xx));
