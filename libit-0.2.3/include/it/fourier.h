/*
   libit - Library for basic source and channel coding functions
   Copyright (C) 2005-2008 Francois Cayre, Vivien Chappelier, Herve Jegou

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

/*
  1D fourier transform using lifting.
  Copyright (C) 2005-2008 Vivien Chappelier
*/

#ifndef __it_fourier_h
#define __it_fourier_h

#include <it/types.h>
#include <it/mat.h>
#include <it/transform.h>


/*---------------------------------------------------------------------------*/
/*! \defgroup fourrier Fourier Transform                                     */
/* @{                                                                        */
/*---------------------------------------------------------------------------*/

/* Fast Fourier Transform */
cvec it_fft (cvec v);

/* Inverse Fast Fourier Transform */
cvec it_ifft (cvec v);

/* Convolution by FFT */
cvec cvec_fft_conv (cvec a, cvec b);

/* Correlation by FFT */
cvec cvec_fft_corr (cvec a, cvec b);
cvec cvec_fft_autocorr (cvec a);

/* Fast z-transform */
cvec it_fzt (cvec v, cplx z);

/* Fast Discrete Fourier Transform */
cvec it_dft (cvec v);
cvec it_idft (cvec v);
cvec it_dft_real (vec v);
vec  it_idft_real (cvec v);

/* @} */

#endif
