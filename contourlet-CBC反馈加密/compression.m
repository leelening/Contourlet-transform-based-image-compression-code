%-----------------------------------------------%
%-------------ѹ������---------------------------%
function cc=compress(binImage);  
[Mn,Nm]=size(binImage);             %ԭʼͼ���С
c=0;	                            %��ͬ���ּ�������
cc(1,1)=Mn;                         %ԭʼͼ���С����ѹ������ĵ�һ������Ԫ
cc(1,2)=Nm;
p=3;

for i=1:Mn
    for j=1:Nm
        c=c+1;	                    %������ͬ���ּ���
     if j==1
       if binImage(i,1)==0          %�ж�ÿ�еĵ�һ�����Ƿ�Ϊ��
          cc(1,p)=0;	            %Ϊ0 ����һ���� 0 ��������
          p=p+1;                    %ָ���������һ��
       end
    end
 
if j<Nm
   if (binImage(i,j)~=binImage(i,j+1))  %���� 0��1 �б仯
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


