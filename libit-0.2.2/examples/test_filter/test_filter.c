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
  Test program for filters
  Copyright (C) 2005 Vivien Chappelier
*/

#include <it/io.h>
#include <it/mat.h>
#include <it/parser.h>
#include <it/filter.h>

int main (int argc, char *argv[])
{
  const char *image_in = "../data/test.pgm";
  const char *image_out = "out.pgm";
  mat  m, mt;
  mat  filter;
  parser_t *parser = parser_init (argc, argv, "test_filter.param", NULL);

  /* Read the image */
  m = mat_pgm_read (image_in);
  printf ("PGM %dx%d\n", mat_width (m), mat_height (m));

  parser_print (parser);

  /* Read the filter */
  filter = parser_get_mat (parser, "Laplace");
  mt =
    mat_filter_fir (m, filter, mat_width (filter) / 2,
		    mat_height (filter) / 2);
  mat_delete (filter);
  mat_pgm_write (image_out, mt);
  mat_delete (mt);

  /* Free the allocated resource */
  mat_delete (m);


  return 0;
}
