function unHufCodeOut=UnHufCode(a,binTree)
%��������������������������һ����ʼѰ���Ƿ���ڻ��������ӣ�
%�����������һ�������ض�Ӧ����.�Ƿ��������ֻ����������ָʾ
%����һλ�룬�ڶ�������������һ�����ߵ�Ҷ�Ӽ���ζ�ŵõ�һ������
%����������������һ��Ϊ�������飬�ڶ���Ϊ���������
k=1;
j=1;
for i=1:17
    if(a(i)==1)
        k=binTree(k).oneP;  
        if(k==-1)error('�������');end;
        if(binTree(k).isLeaf==1) 
            unHufCodeOut.data=binTree(k).data;
            unHufCodeOut.hufCodeleng=i;
            break;
        end
    else
        k=binTree(k).zeroP;
        if(k==-1)error('�������');end;
        if(binTree(k).isLeaf==1) 
            unHufCodeOut.data=binTree(k).data;
            unHufCodeOut.hufCodeleng=i;
            break;
        end
    end
end
if(i==17)%���Ϊ16λ
    error('badopt','��������');
end



        
        