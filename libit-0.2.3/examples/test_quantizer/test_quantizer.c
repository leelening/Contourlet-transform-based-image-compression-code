#include <stdio.h>
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
/*             Test program for quantizer                     */
/*------------------------------------------------------------*/

#include <it/types.h>
#include <it/io.h>
#include <it/vec.h>
#include <it/distance.h>
#include <it/quantizer.h>
#include <it/random.h>
#include <it/source.h>
#include <it/source_func.h>
#include <it/math.h>

it_function_args (gaussian_pdf)
{
  double sigma;
};

it_function (gaussian_pdf)
{
  double sigma = it_this->sigma;	/* standard deviation */

  return (1. / (sqrt (2. * M_PI) * sigma) *
	  exp (-x * x / (2. * sigma * sigma)));
}


it_function_args (laplacian_pdf)
{
  double lambda;
};

it_function (laplacian_pdf)
{
  double lambda = it_this->lambda;	/* variance is 2*lambda^2 */

  return (1. / (2. * lambda) * exp (-fabs (x) / lambda));
}

void print_quantizer (it_uniform_quantizer_t * SQ)
{
  int  _min, _max;

  it_printf ("[Quantizer]\n");
  it_printf ("\tdequantize(0) = %f\n", it_dequantize (SQ, 0));
  it_printf ("\tstep size: %f\n", it_quantizer_get_step (SQ));
  it_printf ("\tcardinal: %d\n", it_quantizer_get_cardinal (SQ));
  it_quantizer_get_index_range (SQ, &_min, &_max);
  it_printf ("\tindex range: [%d, %d]\n", _min, _max);
}

void test_quantizer (vec V, it_quantizer_t * quantizer)
{
  vec  R;			/* reconstructed vector */
  ivec Q;			/* quantized vector     */
  vec  H;			/* histogram            */
  int  a, b;			/* range of the quantized values */
  double error;
  double energy;

  it_printf ("quantizing\n");
  Q = it_quantize_vec (quantizer, V);

  it_printf ("dequantizing\n");
  R = it_dequantize_vec (quantizer, Q);

  energy = vec_variance (V);
  error = vec_distance_mse (V, R, 0);	/* compute reconstruction error */

  a = ivec_min (Q);
  b = ivec_max (Q);
  it_printf ("used range: [ %d, %d ]\n", a, b);
  ivec_decr (Q, a);
  H = histogram_normalized (b - a + 1, Q);
  /*
     for(int i = 0; i < ivec_length(H); i++)
     it_printf("%d\n", H[i]);
   */
  it_printf ("entropy = %f\n", entropy (H));

  it_printf ("SNR = %f dB\n", 10 * log10 (energy / error));

  vec_delete (R);
  vec_delete (H);
  ivec_delete (Q);
}


