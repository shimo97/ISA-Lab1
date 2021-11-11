#include<stdio.h>
#include<stdlib.h>

#define N 1 /// order of the filter 
#define NB 7  /// number of bits

const int b0 = 861>>5; /// coefficient b0
const int b[N]={861>>5}; /// b array
const int a[N]={-(325>>5)}; /// a array

/// Perform fixed point filtering assuming direct form II
///\param x is the new input sample
///\return the string to print on output file
//prints the log (computation passages) inside log file
int myfilter(int x, FILE *fp_log)
{
  static int sw[N]; /// w shift register
  static int first_run = 0; /// for cleaning the shift register
  int i; /// index
  int w; /// intermediate value (w)
  int y; /// output sample
  int fb, ff; /// feed-back and feed-forward results

  /// clean the buffer
  if (first_run == 0)
  {
    first_run = 1;
    for (i=0; i<N; i++)
      sw[i] = 0;
  }
  
  fprintf(fp_log,"%d\t", x);

  /// compute feed-back and feed-forward
  fb = 0;
  ff = 0;
  for (i=0; i<N; i++)
  {
    fb -= (sw[i]*a[i]) >> (NB-1);
    ff += (sw[i]*b[i]) >> (NB-1);
  }

  
  /// compute intermediate value (w) and output sample
  w = x + fb;
  y = (w*b0) >> (NB-1);
  y += ff;

  fprintf(fp_log,"%d\t", w);
  for(i=0;i<N;i++){
    fprintf(fp_log,"%d\t", sw[i]);
  }
  /// update the shift register
  for (i=N-1; i>0; i--){
    sw[i] = sw[i-1];
  }
  sw[0] = w;
  
  fprintf(fp_log,"%d\n", y);

  return y;
}

int main (int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;
  FILE *fp_log;

  int x;
  int y;
  int i;

  /// check the command line
  if (argc != 4)
  {
    printf("Use: %s <input_file> <output_file> <log_file>\n", argv[0]);
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
  fp_log = fopen(argv[3], "w");

  fprintf(fp_log,"b0: %d\n", b0);
  fprintf(fp_log,"b: { ");
  for (i=1; i<=N; i++)
  {
    fprintf(fp_log," %d,", b[i-1]);
  }
  fprintf(fp_log," }\n");

  fprintf(fp_log,"a: { ");
  for (i=1; i<=N; i++)
  {
    fprintf(fp_log," %d,", a[i-1]);
  }
  fprintf(fp_log," }\n");
 
  fprintf(fp_log,"IN\t");
  for (i=0; i<=N; i++)
  {
    fprintf(fp_log,"s[%d]\t", i);
  }
  fprintf(fp_log,"OUT\n");
  
  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do{
    x=x>>5;
    y = myfilter(x,fp_log)<<4;
    fprintf(fp_out,"%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;

}
