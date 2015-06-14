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
  Interleavers 
  Copyright (C) 2005 Herve Jegou
*/

#ifndef __it_interleaver_h
#define __it_interleaver_h

#include <it/vec.h>
#include <it/mat.h>

/*---------------------------------------------------------------------------*/
/*! \defgroup itlv Interleaver                                               */
/* @{                                                                        */
/*---------------------------------------------------------------------------*/

/* Block interleaving. The vector v is intearleaved.
   The block interleaver is defined by the width of the block */

Vec  __Vec_interleave_block (Vec v, size_t width);
vec  __vec_interleave_block (vec v, size_t width);
ivec __ivec_interleave_block (ivec v, size_t width);
bvec __bvec_interleave_block (bvec v, size_t width);

#define Vec_interleave_block( v, width )  do v = __Vec_interleave_block( v , width ); while( 0 )
#define vec_interleave_block( v, width )  do v = __vec_interleave_block( v , width ); while( 0 )
#define ivec_interleave_block( v, width ) do v = __ivec_interleave_block( v , width ); while( 0 )
#define bvec_interleave_block( v, width ) do v = __bvec_interleave_block( v , width ); while( 0 )

Vec  __Vec_deinterleave_block (Vec v, size_t width);
vec  __vec_deinterleave_block (vec v, size_t width);
ivec __ivec_deinterleave_block (ivec v, size_t width);
bvec __bvec_deinterleave_block (bvec v, size_t width);

#define Vec_deinterleave_block( v, width )  do v = __Vec_deinterleave_block( v , width ); while( 0 )
#define vec_deinterleave_block( v, width )  do v = __vec_deinterleave_block( v , width ); while( 0 )
#define ivec_deinterleave_block( v, width ) do v = __ivec_deinterleave_block( v , width ); while( 0 )
#define bvec_deinterleave_block( v, width ) do v = __bvec_deinterleave_block( v , width ); while( 0 )

Vec  Vec_new_interleave_block (Vec v, size_t width);
vec  vec_new_interleave_block (vec v, size_t width);
ivec ivec_new_interleave_block (ivec v, size_t width);
bvec bvec_new_interleave_block (bvec v, size_t width);

Vec  Vec_new_deinterleave_block (Vec v, size_t width);
vec  vec_new_deinterleave_block (vec v, size_t width);
ivec ivec_new_deinterleave_block (ivec v, size_t width);
bvec bvec_new_deinterleave_block (bvec v, size_t width);


/* Interleave the row of a matrix according to a block interleaver */
Mat  __Mat_interleave_block (Mat m, size_t width);
#define Mat_interleave_block( m, width ) __Mat_interleave_block( (Mat) m, width)
mat  mat_interleave_block (mat m, size_t width);
imat imat_interleave_block (imat m, size_t width);
bmat bmat_interleave_block (bmat m, size_t width);

Mat  __Mat_deinterleave_block (Mat m, size_t width);
#define  Mat_deinterleave_block( m, width ) __Mat_deinterleave_block( (Mat) m, width)
mat  mat_deinterleave_block (mat m, size_t width);
imat imat_deinterleave_block (imat m, size_t width);
bmat bmat_deinterleave_block (bmat m, size_t width);

Mat  __Mat_new_interleave_block (Mat m, size_t width);
#define  Mat_new_interleave_block( m, width ) __Mat_new_interleave_block( (Mat) m, width)
mat  mat_new_interleave_block (mat m, size_t width);
imat imat_new_interleave_block (imat m, size_t width);
bmat bmat_new_interleave_block (bmat m, size_t width);

Mat  __Mat_new_deinterleave_block (Mat m, size_t width);
#define  Mat_new_deinterleave_block( m, width ) __Mat_new_deinterleave_block( (Mat) m, width)
mat  mat_new_deinterleave_block (mat m, size_t width);
imat imat_new_deinterleave_block (imat m, size_t width);
bmat bmat_new_deinterleave_block (bmat m, size_t width);

/* @} */


#endif
