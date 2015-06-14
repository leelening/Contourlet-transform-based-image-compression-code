% �γ̱��������򣨽��뺯����
% ��Ȩ����(C)2008 Genghis_Yang
% E-mail: yangcheng2503@163.com

function [ void ] = Decoding( input_file,output_file )
% Decoding()�������ܣ����γ̱����ļ����н��벢���������ͼ���ļ�
% ���������ֱ�������ı����ļ����ʹ������ͼ���ļ���

fidin=fopen(input_file);

% ���㱻�����ļ�������lineLength
lineLength=0;
line=fgetl(fidin);
lineContent=str2num(line);
for lineNum=1:1:length(lineContent)
    lineLength=lineContent(lineNum)+lineLength;
end

% ���㱻�����ļ�������rowLength
rowLength=1;
while fgetl(fidin)~=-1
    rowLength=rowLength+1;
end
fclose(fidin);

% ����һ���������ڴ��0��1��������
outImage=zeros(rowLength,lineLength);
outImage=logical(outImage);

% �����߼���flag����������ʾ��Ҫд���������0����1
flag=0;

% �����γ̱����ļ�
fidin=fopen(input_file);

% ����ѭ����ɽ���
for i=1:1:rowLength;
    line=fgetl(fidin);
    lineContent=str2num(line);                      % ��������ı�����ת������
    flag=1;
    j=1;                                            % ����j����ѭ������ÿһ��
    for lineNum=1:1:length(lineContent)             % ����һ���е��γ���
        if lineContent(lineNum)==0                  % �������Ϊ0��ֱ�ӶԱ�־flag��0���������ֻ����������
            flag=0;
            continue
        else
            for num=1:1:lineContent(lineNum)        % ѭ��д����Ԫ��
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

% ���������ͼ���ļ�
imview(outImage);
imwrite(outImage,output_file);