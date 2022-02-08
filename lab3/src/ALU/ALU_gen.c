#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

char OUT_FILE[]="../../sim/ALU_stim_res.hex"; //stimulus and corresponding results file

int cmdnum = 6; //number of different alu commands
int num = 2000;  //number of stimulus to generate

int32_t op1,op2,res;   //input operands and result
int cmd;    //alu command

void randOp(int32_t* op){ //extracting a random number for the operand
    //this function uses rand() function to generate random numbers
    //since rand() is only guaranteed to extract at least a 15 bit number, the
    //total 32 bit extraction is performed 8 bit at a time
    *op=0;
    for(int p=0;p<4;p++){
        uint8_t part=(uint8_t)rand()%256; //extracting 8 bits
        *op|=(((uint32_t)part)<<(8*p));
    }
}

int main(int argc, char **argv){
FILE *fp_out;

fp_out = fopen(OUT_FILE, "w");
    if (fp_out == NULL){
        printf("Error: cannot open %s\n",OUT_FILE);
        exit(2);
}

//random initialization
srand(time(NULL));

for(int c=0;c<num;c++){
    randOp(&op1);   //extraction of random operands
    randOp(&op2);

    int extr= rand()%cmdnum; //extraction of the command to test
    switch(extr){
    case 0: //and
        res=op1 & op2;
        break;
    case 1: //xor
        res=op1 ^ op2;
        break;
    case 2: //add
        res=op1 + op2;
        break;
    case 3: //sub
        res=op1 - op2;
        break;
    case 4: //lower than
        if(op1<op2)
            res=1;
        else
            res=0;
        break;
    default:    //right ashift
        op2&=0b11111;   //extracting only last 5 bits from op2
        res=op1>>op2;
        break;
    }
    int iszero=0;
    if(res==0){
        iszero=1;
    }
    fprintf(fp_out,"%01x %08lx %08lx %08lx %01x\n",extr,op1,op2,res,iszero);
}

}

