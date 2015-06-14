#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <sys/types.h>
#include<iostream>
#pragma pack(2)

using namespace std;

#define N 16
#define e 0.05
#define BYTE unsigned char
#define WORD u_int16_t
#define DWORD u_int32_t
//typedef unsigned char BYTE;
//typedef u_int16_t WORD;
//typedef u_int32_t DWORD;

typedef struct BITMAPFILEHEADER  
{   
	WORD bfType; //数据地址为 0 - "BM"  
	DWORD bfSize; //DA 2 - 定义文件大小，字节为单位  
	WORD bfReserved1;   //DA 6 - 文件保留字 0
	WORD bfReserved2;   //DA 8 - 文件保留字 0
	DWORD bfOffBits;   //DA 10 - 图像数据指针对文件头的偏移量
}BITMAPFILEHEADER;

typedef struct BITMAPINFOHEADER  
{   
	DWORD biSize;   //DA14 BITMAPPINFOHEADER存储容量 固定值为40
	DWORD biWidth;   //DA 18
	DWORD biHeight;   //DA 22 像素为单位，文件所描述的位图的高度和宽度
	WORD biPlanes;   //DA 26 目标设备的平面数 必须为1
	WORD biBitCount;   //DA 28 确定每个像素需要的位数 单色-1 16色-14 256-8 真彩-24
	DWORD biCompression;  //DA 30 压缩类型是否与进行了什么压缩 
	DWORD biSizeImage;   //DA 34 图像数据所占用的空间大小，若上面30-BI-RGB 则该字段必须为0
	DWORD biXPelsPerMeter;   //DA 38
	DWORD biYPelsPerMeter;   //DA 42 分辨率
	DWORD biClrUsed;   //DA 46 颜色变址数
	DWORD biClrImportant;  //DA 50 重要颜色变址数 
}BITMAPINFODEADER; 

typedef struct tagRGBQUAD{
	BYTE rgbBlue;
	BYTE rgbGreen;
	BYTE rgbRed;
	BYTE rgbReserved;
}RGBQUAD;

class bmpreader{
public:
	BITMAPFILEHEADER head;
	BITMAPINFODEADER info;
	RGBQUAD colors;
	int picH,picW,csize;
	int Bnum;
	BYTE *PicS;
	bmpreader(char *picaddr);
	void showRgbtag(RGBQUAD &colors);
	void showBmpHead(BITMAPFILEHEADER &pBmpHead);
	void showBmpInforHead(BITMAPINFODEADER &pBmpInforHead);
};

void bmpreader::showRgbtag(RGBQUAD &colors){
		cout<<"Blue:"<<colors.rgbBlue<<endl;
		cout<<"Green:"<<colors.rgbGreen<<endl;
		cout<<"Red:"<<colors.rgbRed<<endl;
}

void bmpreader::showBmpHead(BITMAPFILEHEADER &pBmpHead){    
    	cout<<endl<<"位图文件头:"<<endl;    
    	//cout<<"文件头类型:"<<pBmpHead.bfType<<endl;    
    	cout<<"文件大小:"<<pBmpHead.bfSize<<endl;    
    	//cout<<"保留字_1:"<<pBmpHead.bfReserved1<<endl;    
    	//cout<<"保留字_2:"<<pBmpHead.bfReserved2<<endl;    
    	cout<<"实际位图数据的偏移字节数:"<<pBmpHead.bfOffBits<<endl<<endl;    
}    
                                                          
void bmpreader::showBmpInforHead(BITMAPINFODEADER &pBmpInforHead){    
    	cout<<"位图信息头:"<<endl;    
    	//cout<<"结构体的长度:"<<pBmpInforHead.biSize<<endl;    
    	cout<<"位图宽:"<<pBmpInforHead.biWidth<<endl;    
	cout<<"位图高:"<<pBmpInforHead.biHeight<<endl;    
	//cout<<"biPlanes平面数:"<<pBmpInforHead.biPlanes<<endl;    
	cout<<"biBitCount采用颜色位数:"<<pBmpInforHead.biBitCount<<endl;    
	//cout<<"压缩方式:"<<pBmpInforHead.biCompression<<endl;    
	cout<<"biSizeImage实际位图数据占用的字节数:"<<pBmpInforHead.biSizeImage<<endl;    
	//cout<<"X方向分辨率:"<<pBmpInforHead.biXPelsPerMeter<<endl;    
	//cout<<"Y方向分辨率:"<<pBmpInforHead.biYPelsPerMeter<<endl;    
	//cout<<"使用的颜色数:"<<pBmpInforHead.biClrUsed<<endl;    
	//cout<<"重要颜色数:"<<pBmpInforHead.biClrImportant<<endl;    
}

bmpreader::bmpreader(char *picaddr){
	FILE *fp = fopen(picaddr, "rb");  	
	int palesize = 0;
	fread(&head,sizeof(BITMAPFILEHEADER),1,fp);  
	fread(&info,sizeof(BITMAPINFODEADER),1,fp);  
	switch(info.biBitCount){
	    case 1:
		palesize = 2;
		break;
	    case 4:
		palesize = 16;
		break;
	    case 8:
		palesize = 256;
		break;
	}
	
	showBmpHead(head);  
	showBmpInforHead(info);  
	//showRgbtag(colors);
	if(palesize){
	    	cout<<"存在RGBQUAD.."<<endl;
		fread(&colors,1,palesize*sizeof(RGBQUAD),fp);
	}else{
		cout<<"不存在RGBQUAD.."<<endl;
	}
	int PicData = info.biSizeImage;
	if(!palesize){
		int tempsize = info.biBitCount/8;
		tempsize = tempsize*64;
		if(PicData%tempsize){
			PicData = PicData + (tempsize-PicData%tempsize);
		}
		Bnum = PicData/tempsize;
	}else{
		if(PicData%64){
			PicData = PicData + PicData%64;
		}	
		Bnum = PicData/64;
	}
        //PicS = (char*)malloc(PicData);
	csize = PicData;
	picH = info.biHeight;
	picW = info.biWidth;
	PicS = (unsigned char*)new unsigned char[PicData];
	memset(PicS,0,PicData);
	fread(PicS,1,info.biSizeImage,fp);
	if(feof(fp) == 0)
	    cout<<endl<<"All PicData Are In.."<<endl;
	fclose(fp);  
}


/*void Xprod(char *k,float *pk);//根据输入的序列产生最早的x0
void NKProd(float *pk,float *nk,int times);//初始迭代times次，消除初始影响
float f(float xi,float x);//局部混沌函数
void RLProd(float *pk,float *nk,char *RL);//正常迭代，每次产生64字节随机序列
void RLSplit(float *nk,char *RL,int i,int j);//取位函数*/
