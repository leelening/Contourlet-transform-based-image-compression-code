function zScanOut=ZScan(zScanIn)
%输入8*8的矩阵，输出Z形扫描结果
%分为两步分进行，第一部分为矩阵左上块，第二部分为右下块
N=8;
m=1;
%左上块扫描开始
for k=1:N
    if(round(k/2)==k/2) %k为偶数
        i=1;j=k;
    else
        i=k;j=1;
    end    
    zScanOut(m)=zScanIn(i,j);
    m=m+1;
    
    if(round(k/2)==k/2)
        while(i~=k) 
            i=i+1;j=j-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    else
        while(j~=k)
            i=i-1;j=j+1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    end
end
%左上块扫描开始

%右下块扫描开始
for k=(N+1):(2*N-1)
    if(round(k/2)==k/2) %k为偶数
        j=N;i=k+1-j;
    else
        i=N;j=k+1-i;
    end
    
    zScanOut(m)=zScanIn(i,j);
    m=m+1;
    
    if(round(k/2)==k/2) %k为偶数
        while(i~=N)
            i=i+1;j=j-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    else
        while(j~=N)
            j=j+1;i=i-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    end
end
    
    
    
