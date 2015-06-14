function binTree=MakeTree(table)
%利用码表构造二叉树便于快速解码
%二叉树存于构架数组中
%输入码表，输出二叉树
binTree(1,500)=struct('oneP',[],'zeroP',[],'isLeaf',[]);
for i=1:600
    binTree(i).oneP=-1;
    binTree(i).zeroP=-1;
    binTree(i).isLeaf=0;
end

N=length(table);


leafcount=1;

m=2;%m指明构架数组中下一个存放节点的位置
for i=1:N
    k=1;%当前节点的位置
    for j=1:(length(table(i).code)-1)
        if(table(i).code(j)==0)%读入码为0，则顺着0指针zeroP往下走
            if(binTree(k).zeroP==-1)
                binTree(k).zeroP=m;
                k=m;
                m=m+1;
            else
                temp=k;
                k=binTree(k).zeroP;
            end

        else                       %读入码为11，则顺着1指针oneP往下走
            if(binTree(k).oneP==-1)
                binTree(k).oneP=m;
                k=m;
                m=m+1;
            else
                temp=k;
                k=binTree(k).oneP;
            end
        end
    end
    
    if(table(i).code(j+1)==0)
        if(binTree(k).zeroP~=-1)%如果一个码子的最后一位为0，且当前二叉树节点零指针不为空，则出现码子重复
           error('编码树错误,出现码重复');
          
        else
            binTree(k).zeroP=m;
            binTree(m).isLeaf=1;
            binTree(m).data=table(i).data;
            m=m+1;
        end
    else
       if(binTree(k).oneP~=-1)%如果一个码子的最后一位为11，且当前二叉树节点1指针不为空，则出现码子重复
           error('编码树错误,出现码重复');   
       else
            binTree(k).oneP=m;
            binTree(m).isLeaf=1;
            binTree(m).data=table(i).data;
            m=m+1;
       end
    end
end
      



