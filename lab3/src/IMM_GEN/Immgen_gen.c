#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <time.h>

char OUT_FILE[]="../../sim/IMMG_stim_res.hex"; //stimulus and corresponding results file

int num = 2000;  //number of stimulus to generate

//possible opcode--------------------------------------------
uint8_t opcode[5][4] ={
//I-types
{
0b0000011, //lw
0b0010011, //addi
0b0010011, //srai
0b0010011 //andi
},
{
//S-types
0b0100011, //sw
},
{
//SB-types
0b1100011, //beq
},
{
//U-types
0b0010111, //auipc
0b0110111, //lui
},
{
//UJ-types
0b1101111, //jal
}
};

//possible funct3--------------------------------------------
uint8_t funct3[5][4] ={
{
//I-types
0b010, //lw
0b000, //addi
0b101, //srai
0b111, //andi
},
{
//S-types
0b010, //sw
},
{
//SB-types
0b000, //beq
},
{
//U-types
0b000, //auipc
0b000, //lui
},
{
//UJ-types
0b000, //jal
}
};


//array that contains how much instructions per type are present inside the arrays above
//order is I-S-B-U-J
uint8_t instrNum[5]={4,1,1,2,1};

//array that contains the number of op fields of the instruction type
//(1=only opcode, 2=opcode+funct3)
//order is I-S-B-U-J
uint8_t fieldsNum[5]={2,2,2,1,1};

//immediate formats (each cell represents an immediate bit and
//the value is the corresponding bit position into instruction)
//value 32 stands for constant '0'
//WARNING! format arrays are defined MSB FIRST
//order is I-S-B-U-J
uint32_t formats[5][32]={
{31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,30,29,28,27,26,25,24,23,22,21,20},
{31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,30,29,28,27,26,25,11,10,9 ,8 ,7 },
{31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,31,7 ,30,29,28,27,26,25,11,10,9 ,8 ,32},
{31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,32,32,32,32,32,32,32,32,32,32,32,32},
{31,31,31,31,31,31,31,31,31,31,31,31,19,18,17,16,15,14,13,12,20,30,29,28,27,26,25,24,23,22,21,32},
};

//function to print a 32 bit number as binary
void printBin(uint32_t num){
    char str[33]="";
    for(int p=31;p>=0;p--){
        uint32_t mask=1<<p;
        mask=mask&num;
        if(mask==0){
            str[31-p]='0';
        }else{
            str[31-p]='1';
        }
        str[32]='\0';
    }
    printf("%s\n",str);
}

//function that replaces n bits from source into destination
//it replaces bits [srcLSB+n : srcLSB] of src
//into bits [destLSB+n : destLSB] of dest
void replaceBits(uint32_t src,uint32_t* dest,int srcLSB,int destLSB,uint8_t n){
	int srcMSB = srcLSB+n-1;
	int destMSB = destLSB+n-1;

	if(n==0) return;
	if(srcLSB<0 || srcLSB>31) return;	//boundary check
	if(srcMSB<0 || srcMSB>31) return;
	if(destLSB<0 || destLSB>31) return;
	if(destMSB<0 || destMSB>31) return;

	uint32_t mask=0;
	for(int i=0;i<n;i++){
		mask=mask+(1<<i);
	}

    mask=mask << srcLSB; //reading value
	uint32_t read=mask & src;
	read=read >> srcLSB;
    mask=mask >> srcLSB;

    mask=mask << destLSB;   //writing value
    read=read << destLSB;
	*dest=(*dest) & (~mask);
	*dest=(*dest) | read;

}

void randOp(uint32_t* op){ //extracting a random number for the immediate
    //this function uses rand() function to generate random numbers
    //since rand() is only guaranteed to extract at least a 15 bit number, the
    //total 32 bit extraction is performed 8 bit at a time
    *op=0;
    for(int p=0;p<4;p++){
        uint8_t part=(uint8_t)rand()%256; //extracting 8 bits
        *op|=(((uint32_t)part)<<(8*p));
    }
}

//function to extract random number from [0 to max)
int randInt(int max){
	return rand()%max;
}

