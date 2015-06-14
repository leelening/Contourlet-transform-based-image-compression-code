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
  Test program for wav file
  Copyright (C) 2005 Vivien Chappelier
*/

#include <it/io.h>
#include <it/mat.h>

int main ()
{
  const char *filename_in = "../data/test.wav";
  const char *filename_out = "out.wav";
  const char *filename_reverse = "reverse.wav";

  int  depth, srate, channels, length;
  imat m;

  if (!wav_info (filename_in, &channels, &srate, &depth, &length)) {
    fprintf (stderr, "unable to open file %s\n", filename_in);
    return (1);
  }
  printf
    ("file name = %s\nchannels = %d\nsampling rate = %d\ndepth = %d\nlength = %d samples/channel\n",
     filename_in, channels, srate, depth, length);

  m = imat_wav_read (filename_in);

  imat_wav_write (filename_out, m, srate, depth);

  /* the same thing with satanic voices ;) */
  ivec_reverse (m[0]);

  imat_wav_write (filename_reverse, m, srate, depth);

  imat_delete (m);
  return 0;
}
