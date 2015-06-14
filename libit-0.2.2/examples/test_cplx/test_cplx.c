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

/*------------------------------------------------------------*/
/*             Test program for vectors types                 */
/*------------------------------------------------------------*/

#include <it/cplx.h>
#include <it/vec.h>
#include <it/io.h>

int main ()
{
  cplx a = cplx (1.5, 2.5), b = cplx (1.7, 2.1), c;
  cvec C;

  cimag (b) = 5.5;

  it_printf ("a       = %z\n", a);
  it_printf ("b       = %z\n", b);
  it_printf ("a+b     = %z\n", cadd (a, b));
  c = cmul (a, b);
  it_printf ("a*b     = %z\n", c);
  it_printf ("a*b     = %z\n", cplx_I);
  it_printf ("(a*b)/b = %z\n", cdiv (c, b));
  it_printf ("conj(a) = %z\n", cconj (a));
  it_printf ("cmod(a) = %f\n", cnorm (a));

  C = cvec_new (6);
  C[0] = a;
  C[1] = b;
  C[2] = c;
  C[3] = cplx_I;
  C[4] = cplx_0;
  C[5] = cplx_1;
  it_printf ("C       = $z\n", C);
  cvec_mul_by_real (C, 2);
  it_printf ("2*C     = $z\n", C);

  return 0;
}
