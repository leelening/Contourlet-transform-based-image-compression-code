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
  Changelog: 5/17/07 - 1st version by FC / uses public domain 
                       hashlittle2() hash function from Bob Jenkins. 
		       Lists are doubly-linked circular lists with 
		       sentinel. 
		       Objects are copied into the list with proper 
		       memory allocation. In case an object contains 
		       a pointer, it gets copied -- BEWARE!
		       Hash lookup tables use open addressing with 
		       list collision handling. 
 */

/*
  Lists and hash lookup tables
  Copyright (C) 2007-2008 Francois Cayre
*/


#ifndef __it_hlist_h
#define __it_hlist_h 

#ifndef __it_hlist_h_
#define __it_hlist_h_ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>     /* defines uint32_t etc */
#include <sys/param.h>  /* attempt to define endianness */
#ifdef linux
# include <endian.h>    /* attempt to define endianness */
#endif


#define __HLIST_MAXLEN 12      /* max length of list name and various strings */
#define __HLIST_OUTPUT stderr  /* output for debug information when needed    */

  /* Basic structure for lists cells */
typedef struct cell_t 
{
  struct cell_t * prev, * next; /* *doubly*-linked circular lists */
  void * content;               /* address of content in the cell */
  unsigned short csz;           /* byte size of cell content      */
} *cell, *list; 

  /* A list enjoys a header which contains various meta-data */
typedef struct list_header_t 
{
  char * lname;                 /* a list can have a name         */
  FILE * out;                   /* where to print list info       */
  unsigned int count;           /* number of cells in the list    */
} list_header; 

  /* List head */
typedef struct head_t 
{
  list_header h;                /* the header is hidden in memory */
  struct cell_t data;           /* will contain sentinel cell     */
} * head; 

typedef list fifo;              /* we provide fifo/lifo at no     */
typedef list lifo;              /* extra cost                     */


/* Set object field to value */
#define __object_set_field( o, field, value ) do {			\
    memcpy( &((o).field), &(value), sizeof(value);			\
  } while ( 0 ) 

/* Copy object field into value */
#define __object_get_field( o, field, value ) do {	\
    memcpy( &(value), &((o).field), sizeof(value);	\
  } while ( 0 )

/* Retrieve list header address and type */
#define __get_header(l) ((head)( (char *)(l)-sizeof( list_header )))

/* Retrieve value of 'idx' field in structure 'target' of type 'object' */
/* Return -1 if target==NULL */
#define __idx_value(target,object,idx)					\
  (&(target)?*((int*)(((char*)(target))+((unsigned int)((char*)&(object).idx-(char*)&(object))))):-1)

/* Allocation of a new cell */
#define __new_cell( c )	do {			\
    (c) = malloc( sizeof( *(c) ) );		\
    (c)->content = NULL;			\
    (c)->prev = (c);				\
    (c)->next = (c);				\
  } while ( 0 ) 

/* Print a cell */
#define __cell_print( c, out ) do {						\
    fprintf( (out), "cell @ %p: prev @ %p, next @ %p (content @ %p, %d bytes)\n", (void*)(c), (void*)(c)->prev, (void*)(c)->next, (void*)(c)->content, (c)->csz ); \
  } while ( 0 )

/* Main list memory allocation */
/* At the end of the macro, 'l' points to the 'data' field of the newly allocated list head */
#define __list_init_prealloc( l ) do {					\
    head hl = malloc( sizeof( *hl ) );					\
    hl->h.count = 0;							\
    hl->h.lname = NULL;							\
    hl->h.out = __HLIST_OUTPUT;						\
    (l) = (list)&(hl->data);						\
    (l)->content = NULL;						\
    (l)->prev = l;							\
    (l)->next = l;							\
  } while ( 0 )

/* For short */ 
#define __list_init( l ) __list_init_prealloc( l ) 

/* Returns number of elements in the list */
#define __list_get_count( l, cnt ) do {				\
    head hl = __get_header(l);					\
    assert( sizeof( (cnt) ) == sizeof( hl->h.count ) );		\
    memcpy( &(cnt), &(hl->h.count), sizeof( (cnt) ) );		\
  } while ( 0 ) 

/* Decrement number of list elements */
#define __list_decr_count( l ) do {			\
    head hl = __get_header(l);				\
    hl->h.count--;					\
  } while ( 0 )						\

/* Set number of list elements */
#define __list_set_count( l, n ) do {		\
      head hl = __get_header(l);		\
      hl->h.count = n;				\
  } while ( 0 ) 

/* Increment numberof list elements */
#define __list_incr_count( l ) do {			\
    head hl = __get_header(l);				\
    hl->h.count++;					\
  } while ( 0 )						\

/* Set file descriptor for list output (use fopen!) */
#define __list_set_output( l, file ) do {		\
    head hl = __get_header(l);				\
    fprintf( stderr, "Warning: Changing output!\n" );	\
    hl->h.out = (file);					\
  } while( 0 )

