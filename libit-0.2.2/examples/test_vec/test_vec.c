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

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <math.h>
#include <assert.h>
#include <it/vec.h>
#include <it/io.h>

int main ()
{
  vec  v0, v1, v2, v3, v4, v5, v6, v7, vs;
  ivec v8, uv8, v9, uv8v9, iv8v9, v10, v11;
  int  j;

  /* Alloc a vector and set all elements to 9                                */
  v0 = vec_new (10);
  vec_set (v0, 9);

  /* Alloc a vector with elements initialized to zero                        */
  v1 = vec_new_zeros (10);
  v1[5] = 5;
  _vec (v1, 5) = 5;		/* same thing with type and bound checking */

  /* Constructions with various functions (allocation processed in the function) */
  v2 = vec_new_ones (5);
  v3 = vec_new_arithm (1, -2, 15);
  v4 = vec_new_geom (1, 2, 8);

  /* Generic function test     */
  v5 = vec_new (8);
  vec_1N (v5);
  //  vec_eval(v5, IT_FUNCTION(tan), NULL );

  v6 = vec_new (15);
  v7 = v5;

  /* Process various operations on vectors    */
  it_printf
    ("Length(v1) = %d\nv0=$v\nv1=$.3v\nv2=$.3v\nv3=$.3v\nv4=$.3v\nv5=$.3v\nMax( v5 ) = %g\nMin( v5 ) = %g\nMean( v5 ) = %g\nSum( v5 ) = %g\nSumSqr( v5 ) = %g\nNorm(v,2) = %g\n",
     Vec_length (v1), v0, v1, v2, v3, v4, v5, vec_max (v7),
     vec_min (v7), vec_mean (v7), vec_sum (v7), vec_sum_sqr (v7),
     vec_norm (v7, 2));

  /* Sort a vector and retrieve the permutation corresponding to this sorting */
  v8 = vec_sort_index (v7);
  vec_sort (v7);
  it_printf ("v7=$.2f (max_length = %d)\nv8=$d\n",
	     v7, vec_length_max (v7), v8);

  /* Set operations             */
  vec_del (v7, 0);
  ivec_del (v8, 5);
  vec_pop (v7);
  ivec_pop (v8);

  it_printf ("v7=$.3v (max_length = %d)\nv8=$i\n\n",
	     v7, vec_length_max (v7), v8);

  vs = vec_cum_sum (v7);
  it_printf ("cum_sum(v7)=$.3v\n\n", vs);

  /* Now test vectors as stack  */

  it_printf ("v7=$.3v (max_length = %d)\nv8=$d\n\n",
	     v7, vec_length_max (v7), v8);

  printf ("Modification of the vector max length\n");
  fflush (stdout);
  Vec_set_length_max (v7, 9);
  Vec_set_length_max (v8, 7);

  it_printf ("v7=$.3v (max_length = %d)\nv8=$d (max_length = %d)\n\n",
	     v7, vec_length_max (v7), v8, ivec_length_max (v8));

  for (j = 1; j < 8; j++) {
    vec_push (v7, j * 1.2);
    ivec_push (v8, j);

    it_printf ("v7=$g (max_length = %d)\nv8=$d (max_length = %d)\n\n",
	       v7, vec_length_max (v7), v8, ivec_length_max (v8));
  }

  v9 = ivec_new_string ("4 1 9 4");
  uv8 = ivec_new_unique (v8);
  it_printf ("Unique( v8 ) = $d\n", uv8);

  ivec_sort (v8);
  it_printf ("Sort( v8 ) = $d\n\n", v8);

  it_printf ("v8 = $d\n", v8);
  it_printf ("v9 = $d\n", v9);

  uv8v9 = ivec_new_union (v8, v9);
  iv8v9 = ivec_new_intersection (v8, v9);
  it_printf ("Union(v8,v9) = $d\n", uv8v9);
  it_printf ("Inter(v8,v9) = $d\n", iv8v9);

  printf ("Median( Union(v8,v9) ) = %d\n\n", ivec_median (uv8v9));

  /* Compute the maximum and their index */
  it_printf ("v8=$d\n", v8);
  v10 = ivec_k_max (v8, 5);
  v11 = ivec_k_max_index_between (v8, 5, 0, ivec_length (v8) - 1);
  it_printf ("v10=$d\nv11=$d\n\n", v10, v11);

  /* Free the memory associated with the vectors */
  vec_delete (v0);
  vec_delete (v1);
  vec_delete (v2);
  vec_delete (v3);
  vec_delete (v4);
  vec_delete (v6);
  vec_delete (v7);
  vec_delete (vs);
  ivec_delete (v8);
  ivec_delete (uv8);
  ivec_delete (v9);
  ivec_delete (uv8v9);
  ivec_delete (iv8v9);
  ivec_delete (v10);
  ivec_delete (v11);

  return 0;
}
