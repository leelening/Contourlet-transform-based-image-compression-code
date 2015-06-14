function Z=rebuild(n,X)
%重构图像程序
  
[a,b]=size(n);%a为子树的个数
[e,f]=size(X);%确定读入的矩阵大小
pic=X;
picc(1:e,1:f)=0;
size_ri=2;
u=1; %
kk=1;%用于将结果放入picc时控制行数
ll=1;%用于将结果放入picc时控制列数
   
       for kk=1:2:(e-1)
           for ll=1:2:(f-1)
        di=n(u,1);
        dj=n(u,2); 
        c=n(u,3);
        t=n(u,4);
        o=n(u,5);
        bb=pic(di:di+3,dj:dj+3);
        u=u+1;
          for c=1:2
            for d=1:2
              b(c,d)=(bb(2*c-1,2*d-1)+bb(2*d,2*c-1)+bb(2*c-1,2*d)+bb(2*c,2*d))/4;
            end
          end
        switch c
        case 1
            temp=b;
        case 2
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(i,size_ri+1-j); 
              end
            end 
         case 3
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(size_ri+1-i,j); 
              end
            end 
         case 4
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(j,i);
              end
            end 
         case 5
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(j,size_ri+1-i);
              end
            end 
         case 6
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(size_ri+1-j,size_ri+1-i);
              end
            end 
          case 7
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(size_ri+1-i,size_ri+1-j);
              end
            end 
          case 8
            for i=1:size_ri
              for j=1:size_ri
                temp(i,j)=b(size_ri+1-j,i);
              end
            end 
        end
      for i=1:size_ri
       for j=1:size_ri
           temp_p(i,j)=temp(i,j)*t+o;
       end
      end 
    picc(kk:kk+1,ll:ll+1)=temp_p;
    
      end
   
     end
  
  Z=picc;