/* Set list name */
#define __list_set_name( l, newname ) do {				\
    unsigned int i, len;						\
    head hl = __get_header(l);						\
    len = strlen(newname)+1<__HLIST_MAXLEN?strlen(newname):__HLIST_MAXLEN; \
    if ( hl->h.lname )							\
      {									\
	fprintf( stderr, "Warning: Changing name!\n" );			\
	free( hl->h.lname );						\
      }									\
    hl->h.lname = malloc( (1+strlen(newname))*sizeof(char) );		\
    for ( i= 0; i< len; i++ ) hl->h.lname[i] = newname[i];		\
    hl->h.lname[i] = '\0';						\
  } while ( 0 )								\

/* Print list header */
#define __list_print_header( l ) do {					\
    head hl = __get_header(l);						\
    if ( hl->h.lname )							\
      fprintf( hl->h.out, "List %s @ %p ", hl->h.lname, (void*)(l) );	\
    else								\
      fprintf( hl->h.out, "List @ %p ", (void*)l );			\
    if ( hl->h.count==1 || hl->h.count==0)				\
      fprintf( hl->h.out, "(%d item)\n", hl->h.count );			\
    else								\
      fprintf( hl->h.out, "(%d items)\n", hl->h.count );		\
  } while ( 0 )								\

/* Check whether list is empty */
/* At the end, 'empty' contains 0 if 'l' is empty, else 1 */
#define __list_is_empty( l, empty ) do {	\
    __list_get_count( l, empty );		\
    empty = !empty;				\
  } while ( 0 ) 

/* Add 'object' in first position in 'l' */
#define __list_add_first( l, object ) do {				\
    cell c;								\
    __new_cell( c );							\
    c->next = (l)->next;						\
    c->prev = (l);							\
    (l)->next->prev = c;						\
    (l)->next = c;							\
    c->content = malloc( sizeof( object ) );				\
    c->csz = sizeof(object);						\
    memcpy( (c->content), &(object), sizeof( object) );			\
    __list_incr_count( l );						\
  } while(0)

/* Add 'object' in last position in 'l' */
#define __list_add_last( l, object ) do {			\
    cell c;							\
    __new_cell( c );						\
    c->prev = (l)->prev;					\
    c->next = (l);						\
    (l)->prev->next = c;					\
    (l)->prev = c;						\
    c->content = malloc( sizeof( object ) );			\
    c->csz = sizeof(object);					\
    memcpy( c->content, &(object), sizeof( object) );		\
    __list_incr_count( l );					\
} while(0)

/* Add 'object' in 'l' based on increasing values of 'index' */
#define __list_add_by_index( l, object, index ) do {			\
    cell c;								\
    cell i = (l)->next;							\
    while( i->content && (object).index > __idx_value( i->content, object, index ) ) \
      i = i->next;							\
    i = i->prev;							\
    __new_cell( c );							\
    c->next = (i)->next;						\
    c->prev = (i);							\
    (i)->next->prev = c;						\
    (i)->next = c;							\
    c->content = malloc( sizeof( object ) );				\
    c->csz = sizeof(object);					\
    memcpy( c->content, &(object), sizeof( object) );			\
    __list_incr_count( l );						\
  } while ( 0 )

/* Add 'object' in 'l' based on decreasing values of 'index' */
#define __list_add_by_index_reverse( l, object, index ) do {		\
    cell c;								\
    cell i = (l)->next;							\
    while( i->content && (object).index < __idx_value( i->content, object, index ) ) \
      i = i->next;							\
    i = i->prev;							\
    __new_cell( c );							\
    c->next = (i)->next;						\
    c->prev = (i);							\
    (i)->next->prev = c;						\
    (i)->next = c;							\
    c->content = malloc( sizeof( object ) );				\
    c->csz = sizeof(object);					\
    memcpy( c->content, &(object), sizeof( object) );			\
    __list_incr_count( l );						\
  } while ( 0 )

/* Delete first 'object' from 'l' based on matching value of 'index' */
#define __list_del_first_by_index( l, object, idx ) do {		\
    cell c;								\
    cell i = (l)->next;							\
    while( i->content && (object).idx != __idx_value( i->content, object, idx ) ) \
      i = i->next;							\
    if ( &(object) )							\
      memcpy( &(object), (i)->next->content, sizeof( (object) ) );	\
    if ( (i)->next->content ) {						\
      free( (i)->next->content );					\
      c = (i)->next;							\
      (i)->next->next->prev = (i);					\
      (i)->next = (i)->next->next;					\
      free( c );							\
      __list_decr_count( l );						\
    }									\
  } while ( 0 ) 

/* Delete all 'object' from 'l' based on matching value of 'index' */
#define __list_del_all_by_index( l, object, idx ) do {			\
    cell i = (l)->next, c;						\
    while( i->content ) {						\
      if ( (object).idx==__idx_value(i->content,object,idx) ) {		\
	if ( &(object) )						\
	  memcpy( &(object), i->content, sizeof( (object) ) );		\
	free( i->content );						\
	c = i;								\
	i->next->prev = i->prev;					\
	i->prev->next = i->next;					\
	free( c );							\
	__list_decr_count( l );						\
      }									\
      i = i->next;							\
    }									\
  } while ( 0 )

/* Walking through a list forward */
#define __list_foreach_forward( l, i )				\
  for( (i)=(l)->next; (i)->content; (i) = (i)->next ) 

/* Walking through a list backward */
#define __list_foreach_reverse( l, i )				\
  for( (i)=(l)->prev; (i)->content; (i) = (i)->prev ) 

