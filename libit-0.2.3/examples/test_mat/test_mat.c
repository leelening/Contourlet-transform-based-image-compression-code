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
  Test program for Matrices
  Copyright (C) 2005 Herve Jegou
*/

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <math.h>
#include <assert.h>
#include <it/io.h>
#include <it/mat.h>
#include <it/linalg.h>

int main ()
{
  int  i, j;
  const int K = 100;
  mat  m1 = mat_new (2, 5);
  mat  m2 = mat_new_alloc (5, 3, 6, 6);
  mat  m3;
  mat  m4 = mat_new (3, 3);
  mat  m5, m6, m7, m8;
  m4[0][0] = 0.3;
  m4[0][1] = 0.2;
  m4[0][2] = 0.5;
  m4[1][0] = 0.1;
  m4[1][1] = 0.1;
  m4[1][2] = 0.8;
  m4[2][0] = 0.7;
  m4[2][1] = 0.2;
  m4[2][2] = 0.1;

  printf
    ("height(m1) = %d\tmaxheight(m1) = %d\nwidth(m1) = %d\tmaxwidth(m1) = %d\n",
     mat_height (m1), mat_height_max (m1), mat_width (m1),
     mat_width_max (m1));

  printf
    ("height(m1) = %d\tmaxheight(m1) = %d\nwidth(m1) = %d\tmaxwidth(m1) = %d\n",
     mat_height (m2), mat_height_max (m2), mat_width (m2),
     mat_width_max (m2));

  mat_set (m1, 5);
  mat_set (m2, 4);

  mat_mul_by (m1, 3);
  mat_decr (m1, 1);

  for (i = 0; i < mat_height (m1); i++) {
    for (j = 0; j < mat_width (m1); j++)
      printf ("%.4f\t", m1[i][j]);
    printf ("\n");
  }
  printf ("\n");


  for (i = 0; i < mat_height_max (m2); i++) {
    for (j = 0; j < mat_width_max (m2); j++)
      printf ("%.4f\t", m2[i][j]);
    printf ("\n");
  }

  m1[1][1] = 7;
  m2[4][2] = -3;

  /* Inverse and display m4 */
  m3 = mat_new_inv (m4);
  it_printf ("\nm4      = \n#.4f\n", m4);
  it_printf ("\ninv(m4) = \n#.6f\n", m3);

  m5 = mat_new_mul (m4, m3);

  /* display Matrices */
  it_printf ("\nm1 = #.4f\n\nm2 = #.4f\n\nm4 * m3 = \n#m\n", m1, m2, m5);

  it_printf ("\nm4 = \n#.6f\n", m4);

  m6 = mat_new_transpose (m4);
  it_printf ("\ntranspose( m4 ) = \n#.6f\n", m6);

  /* Gram-schmidt orthogonalisation */
  mat_gs (m4);
  it_printf ("\ngram_schmidt    : \n#.6f\n", m4);

  /* Normalization of columns */
  mat_cols_normalize (m4, 2);
  it_printf ("\nnormalize       : \n#.6f\n", m4);

  /* Max */
  it_printf ("\nmax             : %f\n", mat_max (m4));

  /* Test inversion of a "large" matrix */
  m7 = mat_new (K, K);
  for (i = 0; i < K; i++)
    for (j = 0; j < K; j++)
      m7[i][j] = pow (0.5, fabs (j - i));

  m8 = mat_new_inv (m7);

  mat_delete (m1);
  mat_delete (m2);
  mat_delete (m3);
  mat_delete (m4);
  mat_delete (m5);
  mat_delete (m6);
  mat_delete (m7);
  mat_delete (m8);
  return 0;
}
