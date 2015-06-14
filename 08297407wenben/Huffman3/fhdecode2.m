%Huffman decoder for text compression
%When the program asks for file name enter file name given to the destination file  
clc;
clear all;
%Accepting the decoded file and storing it in character array a%
nme=input('Enter the file name (the ASCII file enterd at compression time) : ','s');
id = fopen(nme,'r');
a = fscanf(id,'%c',inf);
fclose(id);
[m,n]=size(a);
k=1;
for i=1:n
    b(i)=double(a(i));
end
%Constructing the original decoded file from the 8 bit block file 
%and storing the result in the character array d%
for i=1:n
    c = dec2bin(b(i),8);
    for j=1:8
        d(k)=c(j);
        k=k+1;
    end
end
%Accepting the Huffman Table%
%Enter the table name given at the time of compression 
nme2=input('Enter the table name (Table name entered at compression time) : ','s');
id2 = fopen(nme2,'r');
a2=fscanf(id2,'%c',inf);
fclose(id2);
[m1,n1]=size(a2);
chk=0;
cnt=1;
str='';
temp=0;
%Partiotning the Huffman table into character array and corresponding 
%code array-cd1(character),cd2(code)%
for j=1:n1
    if chk==1 & a2(j)~=' '
        str=strcat(str,a2(j));
        cd2{cnt-1}=str;
    end
        if temp==1 
        cd1(cnt)=a2(j);
        cnt=cnt+1;
        chk=1;
        temp=0;
        str='';
        end
        
        if a2(j)==' '
            temp=1;
            chk=0;
            if j>1
                if a2(j-1)==' ' 
                    chk=1;
                    temp=0;
                    str='';
                end
            end
            
        end
end
%reconstructing original text from huffman code%
[m2,n2]=size(d);
[m3,n3]=size(cd2);
% Enter a file name to deliver the decoded output
nme=input('Enter the file name (to produce output) :','s');
id = fopen(nme,'w+');
comp='';
tap=0;
disp('Decompression starts.........');
for i=1:n2
      cnt=0;  
      z1=d(i);
      m=num2str(z1);
      for j=1:n3          
          k=strcmp(m,cd2(j));
          if(k==1 & tap==0)
              fprintf(id,'%c',cd1(j));
              comp='';
              cnt=1;
          end
       end
       
       if(cnt==0)
            comp=strcat(comp,num2str(z1));
            tap=1;
            for j=1:n3
                m=cd2(j);
                k=strcmp(comp,cd2(j));
                if(k==1)
                    cd1(j);
                    fprintf(id,'%c',cd1(j));
                    comp='';
                    tap=0;
                end
            end
        end   
    end
disp('Decompression Over');
fclose(id);