/* Walking through a list: default is forward */
#define __list_foreach( l, i ) __list_foreach_forward( l, i )

/* Print a list */
#define _save_list_print( l ) do {					\
    cell c;								\
    head hl = __get_header(l);						\
    unsigned int sz = sizeof(*hl)+(hl->h.lname)?1+strlen(hl->h.lname):0; \
    unsigned int csz = 0;						\
    __list_print_header( l );						\
    __list_foreach( l, c ) {						\
      __cell_print( c, hl->h.out );					\
      csz+= c->csz;							\
      sz+= sizeof(*c);							\
      }									\
  } while ( 0 )							

#define __list_print( l ) do {					\
    cell c;								\
    head hl = __get_header(l);						\
    unsigned int tsz = sizeof(*hl)+(hl->h.lname)?1+strlen(hl->h.lname):0; \
    unsigned int csz = 0;						\
    __list_print_header( l );						\
    __list_foreach( l, c ) {						\
      __cell_print( c, hl->h.out );					\
      csz+= c->csz;							\
      tsz+= sizeof(*c);							\
      }									\
    fprintf( hl->h.out, "Content total: %d bytes\n", csz );		\
  } while ( 0 )							

/* Delete first object in list 'l' */
#define __list_del_first( l, object ) do {				\
    cell c;								\
    if ( &(object) && (l)->next->content )				\
      memcpy( &(object), (l)->next->content, sizeof( (object) ) );	\
    if ( (l)->next->content ) {						\
      free( (l)->next->content );					\
      c = (l)->next;							\
      (l)->next->next->prev = (l);					\
      (l)->next = (l)->next->next;					\
      free( c );							\
      __list_decr_count( l );						\
    }									\
  } while ( 0 ) 

/* Delete last object in list 'l' */
#define __list_del_last( l, object ) do {				\
    cell c;								\
    if ( &(object) )							\
      memcpy( &(object), (l)->prev->content, sizeof( (object) ) );	\
    if ( (l)->prev->content ) {						\
      free( (l)->prev->content );					\
      c = (l)->prev;							\
      (l)->prev->prev->next = (l);					\
      (l)->prev = (l)->prev->prev;					\
      free( c );							\
      __list_decr_count( l );						\
    }									\
  } while ( 0 ) 

/* Delete first occurence of 'object' in 'l' */
#define __list_del_first_object( l, object ) do {			\
    cell i = (l)->next;							\
    while ( i->content && memcmp( i->content, &(object), sizeof(object) ) ) \
      i = i->next;							\
    i = i->prev;							\
    if ( (i)->next->content ) {						\
      cell c;								\
      free( (i)->next->content );					\
      c = (i)->next;							\
      (i)->next->next->prev = (i);					\
      (i)->next = (i)->next->next;					\
      free( c );							\
      __list_decr_count( l );						\
    }									\
  } while ( 0 )

/* Delete all occurences of 'object' in 'l' */
#define __list_del_all_object( l, object ) do {				\
    cell i = (l)->next;							\
    while ( i->content ) {						\
      if ( !memcmp( i->content, &(object), sizeof(object) ) ) {		\
	cell c;								\
	i = i->prev;							\
	free( (i)->next->content );					\
	c = i->next;							\
	(i)->next->next->prev = i;					\
	(i)->next = (i)->next->next;					\
	free( c );							\
	__list_decr_count( l );						\
      }									\
    i = i->next;							\
    }									\
  } while ( 0 )

/* Check whether 'object' belongs to 'l' */
/* At the end, 'found' contains -1 if 'object' is not found in 'l' */
/* Otherwise, it contains the index of the object in the list      */
#define __list_contains( l, object, found ) do {			\
    cell i = (l)->next;							\
    int f = -1;								\
    memcpy( &(found), &f, sizeof(f) );					\
    while ( i->content ) {						\
      f++;								\
      if ( !memcmp( i->content, &(object), sizeof(object) ) ) {		\
	memcpy( &(found), &f, sizeof(f) );				\
	break;								\
      }									\
      i = i->next;							\
    }									\
  } while ( 0 )

/* Free memory allocated to the list */
#define __list_delete( l ) do {						\
    unsigned int cnt;							\
    cell c;								\
    head hl = (head)( (char *)l-sizeof( (hl->h)) );			\
    __list_get_count( l, cnt );						\
    while( cnt ) {							\
      free( (l)->next->content );					\
      c = (l)->next;							\
      (l)->next->next->prev = (l);					\
      (l)->next = (l)->next->next;					\
      free( c );							\
      __list_decr_count( l );						\
      __list_get_count( l, cnt );					\
    }									\
    if ( hl->h.lname ) {						\
      free( hl->h.lname );						\
      hl->h.lname = NULL;						\
    }									\
    free( hl );								\
  } while( 0 ) 

/* Apply function 'function' to all objects in 'l' */
#define __list_apply_function( l, function ) do {	\
    cell c;						\
    __list_foreach_forward( l, c ) {			\
      function( (c)->content );				\
    }							\
  } while ( 0 )

