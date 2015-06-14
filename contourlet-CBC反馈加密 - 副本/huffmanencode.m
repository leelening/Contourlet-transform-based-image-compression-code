%vector=imread('BABOOEYE.BMP');
%vector=[0.4 0.175 0.15 0.15 0.125];
%vector=uint8(vector);
function [zipped,info]=huffmanencode(vector);
%vector=imread('BABOO.BMP');
if ~isa(vector,'uint8')
   error('input must be uint8 vector')
end
[m,n]=size(vector);
vector=vector(:)';
f=frequency(vector);
simbols=find(f~=0);
f=f(simbols);
[f,sortindex]=sort(f);
simbols=simbols(sortindex);
len=length(simbols);
simbols_index=num2cell(1:len);
codeword_tmp=cell(len,1);
while length(f)>1
    index1=simbols_index{1};
    index2=simbols_index{2};
    codeword_tmp(index1)=addnode(codeword_tmp(index1),uint8(0));
    codeword_tmp(index2)=addnode(codeword_tmp(index2),uint8(1));
    f=[sum(f(1:2)) f(3:end)];
    simbols_index=[{[index1 index2]} simbols_index(3:end)];
    [f,sortindex]=sort(f);
    simbols_index=simbols_index(sortindex);
end      
codeword=cell(256,11);
codeword(simbols)=codeword_tmp;
len=0;
for index=1:length(vector)
    len=len+length(codeword{double(vector(index))+1});
end
string=repmat(uint8(0),1,len);
pointer=1;
for index=1:length(vector);
    code=codeword{double(vector(index))+1};
    len=length(code);
    string(pointer+(0:len-1))=code;
    pointer=pointer+len;
end
len=length(string);
pad=8-mod(len,8);
if pad>0
    string=[string uint8(zeros(1,pad))];
end
codeword=codeword(simbols);
codelen=zeros(size(codeword));
weights=2.^(0:23);
maxcodelen=0;
for index=1:length(codeword)
    len=length(codeword{index});
    if len>maxcodelen
        maxcodelen=len;
    end
    if len>0
        code=sum(weights(codeword{index}==1));
        code=bitset(code,len+1);
        codeword{index}=code;
        codelen(index)=len;
    end
end
codeword=[codeword{:}];
cols=length(string)/8;
string=reshape(string,8,cols);
weights=2.^(0:7);
zipped=uint8(weights*double(string));
huffcodes=sparse(1,1);
for index=1:nnz(codeword)
    huffcodes(codeword(index),1)=simbols(index);
end
info.pad=pad;
info.huffcodes=huffcodes;
info.ratio=cols./length(vector);
info.maxcodelen=maxcodelen;
info.rows=m;
info.cols=n;
info.length=length(vector);


    
