%===================================
%游程编码解压缩子程序
%===================================
function   decop=decompress(RE,Mn,Nm)
td=find(RE==-1);                  
%-------------------处理第一行数据------------------%
                                    
                                   
for i=1:RE(1)                      
    y(i)=1;
end
for  m=2:2:(td(1)-2)               
    for j=i+1:RE(m)+i               
        y(j)=0;                     
    end
    for i=j+1:RE(m+1)+j           
        y(i)=1;                 
    end
end
if  RE(td(1)-1)==0                 
    y=~y;                          
end
mx(1,:)=y(1:Nm);                   
%--------------循环处理第一行之后数据---------------%
for t=2:length(td)                  
    for i=1:RE(td(t-1)+1)          
        y(i)=1;
    end
    for m=(td(t-1)+2):2:(td(t)-2)   
        for j=i+1:RE(m)+i
            y(j)=0;
        end
        for i=j+1:RE(m+1)+j
            y(i)=1;
        end
    end
    if  RE(td(t)-1)==0             
        y=~y;
    end
    mx(t,:)=y(1:Nm);                
                                     
end
decop=mx;                        