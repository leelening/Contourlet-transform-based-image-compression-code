% 游程编码解码程序（编码函数）
% 版权所有(C)2008 Genghis_Yang
% E-mail: yangcheng2503@163.com

function [ output_args ] = Coding( input_file,output_file )
% Coding()函数功能：对二值位图文件进行编码并输出编码后的编码文件
% 两个参数分别是输入的二值位图文件名和待输出的游程编码文件名

binImage=imread(input_file);                        % 打开二值位图并将数据输入矩阵变量binImage
fid=fopen(output_file,'w');                         % 创建编码文件
zero=0;
one=0;
[m,n]=size(binImage);                               % 获得图像尺寸
for i=1:1:m;                                        % 行循环计算
    for j=1:1:n;                                    % 列循环分情况计算
        if ((binImage(i,j)==0) & (zero==0) & (one==0))      % 对应每行起始像素为0的情况
            fprintf(fid,'0 ');
            zero=zero+1;
        elseif ((binImage(i,j)==0) & (one~=0))              % 从1变0，将1的计数值写出
            fprintf(fid,'%d ',one);
            one=0;
            zero=zero+1;
        elseif ((binImage(i,j)==0) & (zero~=0))             % 连续0，增加zero的值
            zero=zero+1;
        elseif ((binImage(i,j)~=0) & (zero~=0))             % 从0变1，将0的计数值写出
            fprintf(fid,'%d ',zero);
            zero=0;
            one=one+1;
        elseif ((binImage(i,j)~=0) & (one~=0))              % 连续1，增加one的值
            one=one+1;
        elseif ((binImage(i,j)~=0) & (zero==0) & (one==0))  % 对应每行起始像素是1的情况
            one=one+1;
        end;
    end;
    if (zero~=0)                                    % 运行到行末，将1或0值写出
        fprintf(fid,'%d',zero);
        fprintf(fid,'\n');
        zero=0;
    elseif(one~=0)
        fprintf(fid,'%d',one);
        fprintf(fid,'\n');
        one=0;
    end;
end;
fclose(fid);