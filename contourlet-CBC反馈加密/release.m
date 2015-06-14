%--------------------------------------------------%

%-----------------解压函数-------------------------%

function re=reelease(cc);
[K,L]=size(cc);           %得到压缩图像的大小

Mn=cc(1,1);               %得到原始图像的大小
Nm=cc(1,2);
 
p=3;                      %指向压缩数据的第一位

 

 i=1;

 while p<=L
    j=1;
  %-----压缩数组的第一个数值为0-----------% 
    if cc(p)==0
         p=p+1;  
         for k=1:cc(p)   %统计第一个数值为0的个数0
             re(i,j)=0;
             j=j+1;
             end
        while j<=Nm      %控制循环次数
          p=p+1;
          for k=1:cc(p)  %个数1的统计
            re(i,j)=1;
            j=j+1;
          end
          p=p+1;
         if j<=Nm 
         for k=1:cc(p)   %个数0的统计
          re(i,j)=0;
           j=j+1;
         end
          end
      
        end
    
    else 
%-----压缩数组的第一个图像为1-----------% 
    while j<=Nm      %控制循环次数
          
             for k=1:cc(p-1)  %个数1的统计
             re(i,j)=1;
             j=j+1;
             end
      p=p+1;
      if j<=Nm
         for k=1:cc(p-1)   %个数0的统计
            re(i,j)=0;
            j=j+1;
         end
      p=p+1;
       end
   end
    end
 i=i+1;        %扫描下一行
    end