/* Compare whether two lists are equal */
/* At the end, 'comp' == 0 is the lists are equal, otherwise        */
/* 'comp' == 1 if lists have equal number of- but different objects */
/* or if list 'l2' has fewer elements than 'l1'                     */
/* 'comp' == -1 else */
#define __list_compare(l1,l2,comp) do {		\
    unsigned int s1, s2;			\
    __list_get_count( l1, s1 );			\
    __list_get_count( l2, s2 );			\
    if ( s1 < s2 ) {				\
      s1 = -1;					\
      memcpy( &(comp), &s1, sizeof(comp) );	\
    }						\
    if ( s1 > s2 ) {				\
      s2 = 1;					\
      memcpy( &(comp), &s2, sizeof(comp) );	\
    }						\
    if ( s1==s2 ) {				\
      unsigned int t = 0;			\
      cell c1 = (l1)->next, c2 = (l2)->next;	\
      while ( (c1)->content ) {						\
	if ( (c1)->csz == (c2)->csz && !memcmp((c1)->content,(c2)->content, (c1)->csz)) { \
	  c1 = c1->next;						\
	  c2 = c2->next;						\
	}								\
	else {								\
	  t = 1;							\
	  break;							\
	}								\
      }									\
      memcpy( &(comp), &t, sizeof(t) );					\
    }									\
  } while ( 0 )

/* Append list 'l2' at the end of list 'l1' */
#define __list_append( l1, l2 ) do {		\
    head hl1 = __get_header(l1);		\
    head hl2 = __get_header(l2);		\
    l1->prev->next = l2->next;			\
    l2->next->prev = l1->prev;			\
    l2->prev->next = l1;			\
    hl1->h.count += hl1->h.count;		\
    l2 = &(hl2->data);				\
    if ( hl2->h.lname ) free( hl2->h.lname );	\
    free( hl2 );				\
  } while ( 0 ) 

/* Proceed to fusion of lists 'l1' & 'l2'. Resulting list contains */ 
/* unique occurences of each element                               */
#define __list_fusion( l1, l2 ) do {					\
    cell cc;								\
    __list_foreach( l2, cc ) {						\
      unsigned int prst = 0;						\
      cell c;								\
      __list_foreach( l1, c ) {						\
	if ( !memcmp( cc->content, c->content, sizeof(c->csz) ) )	\
	  prst = 1;							\
      }									\
      if ( !prst ) {							\
	cell t;								\
	__new_cell( t );						\
	t->content = malloc( cc->csz );					\
	t->csz = cc->csz;						\
	t->prev = (l1)->prev;						\
	t->next = (l1);							\
	(l1)->prev->next = t;						\
	(l1)->prev = t;							\
	memcpy( t->content, cc->content, cc->csz );			\
	__list_incr_count(l1);						\
      }									\
    }									\
  } while ( 0 )

/* Create list 'l1' and copy 'l2' into it */
#define __list_copy( l1, l2 ) do {					\
      cell i;								\
      head hl2 = __get_header( l2 );					\
      __list_init( l1 );						\
      __list_foreach( l2, i ) {						\
	cell c;								\
	__new_cell( c );						\
	c->prev = (l1)->prev;						\
	c->next = (l1);							\
	(l1)->prev->next = c;						\
	(l1)->prev = c;							\
	c->content = malloc( i->csz );					\
	c->csz = i->csz;						\
	memcpy( c->content, i->content, c->csz );			\
      }									\
      __list_set_count( l1, hl2->h.count );				\
      if ( hl2->h.lname ) __list_set_name( l1, hl2->h.lname );		\
  } while ( 0 )

/* Uniquely insert 'object' into 'l' */
#define __list_insert_once( l,object ) do {				\
    unsigned int prst = 0;						\
    cell c;								\
    __list_foreach( l, c ) {						\
      if ( !memcmp( &(object), c->content, sizeof(object) ) && sizeof(object)==c->csz ) \
	prst = 1;							\
    }									\
    if ( !prst ) __list_add_first( l, object );				\
  } while ( 0 )

/* Delete redundant occurences of objects in 'l' */
#define __list_only_once( l ) do {					\
    list r;								\
    cell c;								\
    unsigned int cnt;							\
    __list_get_count( l, cnt );						\
    if ( cnt < 2 ) break;						\
    __list_init( r );							\
    __new_cell( c );							\
    c->next = r->next;							\
    c->prev = r;							\
    r->next->prev = c;							\
    r->next = c;							\
    c->content = malloc( l->next->csz );				\
    c->csz = l->next->csz;						\
    memcpy( c->content, l->next->content, l->next->csz );		\
    __list_incr_count( r );						\
    __list_foreach( l, c ) {						\
      cell tt;								\
      unsigned int prsnt = 0;						\
      __list_foreach( r, tt ) {						\
	if ( !memcmp( tt->content, c->content, c->csz ) && tt->csz==c->csz ) \
	  prsnt = 1;							\
      }									\
      if ( !prsnt ) {							\
	cell t;								\
	__new_cell( t );						\
	t->next = r->next;						\
	t->prev = r;							\
	r->next->prev = t;						\
	r->next = t;							\
	t->content = malloc( c->csz );					\
	t->csz = c->csz;						\
	memcpy( t->content, c->content, c->csz );			\
	__list_incr_count( r );						\
      }									\
    }								        \
    __list_delete( l );							\
    l = r;								\
  } while ( 0 )

