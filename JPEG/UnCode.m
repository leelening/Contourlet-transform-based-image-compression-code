function rey=UnCode(CodeOut)
%��������������ҶȾ���
varable;%�����������ҪΪ�����������
yAcTree=MakeTree(yAcTable);%���ú�����������ɶ������Ա��ڽ��� 
yDcTree=MakeTree(yDcTable);

%�����ǽ��벿��
%UncodeӦ����z��ɨ���õ���������ȫһ��
%i�����������ָ��
%j�ǽ������һά�����ָ��
%blockcountָ����������Ϊ�ڼ��������
i=1;
j=1;
blockcount=0;
tic
while(i<length(CodeOut))
    blockcount=blockcount+1;
%����Ϊֱ�����벿�֣������blockcount���ֱ���ɷ֣��Ժ���в�ֽ��룩
m=UnHufCode(CodeOut(i:end),yDcTree);
%UnHufCode����������������򣬵�һ����hufCodeleng����������뱾��ĳ��ȣ�data����ֱ������ֵ����ĳ���

if(m.data~=0)%ֱ������ֵ�����Ƴ��Ȳ�Ϊ0
    dctemp=CodeOut(i+m.hufCodeleng:i+m.hufCodeleng+m.data-1);
    %dctempȡ�����ȶ�Ӧ�����
    if(dctemp(1)==0)%��ε�һλΪ0����˵������Ϊ��ֵ
        dctemp=~dctemp;
        Uncode(j)=bin2dec(char(dctemp+48));%����ϵͳ�����任���任ǰ��Ҫ����ֵ�������ַ�����
        Uncode(j)=-Uncode(j);
    else
        Uncode(j)=bin2dec(char(dctemp+48));
    end

    j=j+1;
    i=i+m.hufCodeleng+m.data;
else % ֱ�������Ʒ���ֵΪ0�������ֵ���볤��ҲΪ0
    i=i+m.hufCodeleng;
    Uncode(j)=0;
    j=j+1;
end
%ֱ�����벿�����
 


%���½��뽻��ϵ��,�����blockcount��Ľ����ɷ�
while(j<=64*blockcount)    
    m=UnHufCode(CodeOut(i:end),yAcTree);%m����������m.hufCodeleng��ʾ��������ĳ��ȣ�
                %m.dataΪһ��1��2���飬�ֱ������ĸ�����0�γ̣��ͽ�������ֵ������λ��
    temp=m.data;
    if(temp==[0 0])%�������EOB���ţ��򱾿���ʣ����ϵ����Ϊ0
        Uncode(j:64*blockcount)=zeros(1,64*blockcount-j+1);
        j=blockcount*64+1;
        i=i+m.hufCodeleng;
        break;     %����������룬����������һ�����
    end
    
    for(k=1:temp(1))%temp(1)Ϊ�γ̳���
        Uncode(j)=0;
        j=j+1;
    end
    i=i+m.hufCodeleng;              %ָ����ƻ��������볤��
    
    actemp=CodeOut(i:i+m.data(2)-1);%actemp��ȡ������ֵ��Ӧ�����
    if(m.data(2)==0) %����Ϊ0��ֻ����16��0���������ڷ�eob��ʱ����
        temp2=0;
    else
       if(actemp(1)==0)             %��һλ��Ϊ0�������ֵΪ����
           actemp=~actemp;
           temp2=-bin2dec(char(actemp+48));
       else
           temp2=bin2dec(char(actemp+48));
        end
    end

    Uncode(j)=temp2;
    j=j+1;
    i=i+m.data(2);                  %ָ����Ʒ���ֵ���볤��
end
% �������뵽�˽���

%����Ϊֱ����ֽ���
if(blockcount>=2)
Uncode(blockcount*64-63)=Uncode(blockcount*64-63)+Uncode(blockcount*64-127);
end
%��ֽ������
end
%������ϣ���ý��з�Z��ɨ���һά����Uncode
disp('����');
toc
tic
%���½��з�Z��ɨ�衢��������idct2��ûָ��ĻҶȾ���rey
rey=zeros(64,64);
fun5=@antiZscan;
fun6=@antiQuanY;
fun7=@idct2;
for i=1:64/8
    rey((8*i-7):8*i,:)=blkproc(Uncode(64*8*(i-1)+1:64*8*i),[1 64],fun5);
    rey((8*i-7):8*i,:)=blkproc(rey((8*i-7):8*i,:),[8 8],fun6);
    rey((8*i-7):8*i,:)=round(blkproc(rey((8*i-7):8*i,:),[8 8],fun7));
end
disp('��Z��ɨ�衢��������idct2');
toc

    
