#include "repic.h"

void Xprod(BYTE k[16],float pk[16]){
	for(int i = 0;i < 16;i++){
	    pk[i] = ((int)k[i]+0.1)/256;
	}
}

void Arrydisplay(float arr[16]){
	for(int i = 0;i<16;i++){
		cout<<i<<"-:-"<<arr[i]<<"  ";
	}
	cout<<endl;
}
float f(float xi,float x){
	float y;
	y = 8*xi*xi*xi*xi - 8*xi*xi + 1;//大于一定次数后，产生的K值一定。。果然要用俩方程么。。。
	if(y < 0)
	    y =-y;
	//y = 3.9999 * xi * ( 1 - xi);
	return y;	
}

void NKProd(float pk[16],float nk[16],float xinput,int times){
	for(int i = 0;i < times;i++){
		for(int j = 0;j < 16;j++){
			nk[j] = (1 - e) * f(pk[j],xinput) + e * f(pk[(j+1)%16],xinput);
		}
		for(int k = 0;k<16;k++)
		    pk[k] = nk[k];
	}
}

void RLSplit(float nk,WORD tempL[16],int j){
	int y;
	memcpy(&y,&nk,4);
	y = y&0x00ffff00;
	unsigned int tk;
	memcpy(&tk,&y,4);
	tk = tk>>8;
	memcpy(&tempL[j],&tk,2);
}

WORD F(WORD a,WORD b,WORD c,WORD d){
	WORD tempx;
	tempx = (((a&b)|((~a)&c))+d)%256;
	return tempx;
}
WORD G(WORD a,WORD b,WORD c,WORD d){
	WORD tempx;
	tempx = (((a&c)|((~c)&b))+d)%256;
	return tempx;
}
WORD H(WORD a,WORD b,WORD c,WORD d){
	WORD tempx;
	tempx = ((a^b^c)+d)%256;
	return tempx;
}
WORD I(WORD a,WORD b,WORD c,WORD d){
	WORD tempx;
	tempx = ((b^(a|(~c)))+d)%256;
	return tempx;
}


void SLProd(WORD tempL[16],WORD tmpL[16]){
	for(int i = 0;i < 4;i++){
		tmpL[(4*i)%16] = F(tempL[(4*i)%16],tempL[(4*i+1)%16],tempL[(4*i+2)%16],tempL[(4*i+3)%16]);
		tmpL[(4*i+1)%16] = G(tempL[(4*i+1)%16],tempL[(4*i+2)%16],tempL[(4*i+3)%16],tempL[(4*i)%16]);
		tmpL[(4*i+2)%16] = H(tempL[(4*i+2)%16],tempL[(4*i+3)%16],tempL[(4*i)%16],tempL[(4*i+1)%16]);
		tmpL[(4*i+3)%16] = I(tempL[(4*i+3)%16],tempL[(4*i)%16],tempL[(4*i+1)%16],tempL[(4*i+2)%16]);
	}	
}

void RLSave(int i,WORD tempL[16],BYTE *RL/*[192]*/){
    	WORD tpk;
	for(int k = 0;k < 16;k++){
		//RL[16*i+k] = tempL[k]&0x00ff;
		tpk = tempL[k]&0x00ff;
		memcpy(&RL[16*i+k],&tpk,2);
	}	
}

void RLProd(float pk[16],float nk[16],BYTE *RL/*[192]*/,int eachtime,float xinput){
    	WORD tempL[16];
	WORD tmpL[16];
	for(int i = 0;i < eachtime/16 ;i++){
		for(int j = 0;j < 16;j++){
			nk[j] = (1 - e) * f(pk[j],xinput) + e * f(pk[(j+1)%16],xinput);
			RLSplit(nk[j],tempL,j);
		}
		SLProd(tempL,tmpL);
		RLSave(i,tmpL,RL);
		memset(tempL,0,16*sizeof(WORD));
		for(int k = 0;k<16;k++)
		    pk[k] = nk[k];
	}
}

BYTE cycR(BYTE a,BYTE b){
    a = (a<<(8 - b))|(a>>b);
    return a;
}

BYTE LSB(BYTE c){
	BYTE tc = c & 0x07;
	return tc;
}


