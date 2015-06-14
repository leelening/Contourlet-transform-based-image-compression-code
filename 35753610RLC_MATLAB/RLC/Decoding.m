% 游程编码解码程序（解码函数）
% 版权所有(C)2008 Genghis_Yang
% E-mail: yangcheng2503@163.com

function [ void ] = Decoding( input_file,output_file )
% Decoding()函数功能：对游程编码文件进行解码并输出解码后的图像文件
% 两个参数分别是输入的编码文件名和待输出的图像文件名

fidin=fopen(input_file);

% 计算被编码文件的列数lineLength
lineLength=0;
line=fgetl(fidin);
lineContent=str2num(line);
for lineNum=1:1:length(lineContent)
    lineLength=lineContent(lineNum)+lineLength;
end

% 计算被编码文件的行数rowLength
rowLength=1;
while fgetl(fidin)~=-1
    rowLength=rowLength+1;
end
fclose(fidin);

% 构造一个矩阵用于存放0，1编码数据
outImage=zeros(rowLength,lineLength);
outImage=logical(outImage);

% 定义逻辑型flag变量用来标示将要写入的数据是0还是1
flag=0;

% 读入游程编码文件
fidin=fopen(input_file);

% 行列循环完成解码
for i=1:1:rowLength;
    line=fgetl(fidin);
    lineContent=str2num(line);                      % 将读入的文本内容转化成数
    flag=1;
    j=1;                                            % 变量j用于循环遍历每一列
    for lineNum=1:1:length(lineContent)             % 遍历一行中的游程码
        if lineContent(lineNum)==0                  % 如果编码为0则直接对标志flag置0，这种情况只发生在行首
            flag=0;
            continue
        else
            for num=1:1:lineContent(lineNum)        % 循环写入列元素
                if flag==0
                    outImage(i,j)=0;
                else
                    outImage(i,j)=1;
                end
                j=j+1;
            end
            flag=~flag;
        end
    end
end
fclose(fidin);

% 输出解码后的图象文件
imview(outImage);
imwrite(outImage,output_file);