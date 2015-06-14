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
  Hidden Markov Model related algorithms
  Copyright (C) 2005 Herve Jegou
*/


#ifndef __it_hhmalgo_h
#define __it_hhmalgo_h

#include <it/vec.h>
#include <it/mat.h>

#ifndef DUMM_NODE
#define DUMM_NODE (NULL_INDEX)
#endif

/*-----------------------------------------------------------------------------*/
/*! \defgroup hmm Hidden Markov Model                                          */
/* @{                                                                        */
/*-----------------------------------------------------------------------------*/

/* The BCJR algorithm. Generic version. */
mat  bcjr (mat x, imat next_state, mat next_state_pt,
	   vec alpha_0, vec beta_end);

/* The Viterbi algorithm. Generic version. */
ivec viterbi (mat x, imat next_state, mat next_state_pt,
	      vec alpha_0, vec beta_end);

/* The Viterbi algorithm using logprobabilities. Generic version. */
ivec logviterbi (mat logx, imat next_state, mat next_state_logpt,
		 vec logalpha_0, vec logbeta_end);

/* The viterbi algorithm that exploit side information on states at the decoder */
ivec viterbi_side (mat x, imat next_state, mat next_state_pt,
		   vec alpha_0, ivec sideinfo_pos, mat sideinfo);

/* The BCJR algorithm with additional side information on states at the decoder. */
mat  bcjr_side (mat x, imat next_state, mat next_state_pt,
		vec alpha_0, ivec sideinfo_pos, mat sideinfo);

/* @} */

#endif
