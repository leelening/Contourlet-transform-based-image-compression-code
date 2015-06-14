function a=PSNR(X,XX)

[m,n]=size(X);
M=double(X);
N=double(XX);

sum=0;
  for i=1:m
      for j=1:n
          sum=sum+(M(i,j)-N(i,j))*(M(i,j)-N(i,j));
      end
  end
  
  MSE=double(sum/(m*n));
  
  a=10*log10((255*255)/MSE);
  
          