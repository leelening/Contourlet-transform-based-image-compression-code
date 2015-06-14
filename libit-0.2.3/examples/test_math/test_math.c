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
/*         Test program for Math functions                    */
/*------------------------------------------------------------*/

#include <stdio.h>
#include <it/math.h>
#include <it/types.h>
#include <it/io.h>

#define SIGMA 3.0
#define INTEGRAL_STEP 100000

/* the function returning one on one plus x^2 (integrates to arctan(x)) */
it_function (one_on_one_plus_x_square)
{
  return (1. / (1. + x * x));
}

/* a function returning x at the power of 4 */
it_function (polynomial)
{
  return (x * x * x * x);
}

/* the gaussian function with parameter sigma */
it_function_args (gaussian_pdf)
{
  double sigma;			/* standard deviation */
};

it_function (gaussian_pdf)
{
  double sigma = it_this->sigma;

  return (1. / (sqrt (2. * M_PI) * sigma) *
	  exp (-x * x / (2. * sigma * sigma)));
}

int main ()
{
  it_function_args (gaussian_pdf) gaussian_args;
  it_function_args (itf_differentiate) differentiate_args;
  it_function_args (itf_differentiate) differentiate_args2;
  it_function_args (itf_diff2) diff2_args;
  it_function_args (itf_sum) sum_args;
  it_function_args (itf_mul) mul_args;
  it_function_args (itf_compose) compose_args;
  it_function_args (itf_integrate_romberg) integrate2_args;
  it_function_args (itf_integrate_trapezoid) integrate3_args;

  /* parametric function call */
  gaussian_args.sigma = SIGMA;
  it_printf ("gaussian pdf in 1 = %f\n", gaussian_pdf (1.0, &gaussian_args));

  /* function sum */
  sum_args.f = itf_identity;
  sum_args.f_args = NULL;
  sum_args.g = polynomial;
  sum_args.g_args = NULL;
  it_printf ("x + x^4 in 2 = %f (%f)\n",
	     itf_sum (2, &sum_args), 2. + 2. * 2. * 2. * 2.);

  /* function product */
  mul_args.f = itf_identity;
  mul_args.f_args = NULL;
  mul_args.g = one_on_one_plus_x_square;
  mul_args.g_args = NULL;
  it_printf ("x / (1 + x^2) in 2 = %f (%f)\n",
	     itf_mul (2, &mul_args), 2. / (1 + 2. * 2.));

  /* function composition */
  compose_args.f = gaussian_pdf;
  compose_args.f_args = &gaussian_args;
  compose_args.g = one_on_one_plus_x_square;
  compose_args.g_args = NULL;
  it_printf ("gaussian(1/(1 + x^2)) in 2 = %f (%f)\n",
	     itf_compose (2, &compose_args),
	     (1. / (sqrt (2. * M_PI) * SIGMA) *
	      exp (-1. / (50. * SIGMA * SIGMA))));

  /* derivatives */
  it_printf ("derivative of arctan in 2 = %f (%f)\n",
	     it_differentiate (IT_FUNCTION (atan), NULL, 2.0),
	     1. / (1. + 2. * 2.));
  it_printf ("derivative of gaussian pdf in 2 = %.10f (%.10f)\n",
	     it_differentiate (gaussian_pdf, &gaussian_args, 2.0),
	     -1. * 2. / (SIGMA * SIGMA) * gaussian_pdf (2.0, &gaussian_args));

  /* composing operators */
  differentiate_args.function = polynomial;
  differentiate_args.args = NULL;
  differentiate_args2.function = itf_differentiate;
  differentiate_args2.args = &differentiate_args;
  it_printf ("d of x^4 in 2 = %f (%f)\n",
	     itf_differentiate (2.0, &differentiate_args), 4. * 2. * 2. * 2.);
  it_printf ("d^2 of x^4 in 2 = %.03f (%.03f)\n",
	     itf_differentiate (2, &differentiate_args2), 12. * 2. * 2.);
  diff2_args.function = polynomial;
  diff2_args.args = NULL;
  it_printf ("d^2 of x^4 in 2 = %.04f (%.04f)\n", itf_diff2 (2, &diff2_args), 12. * 2. * 2.);	/* smaller error */

  /* integrals */ 
    it_printf ("integral (default) of 1/(1+x^2) in [0,1] = %.12f (%.12f)\n",
	       it_integrate (one_on_one_plus_x_square, NULL, 0.0, 1.0),
	       atan (1));

  integrate2_args.function = one_on_one_plus_x_square;
  integrate2_args.args = NULL;
  integrate2_args.a = 0.0;
  integrate2_args.N = 10;
  integrate2_args.p = 14;
  it_printf ("integral (romberg) of 1/(1+x^2) in [0,1] = %.12f (%.12f)\n",
	     itf_integrate_romberg (1.0, &integrate2_args), atan (1));

  integrate3_args.function = one_on_one_plus_x_square;
  integrate3_args.args = NULL;
  integrate3_args.a = 0.0;
  integrate3_args.N = 100000;
  it_printf ("integral (trapezoid) of 1/(1+x^2) in [0,1] = %.12f (%.12f)\n",
	     itf_integrate_trapezoid (1.0, &integrate3_args), atan (1));


  it_printf ("erfinv(-0.2) = %f\n", erfinv (-0.2));

  return (0);
}
