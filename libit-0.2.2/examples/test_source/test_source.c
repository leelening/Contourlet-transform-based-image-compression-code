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
  Test program for sources functions
  Copyright (C) 2005 Herve Jegou
*/

#include <it/vec.h>
#include <it/io.h>
#include <it/random.h>
#include <it/source.h>
#include <it/source_func.h>

int main ()
{
  int  N = 10000;
  bvec B;
  vec  U;
  vec  pdf;
  ivec S;
  ivec H;
  vec  NH;

  /*  it_randomize(); */

  /* Binary source */
  B = source_binary (20, 0.3);
  it_printf ("B   = $b\n", B);

  /* Uniform source */
  U = source_uniform (20, -1, 2);
  it_printf ("U   = $v\n", U);

  /* Define Maxted and Robinson source */
  pdf = vec_new_string ("0.4 0.2 0.2 0.1 0.1");

  /* Generate a vector of N samples */
  S = source_memoryless (N, pdf);

  /* Process the histogram and the normalized histrograph of this realization */
  H = histogram (vec_length (pdf), S);
  NH = histogram_normalized (vec_length (pdf), S);

  /* Display the results */
  it_printf ("pdf = $v\nH   = $i\nNH  = $v\n", pdf, H, NH);

  vec_delete (pdf);
  vec_delete (NH);
  ivec_delete (S);
  ivec_delete (H);
  vec_delete (U);
  bvec_delete (B);
  return 0;
}
