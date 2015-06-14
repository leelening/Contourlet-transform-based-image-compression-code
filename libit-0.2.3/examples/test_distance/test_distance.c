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
/*            Test program for distances                      */
/*------------------------------------------------------------*/

#include <it/vec.h>
#include <it/io.h>
#include <it/distance.h>

int main ()
{
  int  i, j;

  int  dh[5][5];
  int  dl[3][3];

  /* Initialisation of some vector */
  vec  v1 = vec_new_arithm (1.1, 1.1, 7);
  vec  v2 = vec_new_arithm (0, 1.1, 8);
  vec  v3 = vec_clone (v2);
  vec  v4 = vec_clone (v1);
  vec  v5 = vec_clone (v2);

  ivec iv1 = ivec_new_geom (1, 2, 8);
  ivec iv2 = ivec_new_ones (4);
  ivec iv3 = ivec_new (5);

  v3[2] = 3;
  v3[5] = 7;
  v4[2] = 2.3;
  v4[6] = -3;
  v5[0] = 1.1;
  v5[2] = 2.3;
  v5[6] = -3;

  // it_set_vec_default_fmt( "%8.3" );

  it_printf ("v1 = $v\nv2 = $v\nv3 = $v\nv4 = $v\nv5 = $v\n\n", v1, v2, v3,
	     v4, v5);

  ivec_set (iv3, 7);

  it_printf ("iv1=$d\niv2=$d\niv3=$d\n\n", iv1, iv2, iv3);

  /* Process distance between vectors */
  dh[0][0] = vec_distance_hamming (v1, v1);
  dh[0][1] = vec_distance_hamming (v1, v2);
  dh[0][2] = vec_distance_hamming (v1, v3);
  dh[0][3] = vec_distance_hamming (v1, v4);
  dh[0][4] = vec_distance_hamming (v1, v5);

  dh[1][0] = vec_distance_hamming (v2, v1);
  dh[1][1] = vec_distance_hamming (v2, v2);
  dh[1][2] = vec_distance_hamming (v2, v3);
  dh[1][3] = vec_distance_hamming (v2, v4);
  dh[1][4] = vec_distance_hamming (v2, v5);

  dh[2][0] = vec_distance_hamming (v3, v1);
  dh[2][1] = vec_distance_hamming (v3, v2);
  dh[2][2] = vec_distance_hamming (v3, v3);
  dh[2][3] = vec_distance_hamming (v3, v4);
  dh[2][4] = vec_distance_hamming (v3, v5);

  dh[3][0] = vec_distance_hamming (v4, v1);
  dh[3][1] = vec_distance_hamming (v4, v2);
  dh[3][2] = vec_distance_hamming (v4, v3);
  dh[3][3] = vec_distance_hamming (v4, v4);
  dh[3][4] = vec_distance_hamming (v4, v5);

  dh[4][0] = vec_distance_hamming (v5, v1);
  dh[4][1] = vec_distance_hamming (v5, v2);
  dh[4][2] = vec_distance_hamming (v5, v3);
  dh[4][3] = vec_distance_hamming (v5, v4);
  dh[4][4] = vec_distance_hamming (v5, v5);

  dl[0][0] = ivec_distance_levenshtein (iv1, iv1, 1, 1, 1);
  dl[0][1] = ivec_distance_levenshtein (iv1, iv2, 1, 1, 1);
  dl[0][2] = ivec_distance_levenshtein (iv1, iv3, 1, 1, 1);

  dl[1][0] = ivec_distance_levenshtein (iv2, iv1, 1, 1, 1);
  dl[1][1] = ivec_distance_levenshtein (iv2, iv2, 1, 1, 1);
  dl[1][2] = ivec_distance_levenshtein (iv2, iv3, 1, 1, 1);

  dl[2][0] = ivec_distance_levenshtein (iv3, iv1, 1, 1, 1);
  dl[2][1] = ivec_distance_levenshtein (iv3, iv2, 1, 1, 1);
  dl[2][2] = ivec_distance_levenshtein (iv3, iv3, 1, 1, 1);


  for (i = 0; i < 5; i++) {
    for (j = 0; j < 5; j++) {
      printf ("%5d\t", dh[i][j]);
    }
    printf ("\n");
  }

  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      printf ("%5d\t", dl[i][j]);
    }
    printf ("\n");
  }


  it_printf ("vec_distance_mse(v2,v3) = %f\n", vec_distance_mse (v2, v3, 0));


  vec_delete (v1);
  vec_delete (v2);
  vec_delete (v3);
  vec_delete (v4);
  vec_delete (v5);

  ivec_delete (iv1);
  ivec_delete (iv2);
  ivec_delete (iv3);

  return 0;
}
