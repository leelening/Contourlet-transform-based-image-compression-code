#include "mex.h"

void unravel(unsigned short *hx, double *link, double *x, double xsz, int hxsz)
{
	int i =15, j = 0, k = 0, n = 0;

	while (xsz - k) {
		if (*(link+ n) > 0) {
			if ((*(hx + j) >> i) & 0x0001)
				n = *(link + n);
			else n = *(link + n) - 1;
			if (i) i--; else {j++; i = 15;}
			if (j > hxsz)
				mexErrMsgTxt("Out of code bits ???");
		}
		else {
			*(x + k++) = -*(link + n);
			n = 0; }
	}
	if (k == xsz - 1)
		*(x + k++) = -*(link + n);
}

void mexFunction(int nlhs, mxArray *plhs[],
				 int nrhs, const mxArray *prhs[])
{
	double *link, *x, xsz;
	unsigned short *hx;
	int hxsz;
	if (nrhs != 3)
		mexErrMsgTxt("Three inputs required.");
	else if (nlhs > 1)
		mexErrMsgTxt("Too many output argument.");
	if (!mxIsDouble(prhs[2]) || mxIsComplex(prhs[2]) || mxGetN(prhs[2]) * mxGetM(prhs[2]) != 1)
		mexErrMsgTxt("Input XSIZE must be a scalar.");
	hx = mxGetPr(prhs[0]);
	link = mxGetPr(prhs[1]);
	xsz = mxGetScalar(prhs[2]);
	hxsz = mxGetM(prhs[0]);
	plhs[0] = mxCreateDoubleMatrix(xsz, 1, mxREAL);
	x = mxGetPr(plhs[0]);
	unravel(hx, link, x, xsz, hxsz);
}