/* At the end, 'l1' contains 'l1'-'l2' */
#define __list_minus(l1,l2) do {					\
    cell c;								\
    list cl1, cl2;							\
    list r;								\
    __list_init( r );							\
    __list_copy( cl1, l1 );						\
    __list_copy( cl2, l2 );						\
    __list_only_once( cl1 );						\
    __list_only_once( cl2 );						\
    __list_foreach(cl2,c) {						\
      cell cc;								\
      __list_foreach( cl1,cc ) {					\
	if ( !memcmp(c->content, cc->content, c->csz) && c->csz==cc->csz ) { \
	  cell t;							\
	  __new_cell( t );						\
	  t->next = r->next;						\
	  t->prev = r;							\
	  r->next->prev = t;						\
	  r->next = t;							\
	  t->content = malloc( c->csz );				\
	  t->csz = c->csz;						\
	  memcpy( t->content, c->content, c->csz );			\
	  __list_incr_count( r );					\
	}								\
      }									\
    }									\
    __list_delete( l1 );						\
    __list_delete( cl2 );						\
    __list_delete( cl1 );						\
    l1 = r;								\
  } while ( 0 )
    
/**************************************************************************************/

/* List interface */

#define list_init(l) __list_init(l)
#define list_set_name(l,name) __list_set_name(l,name)
#define list_get_count(l,cnt) __list_get_count(l, cnt)
#define list_set_count(l,cnt) __list_set_count(l, cnt)
#define list_set_output(l,file) __list_set_output(l,file)
#define list_is_empty(l,empty) __list_is_empty(l,empty)
#define list_add_first(l,object) __list_add_first(l,object)
#define list_add_last(l,object) __list_add_last(l,object)
#define list_add_by_index(l,object,index) __list_add_by_index(l,object,index)
#define list_add_by_index_reverse(l,object,index) __list_add_by_index_reverse(l,object,index)
#define list_del_first_by_index(l,object,index) __list_del_first_by_index(l,object,index)
#define list_del_all_by_index(l,object,index) __list_del_all_by_index(l,object,index)
#define list_foreach(l,i) __list_foreach(l,i)
#define list_foreach_reverse(l,i) __list_foreach_reverse(l,i)
#define list_print(l) __list_print(l)
#define list_del_first(l,object) __list_del_first(l,object)
#define list_del_last(l,object) __list_del_last(l,object)
#define list_delete(l) __list_delete(l)
#define list_apply_function(l,function) __list_apply_function(l,function)
#define list_compare(l1,l2,comp) __list_compare(l1,l2,comp)
#define list_del_first_object(l,object) __list_del_first_object(l,object)
#define list_del_all_object(l,object) __list_del_all_object(l,object)
#define list_contains(l,object,found) __list_contains(l,object,found)
#define list_append(l1,l2) __list_append(l1,l2)
#define list_fusion(l1,l2) __list_fusion(l1,l2)
#define list_copy(l1,l2) __list_copy(l1,l2)
#define list_insert_once(l,object) __list_insert_once(l,object)
#define list_only_once(l) __list_only_once(l)

#define fifo_init(f) __list_init(f)
#define fifo_push(f,object) __list_add_first(f,object)
#define fifo_pop(f,object) __list_del_last(f,object)
#define fifo_delete(f) __list_delete(f)

#define lifo_init(l) __list_init(l)
#define lifo_push(l,object) __list_add_first(l,object)
#define lifo_pop(l,object) __list_del_first(l,object)
#define lifo_delete(l) __list_delete(l) 

/**************************************************************************************/

/* A hash lookup table (HLT) enjoys a header */
typedef struct hash_header_t {
  char * hname;                /* A HLT can have a name                    */
  FILE * out;                  /* Where to print info from the HLT         */
  unsigned int count;          /* Log2 of the number of buckets of the HLT */
} hash_header; 

/* A HLT is basically a header and a list array */
typedef struct hash_t {
  hash_header h; 
  list * data; 
} * hash; 

/*
  // Begin Bob Jenkins code for hashlittle2() hash function
 */

/* My best guess at if you are big-endian or little-endian.  
 * This may need adjustment.
 */
#if (defined(__BYTE_ORDER) && defined(__LITTLE_ENDIAN) && \
     __BYTE_ORDER == __LITTLE_ENDIAN) || \
    (defined(i386) || defined(__i386__) || defined(__i486__) || \
     defined(__i586__) || defined(__i686__) || defined(vax) || defined(MIPSEL))
# define HASH_LITTLE_ENDIAN 1
# define HASH_BIG_ENDIAN 0
#elif (defined(__BYTE_ORDER) && defined(__BIG_ENDIAN) && \
       __BYTE_ORDER == __BIG_ENDIAN) || \
      (defined(sparc) || defined(POWERPC) || defined(mc68000) || defined(sel))
# define HASH_LITTLE_ENDIAN 0
# define HASH_BIG_ENDIAN 1
#else
# define HASH_LITTLE_ENDIAN 0
# define HASH_BIG_ENDIAN 0
#endif

#define bj_hashsize(n) ((uint32_t)1<<(n))
#define bj_hashmask(n) (bj_hashsize(n)-1)
#define bj_rot(x,k) (((x)<<(k)) | ((x)>>(32-(k))))

