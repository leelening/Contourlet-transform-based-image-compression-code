function zScanOut=ZScan(zScanIn)
%����8*8�ľ������Z��ɨ����
%��Ϊ�����ֽ��У���һ����Ϊ�������Ͽ飬�ڶ�����Ϊ���¿�
N=8;
m=1;
%���Ͽ�ɨ�迪ʼ
for k=1:N
    if(round(k/2)==k/2) %kΪż��
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
%���Ͽ�ɨ�迪ʼ

%���¿�ɨ�迪ʼ
for k=(N+1):(2*N-1)
    if(round(k/2)==k/2) %kΪż��
        j=N;i=k+1-j;
    else
        i=N;j=k+1-i;
    end
    
    zScanOut(m)=zScanIn(i,j);
    m=m+1;
    
    if(round(k/2)==k/2) %kΪż��
        while(i~=N)
            i=i+1;j=j-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    else
        while(j~=N)
            j=j+1;i=i-1;zScanOut(m)=zScanIn(i,j);m=m+1;
        end
    end
end
    
    
    
