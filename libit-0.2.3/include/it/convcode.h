/*
   libit - Library for basic source and channel coding functions
   Copyright (C) 2005-2008 Francois Cayre, Vivien Chappelier, Herve Jegou

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
  Base class for convolutional codes.
  Vivien Chappelier <vivien.chappelier@irisa.fr>
*/

#ifndef __it_convcode_h
#define __it_convcode_h

#include <it/types.h>
#include <it/mat.h>
#include <it/vec.h>


/*---------------------------------------------------------------------------*/
/*! \defgroup convcode Convolutional Codes                                   */
/* @{                                                                        */
/*---------------------------------------------------------------------------*/

/* Generic convolutional code class */
typedef struct _convolutional_code_ {
  it_extends (it_object_t);

  /* overload the virtual destructor */
  void (*it_overloaded (destructor)) (it_object_t * it_this);

  /* Encode a binary vector with the convolutional code */


       
  bvec (*encode) (struct _convolutional_code_ * convolutional_code,
		  bvec v);

  /* Encode a 2^k-valued vector to a 2^n-valued vector */

  ivec (*encode_symbolic) (struct _convolutional_code_ * cc, ivec b);

  int  k;			/* input bits */
  int  n;			/* output bits */
  int  memory;		/* memory of the code */
  int  n_labels;
  int  n_states;
  int  n_symbols;

  vec  logalpha_0;		/* starting logprobabilities */
  vec  logbeta_end;		/* ending logprobabilities */
  mat  next_state_logpt;	/* transition logprobabilities */
  imat automaton;		/* next state   [n_branches][n_states] */
  imat output;		/* output       [1 << k][n_states]     */
  imat input;			/* input        [1 << n][n_states]     */

  int  Q;			/* feedback polynomial Q (O=non-recursive) */
  imat generators;		/* generator polynomials */

} it_convolutional_code_t;

#define IT_CONVOLUTIONAL_CODE(q) IT_CAST(it_convolutional_code_t, q)

it_instanciate (it_convolutional_code_t);

/* create a new convolutional code from its generator polynomials */
/* and feedback polynomial. For non-recursive codes, set feedback to zero. */
static inline it_convolutional_code_t *it_convolutional_code_new (imat
								  generators,
								  int
								  feedback) {
  return (it_new_va (it_convolutional_code_t)
	  (it_va, generators, feedback));
}
#define it_convolutional_code_encode(it_this, b) __it_convolutional_code_encode(IT_CONVOLUTIONAL_CODE(it_this), b)
static inline bvec __it_convolutional_code_encode (it_convolutional_code_t
						   * it_this, bvec b) {
  return (it_this->encode (it_this, b));
}

#define it_convolutional_code_encode_symbolic(it_this, b) __it_convolutional_code_encode_symbolic(IT_CONVOLUTIONAL_CODE(it_this), b)
static inline ivec
__it_convolutional_code_encode_symbolic (it_convolutional_code_t *
					 it_this, ivec b) {
  return (it_this->encode_symbolic (it_this, b));
}

static inline int
it_convolutional_code_trellis_label (it_convolutional_code_t * cc,
				     int state, int symbol) {
  return (cc->output[symbol][state]);
}

static inline int
it_convolutional_code_trellis_next (it_convolutional_code_t * cc,
				    int state, int symbol) {
  return (cc->
	  automaton[it_convolutional_code_trellis_label (cc, state, symbol)]
	  [state]);
}

/* shortnames for some functions */
#define it_cc_encode(cc, b) it_convolutional_code_encode(cc, b)
#define it_cc_encode_symbolic(cc, b) it_convolutional_code_encode_symbolic(cc, b)
#define it_cc_decode(cc, v) it_convolutional_code_decode(cc, v)
#define it_cc_next(cc, s, b)  it_convolutional_code_trellis_next(cc, s, b)
#define it_cc_label(cc, s, b) it_convolutional_code_trellis_label(cc, s, b)

/* helper functions */
ivec it_viterbi_decode_symbolic (it_convolutional_code_t * cc, mat metrics);
bvec it_viterbi_decode (it_convolutional_code_t * cc, mat metrics);

/* @} */

#endif
