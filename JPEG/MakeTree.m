function binTree=MakeTree(table)
%�����������������ڿ��ٽ���
%���������ڹ���������
%����������������
binTree(1,500)=struct('oneP',[],'zeroP',[],'isLeaf',[]);
for i=1:600
    binTree(i).oneP=-1;
    binTree(i).zeroP=-1;
    binTree(i).isLeaf=0;
end

N=length(table);


leafcount=1;

m=2;%mָ��������������һ����Žڵ��λ��
for i=1:N
    k=1;%��ǰ�ڵ��λ��
    for j=1:(length(table(i).code)-1)
        if(table(i).code(j)==0)%������Ϊ0����˳��0ָ��zeroP������
            if(binTree(k).zeroP==-1)
                binTree(k).zeroP=m;
                k=m;
                m=m+1;
            else
                temp=k;
                k=binTree(k).zeroP;
            end

        else                       %������Ϊ11����˳��1ָ��oneP������
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
        if(binTree(k).zeroP~=-1)%���һ�����ӵ����һλΪ0���ҵ�ǰ�������ڵ���ָ�벻Ϊ�գ�����������ظ�
           error('����������,�������ظ�');
          
        else
            binTree(k).zeroP=m;
            binTree(m).isLeaf=1;
            binTree(m).data=table(i).data;
            m=m+1;
        end
    else
       if(binTree(k).oneP~=-1)%���һ�����ӵ����һλΪ11���ҵ�ǰ�������ڵ�1ָ�벻Ϊ�գ�����������ظ�
           error('����������,�������ظ�');   
       else
            binTree(k).oneP=m;
            binTree(m).isLeaf=1;
            binTree(m).data=table(i).data;
            m=m+1;
       end
    end
end
      