#define bj_mix(a,b,c) do {	       \
  a -= c;  a ^= bj_rot(c, 4);  c += b; \
  b -= a;  b ^= bj_rot(a, 6);  a += c; \
  c -= b;  c ^= bj_rot(b, 8);  b += a; \
  a -= c;  a ^= bj_rot(c,16);  c += b; \
  b -= a;  b ^= bj_rot(a,19);  a += c; \
  c -= b;  c ^= bj_rot(b, 4);  b += a; \
} while ( 0 )

#define bj_final(a,b,c) do {			\
  c ^= b; c -= bj_rot(b,14);			\
  a ^= c; a -= bj_rot(c,11);			\
  b ^= a; b -= bj_rot(a,25);			\
  c ^= b; c -= bj_rot(b,16);			\
  a ^= c; a -= bj_rot(c,4);			\
  b ^= a; b -= bj_rot(a,14);			\
  c ^= b; c -= bj_rot(b,24);			\
} while ( 0 ) 

#define hashlittle2( key, len, pc, pb) do {				\
    uint32_t ext=0,a,b,c,length=(len);					\
    union { const void *ptr; size_t i; } u;				\
    a = b = c = 0xdeadbeef + ((uint32_t)length);			\
    u.ptr = (void*)key;							\
    if (HASH_LITTLE_ENDIAN && ((u.i & 0x3) == 0)) {			\
      const uint32_t *k = (const uint32_t *)(key);			\
      while (length > 12)						\
	{								\
	  a += k[0];							\
	  b += k[1];							\
	  c += k[2];							\
	  bj_mix(a,b,c);						\
	  length -= 12;							\
	  k += 3;							\
	}								\
      switch(length)							\
	{								\
	case 12: c+=k[2]; b+=k[1]; a+=k[0]; break;			\
	case 11: c+=k[2]&0xffffff; b+=k[1]; a+=k[0]; break;		\
	case 10: c+=k[2]&0xffff; b+=k[1]; a+=k[0]; break;		\
	case 9 : c+=k[2]&0xff; b+=k[1]; a+=k[0]; break;			\
	case 8 : b+=k[1]; a+=k[0]; break;				\
	case 7 : b+=k[1]&0xffffff; a+=k[0]; break;			\
	case 6 : b+=k[1]&0xffff; a+=k[0]; break;			\
	case 5 : b+=k[1]&0xff; a+=k[0]; break;				\
	case 4 : a+=k[0]; break;					\
	case 3 : a+=k[0]&0xffffff; break;				\
	case 2 : a+=k[0]&0xffff; break;					\
	case 1 : a+=k[0]&0xff; break;					\
	case 0 : memcpy(&(pc),&c,sizeof(c));				\
	  memcpy(&(pb),&b,sizeof(b));					\
	  ext = 1;							\
	}								\
      if ( ext ) break;							\
    } else if (HASH_LITTLE_ENDIAN && ((u.i & 0x1) == 0)) {		\
      const uint16_t *k = (const uint16_t *)(key);			\
      const uint8_t  *k8;						\
      while (length > 12)						\
	{								\
	  a += k[0] + (((uint32_t)k[1])<<16);				\
	  b += k[2] + (((uint32_t)k[3])<<16);				\
	  c += k[4] + (((uint32_t)k[5])<<16);				\
	  bj_mix(a,b,c);						\
	  length -= 12;							\
	  k += 6;							\
	}								\
      k8 = (const uint8_t *)k;						\
      switch(length)							\
	{								\
	case 12: c+=k[4]+(((uint32_t)k[5])<<16);			\
	  b+=k[2]+(((uint32_t)k[3])<<16);				\
	  a+=k[0]+(((uint32_t)k[1])<<16);				\
	  break;							\
	case 11: c+=((uint32_t)k8[10])<<16;     /* fall through */	\
	case 10: c+=k[4];						\
	  b+=k[2]+(((uint32_t)k[3])<<16);				\
	  a+=k[0]+(((uint32_t)k[1])<<16);				\
	  break;							\
	case 9 : c+=k8[8];                      /* fall through */	\
	case 8 : b+=k[2]+(((uint32_t)k[3])<<16);			\
	  a+=k[0]+(((uint32_t)k[1])<<16);				\
	  break;							\
	case 7 : b+=((uint32_t)k8[6])<<16;      /* fall through */	\
	case 6 : b+=k[2];						\
	  a+=k[0]+(((uint32_t)k[1])<<16);				\
	  break;							\
	case 5 : b+=k8[4];                      /* fall through */	\
	case 4 : a+=k[0]+(((uint32_t)k[1])<<16);			\
	  break;							\
	case 3 : a+=((uint32_t)k8[2])<<16;      /* fall through */	\
	case 2 : a+=k[0];						\
	  break;							\
	case 1 : a+=k8[0];						\
	  break;							\
	case 0 : memcpy(&(pc),&c,sizeof(c));				\
	  memcpy(&(pb),&b,sizeof(b));					\
	  ext = 1;							\
	}								\
      if ( ext ) break;							\
    } else {								\
      const uint8_t *k = (const uint8_t *)(key);			\
      while (length > 12)						\
	{								\
	  a += k[0];							\
	  a += ((uint32_t)k[1])<<8;					\
	  a += ((uint32_t)k[2])<<16;					\
	  a += ((uint32_t)k[3])<<24;					\
	  b += k[4];							\
	  b += ((uint32_t)k[5])<<8;					\
	  b += ((uint32_t)k[6])<<16;					\
	  b += ((uint32_t)k[7])<<24;					\
	  c += k[8];							\
	  c += ((uint32_t)k[9])<<8;					\
	  c += ((uint32_t)k[10])<<16;					\
	  c += ((uint32_t)k[11])<<24;					\
	  bj_mix(a,b,c);						\
	  length -= 12;							\
	  k += 12;							\
	}								\
      switch(length)							\
	{								\
	case 12: c+=((uint32_t)k[11])<<24;				\
	case 11: c+=((uint32_t)k[10])<<16;				\
	case 10: c+=((uint32_t)k[9])<<8;				\
	case 9 : c+=k[8];						\
	case 8 : b+=((uint32_t)k[7])<<24;				\
	case 7 : b+=((uint32_t)k[6])<<16;				\
	case 6 : b+=((uint32_t)k[5])<<8;				\
	case 5 : b+=k[4];						\
	case 4 : a+=((uint32_t)k[3])<<24;				\
	case 3 : a+=((uint32_t)k[2])<<16;				\
	case 2 : a+=((uint32_t)k[1])<<8;				\
	case 1 : a+=k[0];						\
	  break;							\
	case 0 : memcpy(&(pc),&c,sizeof(c));				\
	  memcpy(&(pb),&b,sizeof(b));					\
	  ext = 1;							\
	}								\
      if ( ext ) break;							\
    }									\
    bj_final(a,b,c);							\
    memcpy(&(pc),&c,sizeof(c));						\
    memcpy(&(pb),&b,sizeof(b));						\
  } while (0)

