
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decoding Function
function image1=Decoding(dict,y)
%
% This function decodes the matrix y into original huffman codes and 
% compose the codes into orginal image.
symbols= (0:255)';

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