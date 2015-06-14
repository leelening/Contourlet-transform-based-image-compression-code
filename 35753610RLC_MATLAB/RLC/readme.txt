游程编码解码程序
作者：Genghis_yang
E-mail: yangcheng2503@163.com

使用方法：
Coding(input_file,output_file)函数功能：对二值位图文件进行编码并输出编码后的编码文件。两个参数分别是输入的二值位图文件名和待输出的游程编码文件名，两参数都需要是字符串类型。如：
Coding('color.bmp','rlc.txt')将名为color.bmp的图文件进行游程编码，产生编码文件rlc.txt

Decoding(input_file,output_file)函数功能：对游程编码文件进行解码并输出解码后的图像文件。两个参数分别是输入的编码文件名和待输出的图像文件名，两参数都需要是字符串类型。如：
Decoding('rlc.txt','result.bmp')将编码文件rlc.txt解码成图像result.bmp