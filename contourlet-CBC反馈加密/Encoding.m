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
