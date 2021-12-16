/*-----RAW2VHDL
    This program will read in input file representing a raw netlist (see raw_net_rules.txt for more information) and
    convert it in a VHDL netlist
*/
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

#define IN_N 100//number of possible different input PREFIXES (vectors have the same prefix for all bits)
#define OUT_N 20//number of possible different output PREFIXES (vectors have the same prefix for all bits)
#define LINE_LEN 256//length of read line

char IN_FILENAME[]="netlist_raw.txt";  //input file with raw netlist
char OUT_FILENAME[]="../src/dadda.vhd";    //output file

char libraries[]="LIBRARY ieee;\nUSE ieee.std_logic_1164.all;\nUSE ieee.numeric_std.all;\n";
char entity[]="DADDA";
char architecture[]="behavior";
char FA_port[]="(I1 : IN std_logic;\nI2 : IN std_logic;\nCin : IN std_logic;\nQ : OUT std_logic;\nCout : OUT std_logic);\n";
char HA_port[]="(I1 : IN std_logic;\nI2 : IN std_logic;\nQ : OUT std_logic;\nCout : OUT std_logic);\n";

char inputs[IN_N][16];
int inputs_num[IN_N];
char outputs[OUT_N][16];
int outputs_num[OUT_N];
int in_last=0;
int out_last=0;

char line[LINE_LEN];

//redefinition of non standard function itoa to use in linux (base will be ignored anyway)
void itoa(int d,char *str,int base){
	sprintf(str,"%d",d);
}

//function to parse a string into substrings, dividing it when delimiter is found (max 5 substrings of length 15 + \0 delimiter)
void parse(char str[],int len,char delimiter,char result[5][16]){
    int currLen=0;
    int currResult=0;
    int go=1;
    for(int c=0;c<len && go==1;c++){
        if(str[c]!=delimiter && currResult!=5){
            if(str[c]!='\n' && str[c]!='\0'){
                if(currLen!=16){
                    result[currResult][currLen++]=str[c];
                }else{
                    result[currResult][currLen]='\0';
                }
            }else{
                result[currResult][currLen]='\0';
                go=0;
            }

        }else{
            result[currResult][currLen]='\0';
            currLen=0;
            currResult++;
        }
    }
}
//function to clear a string removing the starting character
void clear(char from[LINE_LEN],char to[LINE_LEN-1]){
    int go=1;
    for(int c=0;c<LINE_LEN-1 && go==1;c++){
        to[c]=from[c+1];
        if(to[c]=='\0'){
            go=0;
        }
    }
}
//function to find a string into a string matrix
int findStr(char matrix[][16],int len,char str[16]){
//function to check if a signal is an upper case (std_logic_vector) circuit I/O, converting it into that format
//(eg. if Ai_4 is a circuit input the function convert it into Ai(4))
    int go=1;
    int foundpos=-1;
    for(int c=0;c<len && go==1;c++){
        int comparing=1;
        for(int ch=0;ch<15 && comparing==1;ch++){
            //printf("ch %d\n %c",ch,matrix[c][ch]);
            if(matrix[c][ch]!=str[ch]){
                comparing=0;
            }else if(matrix[c][ch]==str[ch] && str[ch]=='\0'){
                foundpos=c;
                go=0;
            }
        }
        //printf("%d\n",c);
    }
    return foundpos;
}

void convertIO(char name[16]){
    char tmpname[16];
    char parseres[5][16];
    if(name[0]!='-'){
        if(!islower(name[0])){  //if is upper
            parse(name,16,'_',parseres);    //parsing the prefix
            int retI=findStr(inputs,IN_N,parseres[0]);    //searching into I/O vectors
            int retO=findStr(outputs,OUT_N,parseres[0]);
            if(retI!=-1 || retO!=-1){
                strcpy(tmpname,parseres[0]);   //saving name
                strcat(tmpname,"(");
                strcat(tmpname,parseres[1]);
                strcat(tmpname,")");
                strcpy(name,tmpname);
            }
        }
    }else{
        strcpy(name,"open");
    }

}

