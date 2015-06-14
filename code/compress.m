%-----------------------------------------------%
%-------------压缩函数---------------------------%
function cc=compress(binImage);  
[Mn,Nm]=size(binImage);             %原始图像大小
c=0;	                            %相同数字计数变量
cc(1,1)=Mn;                         %原始图像大小放入压缩数组的第一、二单元
cc(1,2)=Nm;
p=3;

for i=1:Mn
    for j=1:Nm
        c=c+1;	                    %进行相同数字计数
     if j==1
       if binImage(i,1)==0          %判断每行的第一个数是否为零
          cc(1,p)=0;	            %为0 将第一个数 0 存入数组
          p=p+1;                    %指向数组的下一个
       end
    end
 
if j<Nm
   if (binImage(i,j)~=binImage(i,j+1))  %数字 0，1 有变化
    cc(1,p)=c ;
    p=p+1;
    c=0;
    end
end
end

cc(1,p)=c ;
p=p+1;
c=0;
end


