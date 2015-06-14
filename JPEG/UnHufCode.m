function unHufCodeOut=UnHufCode(a,binTree)
%根据输入码流，从输入码流第一个开始寻找是否存在霍夫曼码子，
%如果有则解码第一个并返回对应数据.是否存在码子只需依据码流指示
%读入一位码，在二叉树上往下走一步，走到叶子即意味着得到一个码子
%输入两个参数，第一个为码流数组，第二个为解码二叉树
k=1;
j=1;
for i=1:17
    if(a(i)==1)
        k=binTree(k).oneP;  
        if(k==-1)error('错误编码');end;
        if(binTree(k).isLeaf==1) 
            unHufCodeOut.data=binTree(k).data;
            unHufCodeOut.hufCodeleng=i;
            break;
        end
    else
        k=binTree(k).zeroP;
        if(k==-1)error('错误编码');end;
        if(binTree(k).isLeaf==1) 
            unHufCodeOut.data=binTree(k).data;
            unHufCodeOut.hufCodeleng=i;
            break;
        end
    end
end
if(i==17)%码最长为16位
    error('badopt','码流有误');
end



        
        