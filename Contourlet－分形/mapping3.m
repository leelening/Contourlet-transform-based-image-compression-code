function Z=mapping3(X)
%匹配程序
%X,为系数矩阵
%Z为编码输出矩阵

M=X;
[m,n]=size(X);

%r代表子树，用a表示
%d代表父树，用b表示


l=1;%记录子树个数
t1=m-1;%子树搜索范围,在搜索范围改变时也要相应改变
t2=n-3;%父树搜索范围,在搜索范围改变时也要相应改变

size_ri=2;

   for  ri=1:2:t1 %步进为2，子块不能重复
     
       for rj=1:2:t1 %步进为2，子块不能重复
      
           a(1:2,1:2)=M(ri:ri+1,rj:rj+1);  %取子块
    sum_a=0;
    sum_a2=0;
   for i=1:size_ri
       for j=1:size_ri
          sum_a=sum_a+a(i,j);
          sum_a2=sum_a2+a(i,j)*a(i,j);
      end
  end

  %父树
  for di=1:t2 %步进为2
      for dj=1:t2 %步进为2
           bb=M(di:di+3,dj:dj+3);
  for m=1:2
      for n=1:2
          b(m,n)=(bb(2*m-1,2*n-1)+bb(2*n,2*m-1)+bb(2*m-1,2*n)+bb(2*m,2*n))/4;
      end
  end
  sum_b=0;
  sum_b2=0;
  for i=1:size_ri
      for j=1:size_ri
          sum_b=sum_b+b(i,j);
          sum_b2=sum_b2+b(i,j)*b(i,j);
      end
  end
  
 %8种对称变换的坐标变化
   set_1=b;
    for i=1:size_ri
        for j=1:size_ri
             set_2(i,j)=b(i,size_ri+1-j);
             set_3(i,j)=b(size_ri+1-i,j);
             set_4(i,j)=b(j,i);
             set_5(i,j)=b(j,size_ri+1-i);
             set_6(i,j)=b(size_ri+1-j,size_ri+1-i);
             set_7(i,j)=b(size_ri+1-i,size_ri+1-j);
             set_8(i,j)=b(size_ri+1-j,i);
        end
    end
             
 %恒等变换
  sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_1(i,j);
         end
     end
     sum=size_ri*size_ri;
     t(1)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(1)=(sum_a-t(1)*sum_b)/sum;
           r(1)=(sum_a2+t(1)*t(1)*sum_b2-2*t(1)*sum_ab+2*o(1)*t(1)*sum_b-2*o(1)*sum_a*t(1)+sum*o(1)*o(1))/sum;
 %2
   sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_2(i,j);
         end
     end
             
     t(2)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(2)=(sum_a-t(2)*sum_b)/sum;
           r(2)=(sum_a2+t(2)*t(2)*sum_b2-2*t(2)*sum_ab+2*o(2)*t(2)*sum_b-2*o(2)*sum_a*t(2)+sum*o(2)*o(2))/sum;  
     
 %3
    sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_3(i,j);
         end
     end
             
      t(3)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(3)=(sum_a-t(3)*sum_b)/sum;
           r(3)=(sum_a2+t(3)*t(3)*sum_b2-2*t(3)*sum_ab+2*o(3)*t(3)*sum_b-2*o(3)*sum_a*t(3)+sum*o(3)*o(3))/sum;  
       
  %4
    sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_4(i,j);
         end
     end
             
     t(4)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(4)=(sum_a-t(4)*sum_b)/sum;
           r(4)=(sum_a2+t(4)*t(4)*sum_b2-2*t(4)*sum_ab+2*o(4)*t(4)*sum_b-2*o(4)*sum_a*t(4)+sum*o(4)*o(4))/sum;  
     
  %5
    sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_5(i,j);
         end
     end
             
     t(5)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(5)=(sum_a-t(5)*sum_b)/sum;
           r(5)=(sum_a2+t(5)*t(5)*sum_b2-2*t(5)*sum_ab+2*o(5)*t(5)*sum_b-2*o(5)*sum_a*t(5)+sum*o(5)*o(5))/sum;  
     
  %6
     sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_6(i,j);
         end
     end
             
    t(6)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(6)=(sum_a-t(6)*sum_b)/sum;
           r(6)=(sum_a2+t(6)*t(6)*sum_b2-2*t(6)*sum_ab+2*o(6)*t(6)*sum_b-2*o(6)*sum_a*t(6)+sum*o(6)*o(6))/sum; 
     
  %7
    sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_7(i,j);
         end
     end
             
     t(7)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(7)=(sum_a-t(7)*sum_b)/sum;
           r(7)=(sum_a2+t(7)*t(7)*sum_b2-2*t(7)*sum_ab+2*o(7)*t(7)*sum_b-2*o(7)*sum_a*t(7)+sum*o(7)*o(7))/sum;  
     
  %8
     sum_ab=0;
     for i=1:size_ri
         for j=1:size_ri
             sum_ab=sum_ab+a(i,j)*set_8(i,j);
         end
     end
             
     t(8)=(sum*sum_ab-sum_a*sum_b)/(sum*sum_b2-sum_b*sum_b);
          o(8)=(sum_a-t(8)*sum_b)/sum;
           r(8)=(sum_a2+t(8)*t(8)*sum_b2-2*t(8)*sum_ab+2*o(8)*t(8)*sum_b-2*o(8)*sum_a*t(8)+sum*o(8)*o(8))/sum;  
     
   %匹配
     comp=abs(r(1)); %对于这一个点的8种变换进行筛选
     for ci=1:8
         if comp>=(r(ci))
             comp=abs(r(ci));
              set_num=ci;
         end
     end
         res_di(di,dj)=comp;
         res_ci(di,dj)=set_num;
         res_t(di,dj)=t(ci);
         res_o(di,dj)=o(ci);
      end
  end %父树循环在此结束
  
  
  comp=res_di(1,1);
   for di=1:t2
      for dj=1:t2
         if comp>=res_di(di,dj)
             comp=res_di(di,dj);
             res_ri(l,1)=di;
             res_ri(l,2)=dj; 
             res_ri(l,3)=res_ci(di,dj);
             res_ri(l,4)=res_t(di,dj);
             res_ri(l,5)=res_o(di,dj);
             res_ri(l,6)=res_di(di,dj);
         end
      end
     
   end
     l=l+1;
  end 
end    %子树循环在此结束
 
  Z=res_ri;
 
     