int main(int argc, char **argv){
    printf("raw2VHDL - HELLO\n");
    FILE *fp_in;
    FILE *fp_out;

    printf("Opening input file\n");
    //input file
    fp_in = fopen(IN_FILENAME, "r");
    if (fp_in == NULL){
        printf("Error: cannot open %s\n",IN_FILENAME);
        exit(2);
    }
    fp_out = fopen(OUT_FILENAME, "w");
    if (fp_out == NULL){
        printf("Error: cannot open %s\n",OUT_FILENAME);
        exit(2);
    }

    printf("Starting VHDL generation\n");
    printf("Writing libraries\n");
    fprintf(fp_out,"%s\n",libraries);
    printf("Creating entity\n");
    fprintf(fp_out,"ENTITY %s IS\nPORT(\n",entity);
    //CREATE ENTITY PORTS
    //reset I/O matrix dimensions to all 0
    for(int i=0;i<IN_N;i++){
        inputs[i][0]='\0';
        inputs_num[i]=0;
    }
    for(int i=0;i<OUT_N;i++){
        outputs[i][0]='\0';
        outputs_num[i]=0;
    }
    char result[5][16];
    int first=1;
    char clearline[LINE_LEN-1]; //line without the starting character
    while(fgets(line,LINE_LEN,fp_in)!= NULL) {//file not end
        if(line[0]=='I' || line[0]=='O'){   //I or O found
            clear(line,clearline);
            parse(clearline,LINE_LEN,'_',result);

            //INPUT CASE
            //signal name prefix already present in I/O dimensions matrix?
            if(line[0]=='I'){
                int ret=findStr(inputs,IN_N,result[0]);
                if(ret==-1){//no
                    //insert signal prefix in matrix
                    ret=in_last;
                    strcpy(inputs[in_last++],result[0]);

                }
                //signal name is lower case?
                if(islower(result[0][0])){//yes
                    if(!first){
                        fprintf(fp_out,";\n");
                    }else{
                        first=0;
                    }
                    //write std_logic
                    fprintf(fp_out,"%s_%s : IN std_logic",result[0],result[1]);
                }else{//no
                    int pos=atoi(result[1]);
                    if(pos>inputs_num[ret]){
                        inputs_num[ret]=pos;
                    }
                }
            }

            //OUTPUT CASE
            //signal name prefix already present in I/O dimensions matrix?
            if(line[0]=='O'){
                int ret=findStr(outputs,OUT_N,result[0]);
                if(ret==-1){//no
                    //insert signal prefix in matrix
                    ret=out_last;
                    strcpy(outputs[out_last++],result[0]);

                }
                //signal name is lower case?
                if(islower(result[0][0])){//yes
                    if(!first){
                        fprintf(fp_out,";\n");
                    }else{
                        first=0;
                    }
                    //write std_logic
                    fprintf(fp_out,"%s_%s : OUT std_logic",result[0],result[1]);
                }else{//no
                    int pos=atoi(result[1]);
                    if(pos>outputs_num[ret]){
                        outputs_num[ret]=pos;
                    }
                }
            }

        }
        //
        //clear(line,clearline);
        //printf("%s",line);
        //printf("%s", clearline);

    }
    //write all std_logic_vector with dimensions saved
    for(int pos=0;pos<in_last;pos++){
        if(!islower(inputs[pos][0])){
            if(!first){
                    fprintf(fp_out,";\n");
            }else{
                first=0;
            }
            char tmp[16];
            itoa(inputs_num[pos],tmp,10);
            fprintf(fp_out,"%s : IN std_logic_vector(%s downto 0)",inputs[pos],tmp);
        }
    }
    for(int pos=0;pos<out_last;pos++){
        if(!islower(outputs[pos][0])){
            if(!first){
                fprintf(fp_out,";\n");
            }else{
                first=0;
            }
            char tmp[16];
            itoa(outputs_num[pos],tmp,10);
            fprintf(fp_out,"%s : OUT std_logic_vector(%s downto 0)",outputs[pos],tmp);
        }
    }
    fprintf(fp_out,");\nEND %s;\n\n",entity);

    //CREATE SIGNALS
    printf("Creating architecture\n");

    fprintf(fp_out,"ARCHITECTURE %s OF %s IS\n\n",architecture,entity);
    //start from file begin
    printf("Creating signals\n");
    rewind(fp_in);
    while(fgets(line,LINE_LEN,fp_in)!= NULL){//file not end
        clear(line,clearline);
        if(line[0]=='A'){ //assignment found?
            parse(clearline,LINE_LEN,'=',result);
            //destination signal is an output?
            char destination[16];
            strcpy(destination,result[1]);
            parse(destination,16,'_',result);
            int ret=findStr(outputs,OUT_N,result[0]);
            if(ret==-1){    //no
                //create signal with destination signal name
                fprintf(fp_out,"SIGNAL %s : std_logic;\n",destination);
            }
        }

        if(line[0]=='F' || line[0]=='H'){ //HA/FA found?
            parse(clearline,LINE_LEN,'=',result);
            //HA/FA output is an output?
            int starting_pos=0;
            if(line[0]=='F'){
                starting_pos=3;
            }else{
                starting_pos=2;
            }
            for(int cnt=0;cnt<2;cnt++){
                char destination[16];
                strcpy(destination,result[starting_pos+cnt]);
                if(destination[0]!='-'){
                    parse(destination,16,'_',result);
                    int ret=findStr(outputs,OUT_N,result[0]);
                    if(ret==-1){    //no
                        //create signal with destination signal name
                        fprintf(fp_out,"SIGNAL %s : std_logic;\n",destination);
                    }
                }

            }
        }

    }
    printf("Creating components\n");
    fprintf(fp_out,"\nCOMPONENT FA IS\nPORT%sEND COMPONENT;\n\n",FA_port);
    fprintf(fp_out,"COMPONENT HA IS\nPORT%sEND COMPONENT;\n\n",HA_port);

    //Creating assignments and port maps
    fprintf(fp_out,"BEGIN\n\n");

    //start from file begin
    printf("Creating signal assignments and component instances\n");
    rewind(fp_in);
    int FAn=0;
    int HAn=0;
    int temp=0;
    while(fgets(line,LINE_LEN,fp_in)!= NULL){//file not end
        //printf("neww\n");
        clear(line,clearline);
        if(line[0]=='A'){ //assignment found?
            parse(clearline,LINE_LEN,'=',result);
            //create assignment (if source/destination is an upper case input/output, write assignment as vector element)
            convertIO(result[1]);
            convertIO(result[0]);
            fprintf(fp_out,"%s <= %s;\n",result[1],result[0]);
        }

        if(line[0]=='F' || line[0]=='H'){ //HA/FA found?
            parse(clearline,LINE_LEN,'=',result);
            char instance[16];
            char tmp[16];
            //create component map
            if(line[0]=='F'){
                itoa(FAn++,tmp,10);
                instance[0]='F';
                instance[1]='\0';
                strcat(instance,tmp);
                convertIO(result[0]);
                convertIO(result[1]);
                convertIO(result[2]);
                convertIO(result[3]);
                convertIO(result[4]);
                fprintf(fp_out,"%s : FA PORT MAP(%s,%s,%s,%s,%s);\n",instance,result[0],result[1],result[2],result[3],result[4]);
            }else{
                itoa(HAn++,tmp,10);
                instance[0]='H';
                instance[1]='\0';
                strcat(instance,tmp);
                convertIO(result[0]);
                convertIO(result[1]);
                convertIO(result[2]);
                convertIO(result[3]);
                fprintf(fp_out,"%s : HA PORT MAP(%s,%s,%s,%s);\n",instance,result[0],result[1],result[2],result[3]);
            }
        }

    }

    fprintf(fp_out,"END %s;",architecture);

    fclose(fp_in);
    fclose(fp_out);
    printf("Done.\n");
    return 0;
}
