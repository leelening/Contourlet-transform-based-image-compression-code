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
/*          Test program for Input/Output functions           */
/*------------------------------------------------------------*/

#include <stdio.h>
#include <stdarg.h>

#include <it/types.h>
#include <it/vec.h>
#include <it/io.h>

int main ()
{
  int  d1 = 5, d2 = 7;
  double f1 = 3.14159, f2 = -5.6;
  cplx mycplx;
  char *s = "toto";
  char *char_vec = " [ 1.23, 45.6,-78, 9 ,10 ]";
  char *char_ivec = " [ 1,-478, 9 ,-10 ]";
  char *char_cplx = "i";
  char c = 'x';


  vec  v = vec_new_arithm (1, -2, 15);
  ivec iv = ivec_new_geom (1, 2, 8);
  bvec bv = bvec_new_ones (4), bvr;

  vec  v2 = vec_new_string ("35 2.3 634 -34;");
  ivec iv2 = ivec_new_string (" 35 2 634,-34");
  bvec bv2 = bvec_new_string ("[35 2 23 34] ");
  cvec cv2 = cvec_new_string ("[35+1i -2+3i 634i i -34 -i +1+i] ");

  /* Read and print a complex number */
  it_read_cplx (char_cplx, &mycplx);
  it_printf ("mycplx = %z\n", mycplx);

  /* Display usual types of variables  */
  printf ("d1=%5d\nd2=%d\nf1=%2.5g\nf2=%3f\ns=%s\nc=%c\n\n",
	  d1, d2, f1, f2, s, c);

  it_printf ("d1=%5d\nd2=%d\nf1=%2.5g\nf2=%3f\ns=%s\nc=%c\n\n",
	     d1, d2, f1, f2, s, c);

  /* Display vector variables  */
  it_printf ("v=$.3f\niv=$d\nbv=$b\n", v, iv, bv);

  /* Read a vector */
  it_read_vec (char_vec, &v);
  it_read_ivec (char_ivec, &iv);
  it_printf ("read string %s\nv = $v\n", char_vec, v);
  it_printf ("read string %s\niv = $i\n", char_ivec, iv);

  it_printf ("v2 = $v\n", v2);
  it_printf ("iv2 = $i\n", iv2);
  it_printf ("bv2 = $b\n", bv2);
  it_printf ("cv2 = $.3z\n", cv2);

  bvec_push (bv, 1);
  bvec_push (bv, 0);
  bvec_push (bv, 1);
  bvec_push (bv, 0);
  bvec_push (bv, 1);
  bvec_file_write_bits ("test_io_bvec", bv);
  bvr = bvec_file_read_bits ("test_io_bvec", bvec_length (bv));
  it_printf ("bvr = $b\n", bvr);

  vec_delete (v);
  ivec_delete (iv);
  bvec_delete (bv);
  vec_delete (v2);
  ivec_delete (iv2);
  bvec_delete (bv2);
  bvec_delete (bvr);
  return 0;
}
