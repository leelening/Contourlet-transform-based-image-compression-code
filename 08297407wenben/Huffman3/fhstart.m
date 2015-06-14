%Hufman coding algorithm
%Author : Jeny Rajan
% Total program is divided into three modules
% (1) Histogram building & Probability calculation (fhstart.m)
% (2) Huffman Tree drawing phase(fhtree1.m)
% (3) Huffman Code generating module(fhcode.m)

%%%% USAGE %%%%%%%
% Run the program fhstart.m
% The filename entered should be a Text file

clc;
clear all;
k=input('Enter the file name :','s');
fid = fopen(k,'r');
F = fread(fid);
img = char(F');
mx=255;
[x y z]=size(img);
h(1:mx)=0;
disp('Histogram building phase started....');
for i=1:y
        iy=img(i);
        val=double(iy);
        h(val)=h(val)+1;
    end
%end
disp('Probability calculating phase started...');
i=1:mx
p(i)=h(i)/(x*y);
j=1;
for i=1:mx
        if(p(i)~=0)
         lst(j)=i;
         lst(j+1)=p(i);
         j=j+2;
        end
 end
[tt,mx]=size(lst);
disp('sorting phase started....');
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
disp('Building Huffman Tree.....');
fhtree1(lst,img);