//function that converts an instruction into its immediate value using a format array
uint32_t instr2imm(uint32_t instr,uint32_t format[]){
	uint32_t retval=0;
	for(int i=0;i<32;i++){
		if(format[31-i]==32){ //constant 0
			replaceBits(0,&retval,0,i,1);
		}else{
			replaceBits(instr,&retval,format[31-i],i,1);
		}
	}
	return retval;
}

//function that scans the opcode/funct3 arrays to find a defined instruction
//and build the corresponding immediate
uint32_t scan4imm(uint32_t instr){
    uint32_t imm=0;

	uint32_t op=0;	//opcode
	uint32_t f3=0;	//funct3

	replaceBits(instr,&op,0,0,7); 	//extract opcode
	replaceBits(instr,&f3,12,0,3);	//extract funct3

	int flag=0;	//correspondance found flag
	for(int type=0;type<5 && flag==0;type++){ //loop on instruction types
		for(int p=0;p<instrNum[type] && flag==0;p++){	//loop on instructions of that type
			if(op==opcode[type][p]){
                if(fieldsNum[type]==1){ //if instruction only has opcode
                    flag=1;
				}else{	//if instruction has also funct3
					if(f3==funct3[type][p]){
                        flag=1;
					}
				}
				if(flag==1){
                    			imm=instr2imm(instr,formats[type]);
				}
			}

		}
	}
	return imm;
}


int main(int argc, char **argv){
FILE *fp_out;

fp_out = fopen(OUT_FILE, "w");
    if (fp_out == NULL){
        printf("Error: cannot open %s\n",OUT_FILE);
        exit(2);
}
printf("File %s opened\n",OUT_FILE);
//random initialization
srand(time(NULL));

uint32_t instr,imm;

printf("Generating 25%% of correct instructions\n");
for(int g=0;g<num/4;g++){ //generating 25% of correct instructions
	instr=0;
	imm=0;

	int rnd1=randInt(5);			//selecting a random instruction type
    int rnd2=randInt(instrNum[rnd1]); 	//selecting a random instruction of that type

	uint32_t op=(uint32_t)opcode[rnd1][rnd2];
	uint32_t f3=(uint32_t)funct3[rnd1][rnd2];

    randOp(&instr);	//creating a random background pattern for instruction (random immediate fields)

	replaceBits(op,&instr,0,0,7); 	//placing opcode
	replaceBits(f3,&instr,0,12,3);	//placing funct3 (if instruction has no func3, this will only change some imm bits)

    imm=scan4imm(instr); //generating the immediate for the instruction

	fprintf(fp_out,"%08lx %08lx\n",instr,imm); //printing on file
}

printf("Generating 50%% of pseudo random instructions\n");
for(int g=0;g<num/2;g++){ //generating 50% of pseudo random instructions (opcode and func3 will be randomly selected from all the availables)
	instr=0;
	imm=0;

	int rnd1=randInt(5);			//selecting a random instruction type
	int rnd2=randInt(instrNum[rnd1]); 	//selecting a random instruction of that type

	uint32_t op=(uint32_t)opcode[rnd1][rnd2];	//picking a random opcode

	rnd1=randInt(5);			//selecting a random instruction type
	rnd2=randInt(instrNum[rnd1]); 	//selecting a random instruction of that type

	uint32_t f3=(uint32_t)funct3[rnd1][rnd2];	//picking a random funct3

	randOp(&instr);	//creating a random background pattern for instruction (random immediate fields)

	replaceBits(op,&instr,0,0,7); 	//placing opcode
	replaceBits(f3,&instr,0,12,3);	//placing funct3 (if instruction has no func3, this will only change some imm bits)

	imm=scan4imm(instr); //generating the immediate for the instruction

	fprintf(fp_out,"%08lx %08lx\n",instr,imm); //printing on file
}

printf("Generating 25%% of totally random instructions\n");
for(int g=0;g<num/4;g++){ //generating 25% of totally random instructions
	instr=0;
	imm=0;

	randOp(&instr);	//creating a random instruction

	imm=scan4imm(instr); //generating the immediate for the instruction (most of the times it will be 0)

	fprintf(fp_out,"%08lx %08lx\n",instr,imm); //printing on file
}
printf("Done.\n");
}