/*
  // End Bob Jenkins code for hashlittle2() hash function
 */

/* Init HLT with 2^log2buckets buckets */
#define __hash_init( h, log2buckets ) do {				\
    unsigned int i;							\
    (h) = malloc( sizeof( *(h) ) );					\
    (h)->h.count = log2buckets>32?32:log2buckets;			\
    (h)->h.out = __HLIST_OUTPUT;					\
    (h)->h.hname = NULL;						\
    (h)->data = malloc( (1<<(h)->h.count)*sizeof(struct cell_t) );	\
    for ( i= 0; i< (1<<(h)->h.count); i++ ) list_init( (h)->data[i] );	\
  } while ( 0 )

/* Set output file descriptor for HLT (use fopen!) */
#define __hash_set_output( l, file ) do {		\
    fprintf( stderr, "Warning: Changing output!\n" );	\
    (h)->h.out = (file);				\
  } while( 0 )

/* Set HLT name */
#define __hash_set_name( h, newname ) do {				\
    unsigned int i, len;						\
    len = strlen(newname)+1<__HLIST_MAXLEN?strlen(newname):__HLIST_MAXLEN; \
    if ( (h)->h.hname )							\
      {									\
	fprintf( stderr, "Warning: Changing name!\n" );			\
	free( (h)->h.hname );						\
      }									\
    (h)->h.hname = malloc( (1+strlen(newname))*sizeof(char) );		\
    for ( i= 0; i< len; i++ ) (h)->h.hname[i] = newname[i];		\
    (h)->h.hname[i] = '\0';						\
  } while ( 0 )								\

/* Delete HLT from memory */
#define __hash_delete( h ) do {			\
    unsigned int i;				\
    for ( i= 0; i< (1<<(h)->h.count); i++ )	\
      list_delete( (h)->data[i] );		\
    if ( (h)->h.hname ) free( (h)->h.hname );	\
    free( h );					\
  } while ( 0 ) 

/* Print HLT (mostly useless if a lot of buckets) */
#define __hash_print( h ) do {						\
    unsigned int i;							\
    if ( (h)->h.hname )							\
      fprintf( (h)->h.out, "Hash %s @ %p ", (h)->h.hname, (void*)(h) );	\
    else								\
      fprintf( (h)->h.out, "Hash @ %p ", (void*)(h) );			\
    fprintf( (h)->h.out, "(%d buckets)\n", (1<<(h)->h.count) );		\
    for ( i= 0; i< (1<<(h)->h.count); i++ )				\
      list_print( (h)->data[i] );					\
  } while ( 0 ) 

/* Interface function to plug desired hash function */
#define __hash_bytes( data, start, len, h ) do {		\
    unsigned int h2;						\
    hashlittle2( (((char*)data)+start), len, h, h2 );	        \
  } while ( 0 )

/*
  In case somebody feels better with Pearson's hash, the code is right here. 
 */
