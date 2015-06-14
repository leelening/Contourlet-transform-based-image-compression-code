// bmp2pgm.cpp : �������̨Ӧ�ó������ڵ㡣
//

#include "stdafx.h"

int convert(char *path)
{
	CImage img;
	char in[1024];
	char out[1024];

	memcpy(in, path, strlen(path) + 1);

	img.Load(in);
//	printf("\r\n");

	if(img.IsNull())
	{
		printf("�ļ���ʧ�ܣ�����ļ�·���� --> %s\r\n\r\n", in);
//		system("pause");
		return 0;
	}

	int w = img.GetWidth();
	int h = img.GetHeight();

	if(w > 0 && h >0)
	{
		int i, j;
		char head[50];
		sprintf(head, "P5\r\n%d %d\r\n255\r\n", w, h);
		
		for(i = strlen(in); i > 0; i--)
		{
			if(in[i] == '.')
			{
				memcpy(out, in, i);
				memcpy(out + i, ".pgm", 5);
				break;
			}
		}

		HFILE hf = _lcreat((LPCSTR)out, 0);
		_lwrite(hf, (LPSTR)head, strlen(head));

		for(i = 0; i < h; i++)
		{
			_lwrite(hf, (LPSTR)(img.GetPixelAddress(0, i)), w);
		}

		_lclose(hf);

//		printf("�����ļ���%s\r\n", in);
		printf("����ļ���%s\r\n", out);
		printf("ͼƬ��С��%d x %d\r\n", w, h);
		printf("PGM Head��%d Bytes\r\n", strlen(head));
		printf("ת���ɹ���\r\n\r\n");
	}

	return 1;
}

int _tmain(int argc, _TCHAR* argv[])
{
	CImage img;
	char path[1024];

	if(argc == 1)
	{
		printf("�ļ�·����");
		scanf("%s", path);
		convert(path);
	}
	else
	{
		int i, j = 0;

		for(i = 1; i < argc; i++)
		{
			printf("�ļ� [%d]��%s\r\n", i, argv[i]);
			j += convert(argv[i]);
		}

		printf("����ת�����ɹ� %d, ʧ�� %d, �ܹ� %d �ļ���\r\n", j, argc - j -1, argc - 1);
	}

	//Sleep(1000);
	system("pause");

	return 0;
}

