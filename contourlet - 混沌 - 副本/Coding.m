% �γ̱��������򣨱��뺯����
% ��Ȩ����(C)2008 Genghis_Yang
% E-mail: yangcheng2503@163.com

function [ output_args ] = Coding( input_file,output_file )
% Coding()�������ܣ��Զ�ֵλͼ�ļ����б��벢��������ı����ļ�
% ���������ֱ�������Ķ�ֵλͼ�ļ����ʹ�������γ̱����ļ���

binImage=imread(input_file);                        % �򿪶�ֵλͼ������������������binImage
fid=fopen(output_file,'w');                         % ���������ļ�
zero=0;
one=0;
[m,n]=size(binImage);                               % ���ͼ��ߴ�
for i=1:1:m;                                        % ��ѭ������
    for j=1:1:n;                                    % ��ѭ�����������
        if ((binImage(i,j)==0) & (zero==0) & (one==0))      % ��Ӧÿ����ʼ����Ϊ0�����
            fprintf(fid,'0 ');
            zero=zero+1;
        elseif ((binImage(i,j)==0) & (one~=0))              % ��1��0����1�ļ���ֵд��
            fprintf(fid,'%d ',one);
            one=0;
            zero=zero+1;
        elseif ((binImage(i,j)==0) & (zero~=0))             % ����0������zero��ֵ
            zero=zero+1;
        elseif ((binImage(i,j)~=0) & (zero~=0))             % ��0��1����0�ļ���ֵд��
            fprintf(fid,'%d ',zero);
            zero=0;
            one=one+1;
        elseif ((binImage(i,j)~=0) & (one~=0))              % ����1������one��ֵ
            one=one+1;
        elseif ((binImage(i,j)~=0) & (zero==0) & (one==0))  % ��Ӧÿ����ʼ������1�����
            one=one+1;
        end;
    end;
    if (zero~=0)                                    % ���е���ĩ����1��0ֵд��
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