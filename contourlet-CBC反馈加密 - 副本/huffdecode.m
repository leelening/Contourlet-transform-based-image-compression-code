function vector=huffdecode(zipped,info,vector)
if ~isa(zipped,'uint8')
    error('input mudt be a uint8 vector');
end
len=length(zipped);
string=repmat(uint8(0),1,len*8);
bitindex=1:8;
for index=1:len
    string(bitindex+8.*(index-1))=uint8(bitget(zipped(index),bitindex));
end
string=logical(string(:)');
len=length(string);
weights=2.^(0:51);
vector=repmat(uint8(0),1,info.length);
vectorindex=1;
codeindex=1;
code=0;
for index=1:len
    code=bitset(code,codeindex,string(index));
    codeindex=codeindex+1;
    byte=decode(bitset(code,codeindex),info);
    if byte>0
       vector(vectorindex)=byte-1;
       codeindex=1;
       code=0;
       vectorindex=vectorindex+1;
     end
end
vector=reshape(vector,info.rows,info.cols);
function byte=decode(code,info)
byte=info.huffcodes(code);
    