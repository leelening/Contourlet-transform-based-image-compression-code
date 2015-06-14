#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <it/vec.h>
#include <it/io.h>
#include <it/arithmetic_codec.h>
#include <it/random.h>
#include <it/source.h>
#include <it/source_func.h>

#define LENGTH 1000
#define COUNT 1000
#define PRECISION 9

int main (void)
{
  arithmetic_coder_t *coder;
  arithmetic_decoder_t *decoder;
  int  i, count;
  vec  prob0;
  ivec data;
  ivec dec;
  vec  pdf;
  bvec buffer;
  int  rate;
  float mean_entropy, mean_rate;

  /*  it_randomize(); */

  data = ivec_new (LENGTH);
  dec = ivec_new (LENGTH);

  buffer = bvec_new (10 * LENGTH);

  /* create the coder and decoder */
  coder = arithmetic_coder_new (PRECISION);
  decoder = arithmetic_decoder_new (PRECISION);

  /*** binary arithmetic coding ***/

  mean_entropy = mean_rate = 0;
  for (count = 0; count < COUNT; count++) {

    /* some random source distribution */
    prob0 = source_uniform (LENGTH, 0, 1);

    for (i = 0; i < LENGTH; i++) {
      mean_entropy +=
	-(prob0[i] * log (prob0[i]) +
	  (1.0 - prob0[i]) * log (1.0 - prob0[i])) / log (2);
    }

    for (i = 0; i < LENGTH; i++)
      data[i] = (it_rand () > prob0[i]);

    /*
       printf("data: ");
       for(i = 0; i < LENGTH; i++)
       printf("%d", data[i]);
       printf("\n");
     */

    /* encode */
    arithmetic_coder_start (coder, buffer);
    for (i = 0; i < LENGTH; i++)
      arithmetic_coder_encode_bit (coder, prob0[i], data[i]);
    rate = arithmetic_coder_stop (coder);

    /* decode */
    arithmetic_decoder_start (decoder, buffer);
    for (i = 0; i < LENGTH; i++) {
      dec[i] = arithmetic_decoder_decode_bit (decoder, prob0[i]);
      if (dec[i] != data[i])
	printf ("error at bit %d\n", i);
    }
    if (rate != arithmetic_decoder_stop (decoder))
      printf ("decoding error\n");

    mean_rate += rate;

    /*
       printf("data: ");
       for(i = 0; i < LENGTH; i++)
       printf("%d", dec[i]);
       printf("\n");
     */

    vec_delete (prob0);
  }
  printf ("entropy: %.4f bits\n", ((float) mean_entropy) / (LENGTH * COUNT));
  printf ("rate: %.4f bits\n", ((float) mean_rate) / (LENGTH * COUNT));

  ivec_delete (data);

  /*** symbolic arithmetic coding ***/

  /* Define Maxted and Robinson source */
  pdf = vec_new_string ("0.4 0.2 0.2 0.1 0.1");

  /* generate a vector of LENGTH samples */
  data = source_memoryless (LENGTH, pdf);

  arithmetic_coder_start (coder, buffer);
  for (i = 0; i < LENGTH; i++)
    arithmetic_coder_encode_symbol (coder, pdf, data[i]);
  rate = arithmetic_coder_stop (coder);

  arithmetic_decoder_start (decoder, buffer);
  for (i = 0; i < LENGTH; i++) {
    dec[i] = arithmetic_decoder_decode_symbol (decoder, pdf);
    if (dec[i] != data[i])
      printf ("error at bit %d\n", i);
  }
  if (rate != arithmetic_decoder_stop (decoder))
    printf ("decoding error\n");

  printf ("entropy: %.4f bits\n", entropy (pdf));
  printf ("rate: %.4f bits\n", (float) rate / LENGTH);

  /* release resources */
  arithmetic_coder_delete (coder);
  arithmetic_decoder_delete (decoder);

  ivec_delete (data);
  ivec_delete (dec);

  return (0);
}