/*
  #define __hash_bytes_save( data, start, len, h ) do {			\
  unsigned int i;							\
  unsigned char * p, res;						\
  unsigned char T[256] = { 77, 175, 85, 225, 174, 222, 120, 192, 66, 233, 198, 7, 116, 227, 229, 15, 248, 68, 99, 156, 195, 254, 98, 148, 164, 177, 171, 196, 124, 8, 224, 179, 72, 191, 137, 5, 65, 31, 226, 106, 144, 142, 113, 205, 208, 219, 97, 63, 131, 34, 30, 193, 223, 41, 44, 145, 12, 215, 178, 154, 251, 181, 19, 117, 230, 82, 52, 188, 58, 108, 92, 55, 36, 47, 10, 20, 221, 139, 109, 57, 236, 59, 46, 134, 93, 35, 146, 190, 252, 105, 169, 38, 228, 234, 189, 199, 180, 138, 115, 152, 13, 214, 173, 79, 111, 23, 73, 112, 232, 182, 75, 28, 141, 172, 122, 110, 130, 86, 2, 201, 14, 114, 140, 125, 95, 161, 220, 184, 162, 81, 119, 241, 153, 87, 69, 247, 48, 200, 94, 70, 88, 61, 255, 103, 136, 32, 27, 11, 202, 194, 17, 107, 235, 118, 22, 26, 91, 3, 209, 186, 100, 24, 183, 104, 167, 123, 207, 42, 90, 143, 217, 6, 4, 9, 132, 101, 237, 150, 168, 206, 102, 29, 80, 155, 62, 187, 51, 231, 64, 33, 239, 128, 163, 74, 43, 157, 253, 165, 160, 50, 54, 204, 147, 53, 16, 197, 121, 170, 216, 84, 151, 45, 21, 240, 127, 211, 56, 89, 40, 129, 166, 1, 133, 245, 76, 238, 176, 159, 18, 0, 243, 96, 158, 185, 149, 37, 49, 67, 135, 25, 218, 242, 83, 246, 249, 39, 250, 126, 213, 203, 78, 212, 210, 71, 60 }; \
  for ( res = 0, i= 0, p = ((unsigned char *)data)+start; i< len; res = T[res^p[i++]] ); \
  memcpy( &(h), &res, sizeof(unsigned char) );				\
  } while ( 0 )
*/

/* Fit hash function result to required bit number */
#define __hash_fit( h, hash ) do {			\
    unsigned int hfit = hash & ( (1<<(h)->h.count)-1 );	\
    memcpy( &hash, &hfit, sizeof(hash) );		\
  } while ( 0 ) 

/* Hash entire object */
#define __hash_object( object, hash ) __hash_bytes( &(object), 0, sizeof(object), hash )

/* Hash objects from 'key' element of 'object' */
#define __hash_from_key( object, key, hash ) __hash_bytes( &((object).key), (((char*)&((object).key))-((char*)&(object))), sizeof((object).key), hash )

/* Insert object into HLT */
#define __hash_insert_object( h, object ) do {		\
    unsigned int hash=0;				\
    __hash_object( object, hash );			\
    __hash_fit( h, hash );				\
    list_add_first( (h)->data[hash], object );		\
  } while ( 0 ) 

/* Remove object from HLT */
#define __hash_remove_object( h, object ) do {		\
    unsigned int hash=0;				\
    __hash_object( object, hash );			\
    __hash_fit( h, hash );				\
    list_del_all_object((h)->data[hash],object);	\
  } while ( 0 ) 

/* Check whether object belongs to HLT        */
/* See values for found in the list interface */
/* -1 means 'object' does not belong to HLT   */
#define __hash_lookup_object( h, object, found ) do {	\
    unsigned int hash=0;				\
    __hash_object( object, hash );			\
    __hash_fit( h, hash );				\
    list_contains((h)->data[hash],object,found);	\
  } while ( 0 ) 

/* Insert object into HLT based on 'key' value */
#define __hash_insert_from_key( h, object, key ) do {	\
    unsigned int hash=0;				\
    __hash_from_key( object, key, hash );		\
    __hash_fit( h, hash );				\
    list_add_first( (h)->data[hash], object );		\
  } while ( 0 ) 

/* Remove all object occurences from HLT based on 'key' */
#define __hash_remove_from_key( h, object, key ) do {	\
    unsigned int hash=0;				\
    __hash_from_key( object, key, hash );		\
    __hash_fit( h, hash );				\
    list_del_all_object((h)->data[hash],object);	\
  } while ( 0 ) 

/* Check whether object belongs to HLT base on 'key' */
/* See values for found in the list interface        */
/* -1 means 'object' does not belong to HLT          */
#define __hash_lookup_from_key( h, object, key, found ) do {	\
    unsigned int hash=0;					\
    __hash_from_key( object, key, hash );			\
    __hash_fit( h, hash );					\
    list_contains((h)->data[hash],object,found);		\
  } while ( 0 ) 

/* Hash lookup table interface */

#define hash_init(h, l2b) __hash_init(h, l2b) 
#define hash_set_name(h,name) __hash_set_name(h,name)
#define hash_set_output(h,out) __hash_set_name(h,out)
#define hash_print(h) __hash_print(h) 
#define hash_insert_object(h,object) __hash_insert_object(h,object)
#define hash_remove_object(h,object) __hash_remove_object(h,object)
#define hash_lookup_object(h,object,found) __hash_lookup_object(h,object,found)
#define hash_insert_from_key(h,object,key) __hash_insert_from_key(h,object,key)
#define hash_remove_from_key(h,object,key) __hash_remove_from_key(h,object,key)
#define hash_lookup_from_key(h,object,key,found) __hash_lookup_from_key(h,object,key,found)
#define hash_delete(h) __hash_delete(h)

#endif /* __it_hlist */