int main( int argc, char **argv )  
{  
	bmpreader pict(argv[1]);//实例一个bmp读取类，获得相应的信息头和像素数据，并根据不同大小的像素位进行填充图像
	float Xinput = 0.723812;//方程还是先选用Logistic方程，至少还是决定用一个方程的时候,输入K获得x[0](i)即16个盒子的初始值
	BYTE KeyInput[16];//输入的密钥，传送走的密钥
	float pk[16];//迭代前的各个盒子值
	float nk[16];//迭代后的各个盒子值
	int picH = pict.picH;
	int picW = pict.picW;//原始图的高宽
	int picS = pict.csize;//填充后的整体大小
	unsigned char picG;//可能的灰度值，整体的
	int KL;//置换中的对比值
	int r;
	int bnum = pict.Bnum;//分块数
	int eachtime = picS/bnum;
	printf("Each Block = %d 字节\n",eachtime);
	BYTE cpics[picS];//加密后
	memset(cpics,0,picS);
	BYTE RL[eachtime];//每次的随机序列
	memset(RL,0,eachtime);
	//cout<<"please input a key float x ..(0.123456 for example.)"<<endl;
	//cin>>Xinput;
	cout<<"Please input the Keyline...(16byte-128bit)"<<endl;
	cout<<"1234567890123456<-Here the ending is.."<<endl;
	cin>>KeyInput;
	picG = 0xff;
	//cout<<"Please input the PicGreyvalue"<<endl;
	//cin>>picG;
	//printf("PicGrayValue is %d \n",picG);
	//获得x初始盒子，迭代times次，消除。。
	Xprod(KeyInput,pk);
	NKProd(pk,nk,Xinput,50);

	//计算KL等信息
	KL = (KeyInput[0]^KeyInput[1]^KeyInput[2]^KeyInput[3]^KeyInput[4]^KeyInput[5]^KeyInput[6]^KeyInput[7]^KeyInput[8]^KeyInput[9]^KeyInput[10]^KeyInput[11]^KeyInput[12]^KeyInput[13]^KeyInput[14]^KeyInput[15])*pict.Bnum/256;
	r = (KeyInput[8]+KeyInput[9]+KeyInput[10]+KeyInput[11]+KeyInput[12]+KeyInput[13]+KeyInput[14]+KeyInput[15])%pict.csize;

	//产生一块用的随机序列～
	RLProd(pk,nk,RL,eachtime,Xinput);
	//正常序列产生和循环移位与取位函数测试输出
	/*RLProd(pk,nk,RL,eachtime,Xinput);
	for(int s = 0;s <eachtime;s++){
		printf("%x\t",RL[s]);
		if((s%10 == 0)&&(s!=0))
		    printf("\n");
	}
	printf("\n");*/
	
	BYTE LCL[24];
	BYTE picheck[bnum];
	BYTE BK[eachtime];
	BYTE CK[eachtime];
	BYTE RSL,RSR;
	int Knew;
	int d,tx;
	memset(picheck,0,bnum);
	memcpy(LCL,KeyInput+8,8);
	memcpy(LCL+8,KeyInput+8,8);
	memcpy(LCL+16,KeyInput+8,8);
	for(int k = 0;k < bnum ; k++){
	    	Knew = (int)(nk[0]*bnum);
		if(k != bnum-1){
		while((Knew == KL)|(picheck[Knew]!=0))
			Knew = (Knew + 1)%bnum;
		//cout<<Knew<<"  ";
		memcpy(CK,pict.PicS+eachtime*Knew,eachtime);
		picheck[Knew] = 1;
		}else{
			memcpy(CK,pict.PicS+eachtime*KL,eachtime);
			picheck[KL] = 1;
		}
		for(int i = 0 ; i < 8 ; i ++){
			for(int j = 0 ; j < 8 ; j++){
				for(int n = 0 ; n < 3 ; n++){
					/*RSR = LSB(LCL[3*((j-1)%8)+n]^RL[3*(8*i+j)+n]);
					RSL = cycR(CK[3*(8*i+j)+n],RSR);
					BK[3*(8*i+j)+n] = RL[3*(8*i+j)+n]^(RSL-LCL[3*j+n]+picG)%picG;*/
				    	//BK[3*(8*i+j)+n] = RL[3*(8*i+j)+n]^CK[3*(8*i+j)+n];
					RSR = LSB(LCL[3*j+n]);
					RSL = CK[3*(8*i+j)+n]^RL[3*(8*i+j)+n];
					BK[3*(8*i+j)+n] = cycR(RSL,RSR);
				}
			}
			memcpy(LCL,CK+8*i,24);
		}
		memcpy(cpics+eachtime*k,BK,eachtime);
		/*d = LSB(LCL[0]);
		//cout<<d<<"  ";
		for(int y = 0 ; y < 4 ; y ++){
			if(LCL[y]>LCL[(y+d)%8]){
				tx = nk[y];
				nk[y] = nk[(y+d)%8];
				nk[(y+d)%8] = tx;	
			}
		}*/
		for(int m=0 ; m<16 ; m++)
		    pk[m] = nk[m];
		RLProd(pk,nk,RL,eachtime,Xinput);
		//Arrydisplay(nk);
	}

	picS = picH*picW*3;
	pict.info.biSizeImage = picS;
	pict.head.bfSize = picS + 54;
	char repicname[20];
	memset(repicname,0,20);
	cout<<"Please Input the RePic name...(End with .bmp)"<<endl;
	cin>>repicname;
	FILE *rfp = fopen(repicname,"wb");
	fwrite(&pict.head,1,14,rfp);
	fwrite(&pict.info,1,40,rfp);
	fwrite(cpics,1,picS,rfp);
	fclose(rfp);
	cout<<"解密后的明文图像为"<<repicname<<endl;
	return 0;  
}
