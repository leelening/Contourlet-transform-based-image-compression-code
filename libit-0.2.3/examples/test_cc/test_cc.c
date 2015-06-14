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
/*         Test program for convolutional codes               */
/*------------------------------------------------------------*/

#include <stdio.h>
#include <it/types.h>
#include <it/io.h>
#include <it/vec.h>
#include <it/distance.h>
#include <it/convcode.h>
#include <it/random.h>
#include <it/channel.h>
#include <it/source.h>
#include <it/source_func.h>
#include <it/mat.h>
#include <it/math.h>

/* which code to test */
#undef NONRECURSIVE_1_3_CODE
#undef NONRECURSIVE_2_3_CODE
#define RECURSIVESYS_1_2_CODE

mat bspk_metrics (it_convolutional_code_t * cc, vec r)
{
  int  i, j, m;
  int  N = cc->n;
  int  L = vec_length (r) / N;
  mat  metrics;
  int  n_labels = cc->n_labels;
  double d;


#define bit(x, n) (((x) >> (n)) & 1)

  metrics = mat_new (n_labels, L);

  for (i = 0; i < L; i++)
    for (j = 0; j < n_labels; j++) {
      metrics[j][i] = 0;
      for (m = 0; m < N; m++) {
	d = (r[i * N + m] - (bit (j, N - 1 - m) ? 1 : -1));
	metrics[j][i] -= d * d;
      }
    }

  return (metrics);
}

int main (void)
{
  bvec input;
  bvec output;
  vec  modulated;
  vec  received;
  it_convolutional_code_t *cc;
  imat generator;		/* generator polynomials, ordered from LSB to MSB */
  int  feedback;
  mat  metrics;

  /* initialize the random number generator */
  //  it_randomize();

  /* generate a random binary sequence of 10 bits */
  input = source_binary (10, 0.5);
  it_printf ("input = $b\n", input);

  /* construct a convolutional code */
#ifdef NONRECURSIVE_1_3_CODE
  generator = imat_new (1, 3);
  generator[0][0] = 0133;
  generator[0][1] = 0165;
  generator[0][2] = 0171;
  feedback = 0;
#endif

#ifdef NONRECURSIVE_2_3_CODE
  generator = imat_new (2, 3);
  generator[0][0] = 023;
  generator[0][1] = 035;
  generator[0][2] = 0;

  generator[1][0] = 0;
  generator[1][1] = 05;
  generator[1][2] = 013;
  feedback = 0;
#endif

#ifdef RECURSIVESYS_1_2_CODE
  generator = imat_new (1, 2);
  generator[0][0] = 033;	/* LSB is parity */
  generator[0][1] = 037;	/* MSB is systematic */
  feedback = 037;
#endif

  cc = it_convolutional_code_new (generator, feedback);

  /* encode the sequence */
  output = it_cc_encode (cc, input);
  it_printf ("output = $b\n", output);

  /* modulate */
  modulated = modulate_bpsk (output);
  it_printf ("modulated = $v\n", modulated);

  /* add some noise  (gaussian, std dev = 1.5) */
  received = channel_awgn (modulated, 1.5);
  it_printf ("received = $v\n", received);

  /* compute metrics */
  metrics = bspk_metrics (cc, received);

  /* decode */
  it_printf ("decoding\n");
  bvec_delete (output);
  output = it_viterbi_decode (cc, metrics);
  it_printf ("decoded = $b\n", output);
  it_printf ("input = $b\n", input);

  mat_delete (metrics);
  vec_delete (received);
  vec_delete (modulated);
  bvec_delete (output);
  it_delete (cc);
  bvec_delete (input);
  imat_delete (generator);

  return (0);
}
