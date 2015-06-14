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
  Test program for Variables Length Codes
  Copyright (C) 2005 Herve Jegou
*/


#include <stdio.h>
#include <it/io.h>
#include <it/vec.h>
#include <it/vlc.h>
#include <it/source.h>

int main (int argc, char **argv)
{
  vlc_t *vlc;
  vec  nodes_pdf;
  vec  nodes_expectation;
  vec  pdf = vec_new_string ("0.5 0.3 0.1 0.1");
  vec  v1N = vec_new_1N (5);
  ivec S;
  bvec B;
  ivec D;
  int  N = 20;

  it_printf ("pdf     = $v\n", pdf);
  it_printf ("symbols = $v\n", v1N);

  vlc = vlc_hu_tucker (pdf);
  printf ("\n[ Hu-Tucker ]\n");
  vlc_print (vlc);
  printf ("\nmdl( vlc )  = %g\n", vlc_mdl (vlc, pdf));

  nodes_pdf = vlc_nodes_pdf (vlc, pdf);
  nodes_expectation = vlc_nodes_expectation (vlc, pdf, v1N);
  it_printf ("\nP(nodes)=$v\nE(nodes)=$v\n", nodes_pdf, nodes_expectation);
  vlc_delete (vlc);

  vlc = vlc_huffman (pdf);
  printf ("\n[ Huffman code ]\n");
  vlc_print (vlc);
  printf ("\nmdl( vlc )  = %g\n", vlc_mdl (vlc, pdf));

  vlc_quasi_lexicographic (vlc, pdf, v1N);
  printf ("\n[ p-lex Huffman code ]\n");
  vlc_print_all (vlc, pdf, v1N);
  printf ("\nmdl( vlc )  = %g\n", vlc_mdl (vlc, pdf));
  printf ("minh( vlc ) = %d\n", vlc_minh (vlc));
  printf ("maxh( vlc ) = %d\n", vlc_maxh (vlc));

  S = source_memoryless (N, pdf);
  printf ("Length( S ) = %d\n", ivec_length (S));

  B = vlc_encode_concat (vlc, S);

  D = vlc_decode_concat (vlc, B);

  it_printf ("\n[Coding and Decoding]\nS = $d\nB = $b\nD = $d\n", S, B, D);

  /* Custom VLC is read from a string */
  vlc_delete (vlc);
  vlc = vlc_read ("{0 11 101 100}");
  printf ("Custom Code = ");
  vlc_print (vlc);
  printf ("\n");


  vlc_delete (vlc);
  vec_delete (pdf);
  vec_delete (v1N);
  ivec_delete (S);
  bvec_delete (B);
  ivec_delete (D);
  return 0;
}
