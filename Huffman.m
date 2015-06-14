
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dictionary Function
% function  dict= Dictionary(image_name)
%
% This function is used to create a huffman dictionary 
% (generating huffman code) by using tree search method.

% Read the image file and get the information
disp('Enter the name of image file to create dictionary for huffman code:');
image_name= input('','s');
[image, palette]= imread(image_name);
image= image(:)';

% Create symbols, a 256 X 1 vector, for the gray level of image file
symbols= (0:255)';

% Calculate the probability of each gray level number, to make sure
% every gray level appears at least once, add 1 before calculating the
% probabilities.
times= histc(image(:), 0:255)+ ones(256,1);
prob= times./sum(times);

% Initialization
ptr= [];
p= length(prob); 
tmp= [prob [1:p]'];

% Sort the probablities and combine the lowest two probabilities and then 
% sort again and combine again until only two probabilities left. Also,
% create the pointer table.
for i= 1:p-1,

   [x1,x2]= sort(tmp(:,1));
   sorted= tmp(x2,:);   
   ptr= [ptr;-i sorted(1:2,2)'];
   if i< p-1,
      tmp= [sorted(1,1)+sorted(2,1) ptr(i,1);sorted(3:p-i+1,:)];
   elseif i==p-1,
      tmp= [sorted(1,1)+sorted(2,1) ptr(i,1)];
   end
end

p2=p+p-2;

np=[[[1:p]';[-1:-1:-p+2]'] zeros(p2,2)];
for i=1:p-1, % total p-1 nodes
   for j=2:3,
      for k=1:p2,
        if np(k,1)==ptr(i,j),
              np(k,2) = ptr(i,1);
              np(k,3) = 1-rem(j,2);
        end
      end
   end
end

code=[np(:,3) zeros(p2,p-2)]; 
depth=ones(p2,1);

for i= p2:-1:p+1,  
    for k=1:i-1, 
        if np(k,2)==np(i,1),
            depth(k) = depth(i) + 1; 
            code(k,1:depth(k))=[code(i,1:depth(i)) code(k,1)];
        end
   end
end

% Get the length of the codeword
len_of_code= depth(1:p);

% Convert the format of codeword from matrix into a cell
dmax=max(depth(1:p));

for i= 1:p,
    codeword{i,1}= code(i,1:dmax);
end

% The output is composed of three columns with the 1st one is the level
% of gray; 2nd one is the length of the code and the 3rd one is the code
% for each level.
dict= {symbols,len_of_code,codeword}

disp(' ');

% end    
%
% End of Dictionary Function 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Codes for calculating H(x), L, efficiency and redundancy.
% hx=-prob'*log2(prob);
% l=prob'*dict{1,2};
% u=hx/l;
% r=1-u;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding Function
function y=Encoding(dict,image_name)
%
% This function is used to encode a image into a string of 
% pure "0" and "1"s and save the results into the matrix y.

% Get the information of encoded image file. Two options: encode the image
% file which supplies the dictionary or encode a new image file
disp('Do you want to encode the another image file y/n: ');
reply = input('', 's');

disp(' ');

if reply == 'y'
    disp('Enter the name of new image file you want to open:');
    newimage_name = input ('','s');
    [image, palette] = imread(newimage_name);
    image=image(:)';
end

N=length(image);

% Elements of the dictionary 
% symbols=dict{1,1};
% len_of_code=dict{1,2};
% codeword=dict{1,3};

% Get encoding strings
y=[];

for i=1:N,
    cw=codeword{image(i)+1};
    cw=cw(1:len_of_code(image(i)+1));
    y=[y cw];       
end

%end
%
%End of Encoding Function 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decoding Function
% function image1=Decoding(dict,y)
%
% This function decodes the matrix y into original huffman codes and 
% compose the codes into orginal image.


N=length(y);

% Elements of the dictionary 
% symbols=dict{1,1};
% len_of_code=dict{1,2};
% codeword=dict{1,3};

% Decoding matrix
x=[];

mark=0;

for i= 1:length(symbols),
    coden(i,1:max(len_of_code))= codeword{i,1};
end

[p,dm1]=size(coden);
         
% Get decoding matrix
i=1; d=1;tmp=ones(p,1);

while i<=N,
   tmp=tmp.*[coden(:,d)==y(i)]; 
   if sum(tmp)==1,  
      [isort,idx]=sort(tmp); 
      x=[x idx(p)-1];
      
      mark=1;       
      d=1;          
      tmp=ones(p,1);
      
   elseif d <= dm1
      d=d+1; mark=0;
   end
   i=i+1; 
end

% Reshape the row vector into 256x256 vector
image1=reshape(x,256,256);

%end
%
%End of Decoding Function 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the new image file from the decoded results

disp(' ');

% Enter the name of the decoded image file, usually it should be different
% with the encoded file, or the encoded file will be overwritten.
disp('Enter a name for the decoded image file(the name can not be same');
disp('as your encoded file or the encoded file will be overwriten)');
disp('Suggestion format: originalname_1.bmp');
deimage_name=input('','s');

disp(' ');

% Check the name of decoded file is same as the encoded file or not. 
if reply == 'y'
    compare = strcmp(deimage_name, newimage_name);
    else compare= strcmp(deimage_name, image_name);
end

while compare == 1
    disp('Warning: the output file name is the same as the original one,');
    disp('Do you want to change y/n:');
    reply1 = input('', 's');
    
    disp(' ');    
    
    if reply1 == 'y'
        disp('Enter a name for the decoded image file:');
        deimage_name=input('','s');   
            
            if reply == 'y'
            compare = strcmp(deimage_name, newimage_name);
            else compare= strcmp(deimage_name, image_name);
            end  
     else compare =0;
     end 
end

% Create the decoded image file;
imwrite(image1,palette,deimage_name);

% End of creating the decoded image file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If need to check the encoded file and the decoded file are same or not.
%
% Compare the two matrixes, tf returns to logic 1 means they are equal.
%   image=reshape(image,256,256);
%   tf = isequal(image,image1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%