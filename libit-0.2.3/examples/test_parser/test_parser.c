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
/*                 Test program for Parsers                   */
/*------------------------------------------------------------*/

#include <stdio.h>
#include <stdarg.h>

#include <it/vec.h>
#include <it/mat.h>
#include <it/parser.h>
#include <it/io.h>

int main (int argc, char **argv)
{
  int  i, def;
  double dbl;
  char *s;
  vec  v;
  ivec iv;
  cvec cv;
  mat  m;
  cmat cm;
  parser_t *parser;

  /* Initialization of the parser with the command line. 
     This source has the highest priority                     */
  printf ("______________________________\n");
  parser = parser_init (argc, argv, "test_parser.param",
			"a=-35\ndef=9\nv=[-1,-2,-3]\ncv=[i 1 -i 1+i]");
  parser_print (parser);


  printf ("______________________________\n");
  printf ("[ Display variables ]\n");
  i = parser_get_int (parser, "a");
  def = parser_get_int (parser, "def");
  dbl = parser_get_double (parser, "dbl");
  s = parser_get_string (parser, "S");
  v = parser_get_vec (parser, "V2");
  iv = parser_get_ivec (parser, "V");
  cv = parser_get_cvec (parser, "cv");
  m = parser_get_mat (parser, "m");
  cm = parser_get_cmat (parser, "cm");

  printf ("______________________________\n");
  printf ("a   = %d\n", i);
  printf ("def = %d\n", def);
  printf ("dbl = %g\n", dbl);
  printf ("S   = %s\n", s);
  it_printf ("v   = $v\n", v);
  it_printf ("iv  = $d\n", iv);
  it_printf ("cv  = $.3z\n", cv);
  it_printf ("m  = #m\n", m);
  it_printf ("cm  = #.3z\n", cm);
  parser_delete (parser);
  return 0;
}
