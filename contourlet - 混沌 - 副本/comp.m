%===================================
%游程编码压缩子程序
%===================================
function   comp=compress(xr,Mn)
k=0;
n=1;
renum=1;
for mn=1:Mn                        
    x=xr(mn,:);                    
    for j=1:length(x)-1           
        if  x(j)==x(j+1)           
            renum=renum+1;         
        else
            k=k+1;                 
            REG(k)=renum;           
            renum=1;                
        end
    end
            REG(k+1)= renum;        
            REG(k+2)=x(1);          
            REG(k+3)=-1;           
            n=n+k+3;                
            RE(1,n-k-3:n-1)=REG;    
            REG=0;                 
            k=0;                    
            renum=1;               
end
comp=RE;                            