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
/*                Test program for linear algebra             */
/*------------------------------------------------------------*/

#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <math.h>
#include <assert.h>
#include <it/mat.h>
#include <it/vec.h>
#include <it/io.h>
#include <it/linalg.h>

int main ()
{
  vec  v0, v1, v2; 
  int  j;

  cvec eval; 
  cmat evec; 
  mat m1, m2, m3; 

  m1 = mat_new( 3, 3 ); 

  m1[0][0] = 1;   m1[0][1] = 5;   m1[0][2] = 2; 
  m1[1][0] = 2;   m1[1][1] = 3;   m1[1][2] = 5; 
  m1[2][0] = 3;   m1[2][1] = 7;   m1[2][2] = 3; 

  fprintf( stderr, "\n\nACKNOWLEDGEMENT: Various linear\nalgebra routines (EIG, SVD) are\nborrowed from the JAMA Java\npackage in the public domain.\nSee linalg.h for details.\n\nThese routines were written by:\nJoe Hicklin        (MathWorks)\nCleve Moler        (MathWorks)\nPeter Webb         (MathWorks)\nRonald F. Boisvert (NIST)\nBruce Miller       (NIST)\nRoldan Pozo        (NIST)\nKarin Remington    (NIST)\n\n" );

  it_printf( "m1=\n#m\n", m1 ); 

  m2 = mat_new_inv( m1 ); 

  printf( "\n\nTesting matrix inversion (LU + AX=B)\n\n" );

  it_printf( "m2=inv(m1)=\n#m\n", m2 ); 

  m3 = mat_new_mul( m2, m1 ); 

  it_printf( "Computing m1*m2=\n#m\n", m3 );

  printf( "\n\nTesting eigenvalue decomposition\n\n" );

  evec = cmat_new( 3, 3 ); 

  eval = mat_eig( m1, evec );

  it_printf( "Eigenvalues of m1= $z\n", eval );

  it_printf( "Eigenvectors of m1=\n#z\n", evec );


  printf( "\n\nTesting singular value decomposition\n\n" );

  v0 = mat_svd( m1, m2, m3 );

  it_printf( "m1=\n#m\n", m1 );

  it_printf( "Singular values of m1= $v\n", v0 ); 

  it_printf( "Corresponding U matrix:\n#m\n", m2 );
  it_printf( "Corresponding V matrix:\n#m\n", m3 );

  mat_copy( m2, m1 ); 


  printf( "\n\nTesting Gram-Schmidt orthogonalisation\n\n" );

  mat_gs( m2 ); 

  it_printf( "m2 is Gram-Schmidt(m1):\n#m\n", m2 ); 

  for ( j= 0; j< mat_width(m2); j++ ) 
    {
      v1 = mat_get_col( m2, j ); 
      v2 = mat_get_col( m2, (j+1)%mat_width(m2) ); 

      printf( "<m2(:,%d)|m2(:,%d)>=%e\tnorm(m2(:,%d))=%e\n", j, (j+1)%mat_width(m2), vec_inner_product(v1, v2), j, vec_norm(v1, 2.) );

      vec_delete( v1 );
      vec_delete( v2 );
    }
  

  printf( "\n\nTesting some matrix-related numbers\n\n" );

  printf( "Some values for m1:\n" ); 

  printf( "det(m1)=%f\n", mat_det(m1) );
  printf( "rank(m1)=%d\n", mat_rank(m1) ); 
  printf( "cond(m1)=%f\n", mat_cond(m1) ); 
  printf( "norm2(m1)=%f\n", mat_norm2(m1) ); 

  cvec_delete( eval );
  cmat_delete( evec );

  mat_delete( m1 );
  mat_delete( m2 );
  mat_delete( m3 ); 

  vec_delete( v0 );

  return 0;
}
