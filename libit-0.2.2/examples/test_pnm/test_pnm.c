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
  Test program for pnm file
  Copyright (C) 2005 Herve Jegou
*/

#include <it/io.h>
#include <it/mat.h>

int main ()
{
  const char *filename_in = "../data/test.pgm";
  const char *filename_out = "out.pgm";
  char pnm_type, comments[1000];
  int  width, height, maxval;
  imat m;

  pnm_info (filename_in, &pnm_type, &width, &height, &maxval, comments, 1000);
  printf ("file name = %s\npnm type = %c\n%dx%d -> maxval=%d\ncomments=%s\n",
	  filename_in, pnm_type, width, height, maxval, "");

  m = imat_pgm_read (filename_in);

  printf
    ("height(m) = %d\tmaxheight(m) = %d\nwidth(m) = %d\tmaxwidth(m) = %d\n",
     imat_height (m), imat_height_max (m), imat_width (m),
     imat_width_max (m));

  imat_pgm_write (filename_out, m);
  imat_delete (m);
  return 0;
}
