/*
   libit - Library for basic source and channel coding functions
   Copyright (C) 2005-2006 
   Francois Cayre Vivien Chappelier, Herve Jegou

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


#include <it/random.h>
#include <it/vec.h>

#define N 1000000

int main ()
{
  vec  v_z;
  double mu, s = 0, k = 0;
  int  i;

  v_z = vec_new (N);

  for (i = 0; i < N; i++)
    v_z[i] = it_randn ();


  mu = vec_mean (v_z);

  for (i = 0; i < N; i++) {
    s += pow (v_z[i] - mu, 3.);
    k += pow (v_z[i] - mu, 4.);
  }

  s /= (double) vec_length (v_z) - 1;
  k /= (double) vec_length (v_z) - 1;

  printf ("mu=%f\t sigma^2=%f\t skew=%f\t kurt=%f\n",
	  vec_mean (v_z), vec_variance (v_z), s, k);

  printf ("JB=%e\n", (double) vec_length (v_z) / 6. * (s * s +
						       ((k - 3) * (k - 3))) / 4.);

  vec_delete (v_z);
  return 0;
}
