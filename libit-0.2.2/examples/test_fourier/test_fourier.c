/*
   libit - Library for basic source and channel coding functions
   Copyright (C) 2005-2005 Vivien Chappelier, Herve Jegou

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
  Test program for the Fourier transform
  Copyright (C) 2005 Vivien Chappelier
*/

#include <it/io.h>
#include <it/mat.h>
#include <it/transform.h>
#include <it/fourier.h>

int cvec_eq_tol (cvec v1, cvec v2, double tol)
{
  idx_t i;
  assert (v1);
  assert (v2);

  if (cvec_length (v1) != cvec_length (v2))
    return 0;

  for (i = 0; i < cvec_length (v1); i++)
    if (cnorm (csub (v1[i], v2[i])) > tol)
      return 0;
  return 1;
}

//#define FFT_TIMING
//#define DFT_TIMING

int main ()
{
  cvec v, r1, r2;
  cvec vt;
  vec  a;
  cplx z;

#ifdef FFT_TIMING
  cvec t = cvec_new_range (8 * 1024 * 1024);
  vt = it_fft (t);
  cvec_delete (vt);
  return 0;
#endif

#ifdef DFT_TIMING
  int  i;
  cvec t = cvec_new_range (15);
  for (i = 0; i < 1000000; i++) {
    vt = it_dft (t);
    cvec_delete (vt);
  }
  return 0;
#endif

  /* -- real vector -- */
  v = cvec_new_string ("1 2 3");
  a = vec_new_string ("1 2 3");
  z.r = 0.5;
  z.i = 1.0;
  it_printf ("z = %z rho = %f theta = %f\n", z, cnorm (z), cang (z));
  vt = it_fzt (v, z);
  it_printf ("vt[fzt] = $.04z\n", vt);
  cvec_delete (vt);

  vt = it_dft (v);
  it_printf ("vt[dft] = $.04z\n", vt);
  cvec_delete (vt);

  vt = it_dft_real (a);
  it_printf ("vt[dft_real] = $.04z\n", vt);


  v = it_idft (vt);
  it_printf ("v[idft] = $.04z\n", v);

  a = it_idft_real (vt);
  it_printf ("a[idft_real] = $.04f\n", a);
  cvec_delete (vt);
  cvec_delete (v);
  vec_delete (a);

  /* -- complex vector -- */
  v = cvec_new_string ("1+0.5i 2-0.5i 3+0.25i 4-0.25i 5");
  it_printf ("v = $z\n", v);

  /* Transform the vector */
  vt = it_dft (v);
  cvec_delete (v);
  it_printf ("vt = $.04z\n", vt);

  /* Reconstruct the vector */
  v = it_idft (vt);
  cvec_delete (vt);
  it_printf ("v = $.04z\n", v);

  a = vec_new_1N (8);
  v = vec_to_cvec (a);
  it_printf ("v = $.04z\n", v);

  /* Transform the vector */
  vt = it_dft (v);
  cvec_delete (v);
  it_printf ("vt = $.04z\n", vt);

  /* Reconstruct the vector */
  v = it_idft (vt);
  cvec_delete (vt);
  it_printf ("v = $.04z\n", v);

  /* Transform the vector */
  /*  vt = __it_dft_real_fast(a); */
  /*  it_printf("vt = $z\n", vt); */

  vec_delete (a);


  /* -- convolution and correlation by FFT -- */
  r1 = cvec_new_string ("1 1 1");
  r2 = cvec_new_string ("2 2 2");
  vt = cvec_fft_conv (r1, r2);

  it_printf ("fft_conv($z,$z) = $z\n", r1, r2, vt);
  cvec_delete (vt);
  vt = cvec_fft_corr (r1, r2);
  it_printf ("fft_corr($z,$z) = $z\n", r1, r2, vt);
  cvec_delete (vt);
  vt = cvec_fft_autocorr (r1);
  it_printf ("fft_autocorr($z) = $z\n", r1, vt);
  cvec_delete (vt);

  return 0;
}
