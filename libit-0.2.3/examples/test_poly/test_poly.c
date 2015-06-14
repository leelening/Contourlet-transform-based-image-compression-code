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
/*                Test program for vectors types              */
/*------------------------------------------------------------*/

#include <it/io.h>
#include <it/vec.h>
#include <it/poly.h>

int main ()
{
  vec  P0 = vec_new_string ("1 6 1");	/* 1 + 6X + X^2 */
  vec  P1 = vec_new_string ("4 4");	/* 4 + 4X */
  vec  R;

  pvec V;
  pmat M;

  /* arithmetic */
  R = vec_clone (P0);
  it_printf ("%P + %P = %P\n", P0, P1, poly_add (R, P1));
  vec_copy (R, P0);
  it_printf ("%P - %P = %P\n", P0, P1, poly_sub (R, P1));
  vec_copy (R, P0);
  it_printf ("%P * %P = %P\n", P0, P1, poly_mul (R, P1));
  vec_copy (R, P0);
  it_printf ("%P / %P = %P\n", P0, P1, poly_div (R, P1));
  vec_copy (R, P0);
  it_printf ("%P %% %P = %P\n", P0, P1, poly_mod (R, P1));
  vec_copy (R, P0);
  it_printf ("gcd(%P, %P) = %P\n", P0, P1, poly_gcd (R, P1));
  vec_delete (R);

  /* evaluation */
  it_printf ("%P(1.5) = %f\n", P0, poly_eval (P0, 1.5));

  /* vector and matrices */
  V = pvec_new (2);
  M = pmat_new (2, 2);
  V[0] = P0;
  V[1] = P1;
  M[0][0] = P0;
  M[0][1] = P1;
  M[1][0] = P1;
  M[1][1] = P0;
  it_printf ("V = $P\n", V);
  it_printf ("M = #P\n", M);

  return 0;
}
