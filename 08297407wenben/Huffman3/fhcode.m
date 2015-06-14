%Hufman code generating phase
function HC=fhcode(lstn,img)
disp('Code generating phase entered...');
[lm,ln]=size(lstn);
ntt=ln-1;
[im,in]=size(img);
t=0;
idd=input('Enter destination huffman code file name : ','s');
tab=input('Enter the Huff Table name (for decoding purpose): ','s');
tb = fopen(tab,'w+');
idd=fopen(idd,'w+');
fst1='';
fst2='';
ed=0;
din=0;
% Traversing the Tree resembling list resulting in reverse Huffman code for a particular character%
disp('Building Huffman Table.........');
for i=1:in
    k=img(i);
    ftemp=img(i);
    a=0;
    for j=1:3:ln
        if(lstn(j+2)==99)
            break;
        end
        if(lstn(j)==k)
            a=a+1;
            ary(a)=lstn(j+1);
            k=lstn(j+2);
        end
    end
    % Reversing the reverse Huffman Code%
    for b=a:-1:1
        t=t+1;
        hc(t)=ary(b);
        fprintf(idd,'%d',ary(b));
        fst1=int2str(ary(b));
        fst2=strcat(fst2,fst1);
    end
    %Building Huffman Table for Decoding%
    din=0;
    for z=1:ed
        if dict(z)==ftemp
            din=1;
        end
    end
    if din==0
        ed=ed+1;
        dict(ed)=ftemp;
        fprintf(tb,'%c',' ');
        fprintf(tb,'%c',ftemp);
        fprintf(tb,'%s',fst2);     
    end
    fst1='';
    fst2='';
end
fclose(tb);
%Converting 8 bit Binary to ASCII character and storing the result in specified file%
disp('Converting binary huffman codes to ASCII characters......');
nme=input('Enter the destination file name :','s');
disp('Generating the compressed file..........');
id = fopen(nme,'w+');
for i=1:8:t
    ck=t-i+1;
    if(ck>8)
        tp=(hc(i:i+7));
        num=8;
    else
        tp=(hc(i:t));
        num=ck;
    end      
    temp1=b2d(tp,num);
    temp2=char(temp1);
    fprintf(id,'%c',temp2);
end
fclose(id); 
fclose(idd);
disp('Generated Compressed file');
return