int main ()
{
  int  i;
  vec  codebook;
  vec  source;
  it_function_args (gaussian_pdf) gaussian_args;
  it_function_args (laplacian_pdf) laplacian_args;

  it_scalar_quantizer_t *quantizer;
  it_uniform_quantizer_t *uniq;
  it_trellis_coded_quantizer_t *tcq;

  /* code used for the TCQ */
  it_convolutional_code_t *code;
  imat generator = imat_new (1, 2);
  generator[0][0] = 0133;
  generator[0][1] = 0171;

  /* initialize the random number generator */
  //  it_randomize();

  /* random continous vector uniformly distributed in [0,1] */
  source = source_uniform_01 (10000);

  /* test a uniform scalar quantizer generated from
     its number of bins and the range of the source */
  uniq = it_uniform_quantizer_new_from_range (256, 0.0, 1.0);
  print_quantizer (uniq);
  test_quantizer (source, IT_QUANTIZER (uniq));
  it_delete (uniq);

  /* initialize the codebook */
  codebook = vec_new (256);
  for (i = 0; i < 256; i++)
    codebook[i] = i / 256. + 1. / 512.;

  /* test a scalar quantizer generated from a codebook */
  quantizer = it_scalar_quantizer_new (codebook);
  test_quantizer (source, IT_QUANTIZER (quantizer));
  vec_delete (codebook);

  /* test a uniform scalar quantizer generated from
     the center (reconstruction value associated to
     the zero index) and step, with a deadzone of
     twice the normal quantizer step.               */
  uniq = it_uniform_quantizer_new_from_center (0, 1. / 256., 2.0);

  /* test quantization/dequantization in the dead zone */
  it_printf ("quantize[1/257] = %d\n", it_quantize (uniq, 1 / 257.));
  it_printf ("quantize[-1/257] = %d\n", it_quantize (uniq, -1 / 257.));
  it_printf ("quantize[-1/255] = %d\n", it_quantize (uniq, -1 / 255.));
  it_printf ("dequantize[-1] = %f\n", it_dequantize (uniq, -1));

  /* restrict the index range to -10,10 */
  it_quantizer_set_index_range (uniq, -10, 10);

  /* generate and print the resulting codebook */
  codebook = it_quantizer_get_codebook (uniq);
  it_printf ("codebook = $v\n", codebook);
  vec_delete (codebook);

  /* set the index range to 0,1023 and test */
  it_quantizer_set_index_range (uniq, 0, 1023);
  print_quantizer (uniq);
  test_quantizer (source, IT_QUANTIZER (uniq));

  /* get a part of the codebook between 1 and 256 */
  codebook = it_quantizer_get_codebook_range (uniq, 1, 256);

  /* use this sub codebook for quantization */
  it_quantizer_set_codebook (quantizer, codebook, 1);
  test_quantizer (source, IT_QUANTIZER (quantizer));
  vec_delete (codebook);
  it_delete (uniq);
  it_delete (quantizer);

  /* TCQ */
  uniq = it_uniform_quantizer_new_from_range (512, 0.0, 1.0);
  code = it_convolutional_code_new (generator, 0);
  tcq = it_trellis_coded_quantizer_new_partition (code, uniq);

  test_quantizer (source, IT_QUANTIZER (tcq));
  it_delete (uniq);
  it_delete (tcq);
  it_delete (code);

  it_printf ("bound = %f dB\n",
	     10 * log10 (4) * 8 + 10 * log10 (M_PI * M_E / 6.0));
  vec_delete (source);

  /* Lloyd-Max quantization */
  gaussian_args.sigma = 1.0;
  codebook = lloyd_max (gaussian_pdf, &gaussian_args, -5, 5, 4);

  /* random gaussian vector centered on 0 of variance 1 */
  source = source_gaussian (10000, 0, gaussian_args.sigma);
  //source = source_pdf(10000, -5, 5, gaussian_pdf, &gaussian_args);

  quantizer = it_scalar_quantizer_new (codebook);
  test_quantizer (source, IT_QUANTIZER (quantizer));
  vec_delete (codebook);
  it_delete (quantizer);
  vec_delete (source);

  /* random laplacian vector centered on 0 of variance 1 */
  /* (using the acceptance-rejection generator) */
  laplacian_args.lambda = 1 / sqrt (2.0);
  source = source_pdf (10000, -10, 10, laplacian_pdf, &laplacian_args);
  codebook = lloyd_max (laplacian_pdf, &laplacian_args, -10, 10, 4);
  quantizer = it_scalar_quantizer_new (codebook);
  test_quantizer (source, IT_QUANTIZER (quantizer));
  vec_delete (codebook);
  it_delete (quantizer);
  vec_delete (source);

  /* and now for the Lloyd-Max TCQ */
  /* random gaussian vector centered on 0 of variance 1 */
  source = source_gaussian (10000, 0, gaussian_args.sigma);
  codebook = lloyd_max (gaussian_pdf, &gaussian_args, -5, 5, 16);

  quantizer = it_scalar_quantizer_new (codebook);
  test_quantizer (source, IT_QUANTIZER (quantizer));	/* test SQ */

  code = it_convolutional_code_new (generator, 0);
  tcq = it_trellis_coded_quantizer_new_partition (code, quantizer);

  test_quantizer (source, IT_QUANTIZER (tcq));
  it_delete (quantizer);
  it_delete (tcq);
  it_delete (code);

  vec_delete (source);

  return (0);
}
