/*
   libit - Library for basic source and channel coding functions
   Copyright (C) 2005-2008 
   Francois Cayre, Vivien Chappelier, Herve Jegou

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
  Linear algebra functions
  Copyright (C) 2006-2008 François Cayre


  These basic linear algebra functions are meant as a good 
  Swiss knife for every day use in most situations (real, 
  dense matrices). 

  We do not plan to add support for sparse, banded matrices 
  or whatsoever. 

  GENERAL NOTE: Several functions provided here imply using 
  several additionnal storage for various matrices or vectors 
  related to the goal of the function (think of matrices U 
  *and* V of a SVD for example). IN THESE CASES, IT IS THE 
  RESPONSIBILITY OF THE USER TO PROPERLY ALLOCATE MEMORY BEFORE 
  CALLING THE ROUTINE. However, we gracefully perform checking 
  before actually launching the routine. 

  Functions: 
  - mat_eig_sym    [ It is the responsibility of the user to make ]
  - mat_eig_nonsym [ a proper decision between these two routines ]
  - mat_svd 
  - mat_rank 
  
  are taken from the public-domain JAMA package: 
  http://math.nist.gov/javanumerics/jama/ 

  Original code from: 
  - Joe Hicklin         (MathWorks)
  - Cleve Moler         (MathWorks)
  - Peter Webb          (MathWorks)
  - Ronald F. Boisvert  (NIST)
  - Bruce Miller        (NIST)
  - Roldan Pozo         (NIST)
  - Karin Remington     (NIST)

  According to the JAMA page: 
  "The algorithms employed are similar to those of the 
   classic Wilkinson and Reinsch Handbook, i.e. the same 
   algorithms used in EISPACK, LINPACK and MATLAB."

  The linear system solver is based on LU with partial or 
  total pivoting strategy (choice is left to the user). 

  TODO (possibly before 2048): 
  - Least square QR solver (possibly constrained) 
  - Implementation of various Arnoldi/Lanczos-based methods 

*/

#ifndef __it_linalg_h
#define __it_linalg_h

#include <it/vec.h>
#include <it/mat.h>
#include <it/io.h>
#include <it/math.h>

/*---------------------------------------------------------------------------*/
/*! \defgroup linalg Linear Algebra                                          */
/* @{                                                                        */
/*---------------------------------------------------------------------------*/


/* Direct LU solver */
vec  mat_solve_vec (mat A, vec b);
mat  mat_solve_mat (mat A, mat B);

/* Direct Least Square QR-based solver
 */
mat mat_ls( mat A, mat B ); 

/* Matrix decompositions and transforms */
double mat_lu (mat a, ivec piv ); 
void mat_cholesky( mat a );
vec  mat_qr (mat a);
void mat_gs (mat A);	
mat  mat_real_schur (mat a);	
cvec mat_eig (mat a, cmat evec);
vec  mat_eig_sym (mat a, mat evec);
mat  mat_hessenberg (mat a, mat V);
vec  mat_svd (mat A, mat U, mat V);

/* Inversion of a matrix using the Gaussian method */
mat  mat_inv (mat m);
mat  mat_new_inv (mat m);
cmat cmat_inv (cmat m);
cmat cmat_new_inv (cmat m);

/* Unsorted */
int  mat_is_symmetric (mat a);
double mat_det (mat a);
double mat_norm2 (mat a);
double mat_cond (mat a);
int  mat_rank (mat a);

/* @} */

#endif				/* __it_linalg_h */
