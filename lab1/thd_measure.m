fileIN = fopen('output.txt','r');
format = '%d'
VAL= fscanf(fileIN,format);
thd(VAL)
fclose(fileIN);