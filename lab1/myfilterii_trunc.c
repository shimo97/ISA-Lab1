#include<stdio.h>
#include<stdlib.h>

#define N 1 /// order of the filter 
#define NB 12  /// number of bits

const int b0 = 861; /// coefficient b0
const int b[N]={861}; /// b array
const int a[N]={-325}; /// a array
  int of_cnt; //overflow counter

//perform N bit truncation of a value, increasing global variable of_cnt in case of overflow
int truncate(int val){
  int mask=(1<<NB) - 1;
  int tmp=val & mask;
  if(val<0){
    tmp+=(~mask);
  }
  if(tmp!=val){
    of_cnt++;
  }
  //printf("Truncating %d to %d\n",val,tmp);
  return tmp;
}

/// Perform fixed point filtering assuming direct form II
///\param x is the new input sample
///\return the new output sample
int myfilter(int x)
{
  static int sw[N]; /// w shift register
  static int first_run = 0; /// for cleaning the shift register
  int i; /// index
  int w; /// intermediate value (w)
  int y; /// output sample
  int fb, ff,fb_tmp,ff_tmp,tmp; /// feed-back and feed-forward results


  /// clean the buffer
  if (first_run == 0)
  {
    first_run = 1;
    of_cnt=0;
    for (i=0; i<N; i++)
      sw[i] = 0;
  }

  /// compute feed-back and feed-forward
  fb = 0;
  ff = 0;
  fb_tmp=0;
  ff_tmp=0;
  for (i=0; i<N; i++)
  {
    
    fb_tmp -= (sw[i]*a[i]) >> (NB-1);
    
    ff_tmp += (sw[i]*b[i]) >> (NB-1);
    
  }
  fb=truncate(fb_tmp);
  ff=truncate(ff_tmp);
  

  /// compute intermediate value (w) and output sample
  tmp=x+fb;
  w = truncate(tmp);
  y = (w*b0) >> (NB-1);
  y += ff;
  y=truncate(y);

  /// update the shift register
  for (i=N-1; i>0; i--)
    sw[i] = sw[i-1];
  sw[0] = w;
 
  return y;
}

int main (int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;

  int x;
  int y;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n",argv[1]);
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do{
    y = myfilter(x);
    fprintf(fp_out,"%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  printf("There were %d overflows during sum operations\n",of_cnt);

  return 0;

}
