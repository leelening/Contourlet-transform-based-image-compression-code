%Hufman tree drawing phase
function HT=fhtree1(lst,img)
[p,q]=size(lst);
[tt,mx]=size(lst);
sz1=q;
xx=1;
k1=0;
prt=0;
while (k1<1)
    k1=lst(2)+lst(4);
    prt=prt-1;
    lstn(xx)=lst(1);
    lstn(xx+1)=0;
    lstn(xx+2)=prt;
    xx=xx+3;
    lstn(xx)=lst(3);
    lstn(xx+1)=1;
    lstn(xx+2)=prt;
    xx=xx+3;
    lst(1)=prt;
    lst(2)=k1;
    lst(3)=99;
    lst(4)=99;

for i=2:2:mx
    for j=i:2:mx
        if (lst(i)>lst(j))
            temp1=lst(i-1);
            temp2=lst(i);
            lst(i-1)=lst(j-1);
            lst(i)=lst(j);
            lst(j-1)=temp1;
            lst(j)=temp2;
        end
    end
end
end
lstn(xx)=lst(1);
lstn(xx+1)=lst(2);
lstn(xx+2)=lst(3);
disp('Calling fhcode...');  
fhcode(lstn,img)