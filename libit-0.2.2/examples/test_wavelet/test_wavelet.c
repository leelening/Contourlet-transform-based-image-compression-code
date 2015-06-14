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
  Test program for wavelets
  Copyright (C) 2005 Vivien Chappelier
*/

#include <it/io.h>
#include <it/mat.h>
#include <it/transform.h>
#include <it/wavelet.h>
#include <it/transform2D.h>
#include <it/wavelet2D.h>
#include <it/separable2D.h>

/* scale the wavelet for display */
it_function (rescale_image)
{
  x += 128;
  if (x < 0)
    x = 0;
  if (x > 255)
    x = 255;

  return (x);
}

/* rescale the wavelet coefficients for sound I/O */
it_function (rescale_sound)
{
  x *= 1. / 32;

  return (x);
}

int main ()
{
  it_wavelet_t *wavelet;
  it_wavelet2D_t *wavelet2D;
  it_separable2D_t *separable;
  const char *image_in = "../data/test.pgm";
  const char *image_out = "out.pgm";
  const char *sound_in = "../data/test.wav";
  const char *sound_out = "out.wav";
  char pnm_type, comments[1000];
  int  width, height, maxval;
  int  levels;
  int  length, channels, srate, depth;
  mat  m, mt;
  vec  v, vt;

  levels = 4;

  /* Read the sound */
  if (!wav_info (sound_in, &channels, &srate, &depth, &length)) {
    fprintf (stderr, "unable to open file %s\n", sound_in);
    return (1);
  }
  printf
    ("file name = %s\nchannels = %d\nsampling rate = %d\ndepth = %d\nlength = %d samples/channel\n",
     sound_in, channels, srate, depth, length);

  m = mat_wav_read (sound_in);
  v = m[0];			/* consider only the first channel */

  /* Transform the sound */
  vt = it_dwt (v, it_wavelet_lifting_53, levels);
  vec_delete (v);

  /* Write down the coefficients */
  v = vec_new_eval (vt, rescale_sound, NULL);
  m[0] = v;
  mat_wav_write ("wavelet.wav", m, srate, depth);
  vec_delete (v);

  /* Reconstruct the sound */
  v = it_idwt (vt, it_wavelet_lifting_53, levels);
  vec_delete (vt);

  m[0] = v;
  mat_wav_write (sound_out, m, srate, depth);
  mat_delete (m);

  /* Test the separable transform */
  /* Warning: note that for the wavelet with more than 1 level of   */
  /* decomposition, the transform obtained by applying the wavelet  */
  /* on the rows, then on the columns of the image is *not* what is */
  /* usually called the separable wavelet. See this example:        */
  /* separable(wavelet1D)                   wavelet2D               */
  /*                                                                */
  /*   +------+------+------+               +------+------+------+  */
  /*   | L1L1 | L1H1 | L1H0 |               | L1L1 | LH1  |      |  */
  /*   +------+------+------+               +------+------+  LH0 |  */
  /*   | H1L1 | H1H1 | H1H0 |               | HL1  | HH1  |      |  */
  /*   +------+------+------+               +------+------+------+  */
  /*   |      |      |      |               |             |      |  */
  /*   | H0L1 | H0H1 | H0H0 |               |    HL0      |  HH0 |  */
  /*   +------+------+------+               +-------------+------+  */

  m = mat_pgm_read (image_in);
  printf ("PGM %dx%d\n", mat_height (m), mat_width (m));

  levels = 1;

  /* create a 1D wavelet object */
  wavelet = it_wavelet_new (it_wavelet_lifting_97, levels);
  /* create a separable transform out of the wavelet */
  separable = it_separable2D_new (wavelet);

  /* Transform the image */
  mt = (mat) it_transform2D (separable, m);
  mat_delete (m);

  /* Write down the coefficients (shifted & saturated) */
  m = mat_new_eval (mt, rescale_image, NULL);
  mat_pgm_write ("wavelet_separable.pgm", m);
  mat_delete (m);

  /* Reconstruct the image */
  m = (mat) it_itransform2D (separable, mt);
  mat_delete (mt);

  it_delete (separable);
  it_delete (wavelet);

  mat_pgm_write ("separable.pgm", m);
  mat_delete (m);

  /* Read the image */
  pnm_info (image_in, &pnm_type, &width, &height, &maxval, comments, 1000);
  printf ("file name = %s\npnm type = %c\n%dx%d -> maxval=%d\ncomments=%s\n",
	  image_in, pnm_type, width, height, maxval, "");

  m = mat_pgm_read (image_in);

  printf
    ("height(m) = %d\tmaxheight(m) = %d\nwidth(m) = %d\tmaxwidth(m) = %d\n",
     mat_height (m), mat_height_max (m), mat_width (m), mat_width_max (m));

  levels = 5;

  /* create a 2D wavelet object */
  wavelet2D = it_wavelet2D_new (it_wavelet_lifting_97, levels);

  /* Transform the image */
  mt = it_wavelet2D_transform (wavelet2D, m);
  mat_delete (m);

  /* Write down the coefficients (shifted & saturated) */
  m = mat_new_eval (mt, rescale_image, NULL);
  mat_pgm_write ("wavelet.pgm", m);
  mat_delete (m);

  /* Reconstruct the image */
  m = it_wavelet2D_itransform (wavelet2D, mt);
  mat_delete (mt);

  it_delete (wavelet2D);

  mat_pgm_write (image_out, m);
  mat_delete (m);

  return 0;
}
