%===================================
%�γ̱����ѹ���ӳ���
%===================================
function   decop=decompress(RE,Mn,Nm)
td=find(RE==-1);                  
%-------------------�����һ������------------------%
                                    
                                   
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
%--------------ѭ�������һ��֮������---------------%
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