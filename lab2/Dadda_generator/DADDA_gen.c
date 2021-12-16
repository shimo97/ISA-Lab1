/*-----DADDA GENERATOR
    This program will read in input file representing a dot notation operand set
    producing the full dot notation dadda tree and a raw netlist corresponding to it (see raw_net_rules.txt for details)
    the input file can contain the following characters, (each character represents a weight), organized in a dot notation matrix
    - character 'A' (can be any letter): this represents a dot (so an operand bit, the name assigned into the netlist is with horizontal priority)
    - whitespace ' ': this represents the absence of dots
        WARNING! input file MUST have white spaces to fill all the horizontal dimension (no \n new lines before reaching MATRIX_W position)
        WARNING! the program is designed to operate with multiplier partial products so will only produce carry dots inside the matrix
        it's up to the user to ensure that there won't be possible carry dots at the left of the matrix (or you can put an additional space
        on the left of input file to accomodate possible carry bits, for the output RCA the MSB carry out will be put as MSB of the output if
        there is enough space inside the matrix (the column of the carry out weight is present)
        WARNING! The RCA generation begins at the first column of the last layer with at least one dot and ends at the matrix left border
        or at the first column without any dot, so it's also up to the user to ensure that the last layer (target 2) is generated without
        "holes" between columns or the MSB output bits after the hole will be missing

*/
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
//defining matrix width and height
#define MATRIX_W 48
#define MATRIX_H 13
char IN_FILENAME[]="dadda_in.txt";  //filename with input dots
char LOG_FILENAME[]="dadda_log.txt";    //file in which the dadda log (matrix print for each layer) will be produced
char NET_FILENAME[]="netlist_raw.txt";  //file for the raw netlist

char matrix[MATRIX_W][MATRIX_H]; //matrix in which is stored the current layer dot notation (with F,H,C and N characters))
char sourcematrix[MATRIX_W][MATRIX_H]; //matrix in which is stored the current layer dot notation (with only N characters))
char tmpmatrix[MATRIX_W][MATRIX_H]; //matrix in which is stored the next layer dot notation (with F,H,C and N characters))

int totadd=0; //total number of adders used

//redefinition of non standard function itoa to use in linux (base will be ignored anyway)
void itoa(int d,char *str,int base){
	sprintf(str,"%d",d);
}
//print the submatrix with width w and height h of matrix (w and h must be <= MATRIX_W and MATRIX_H respectively)
//into stdout
void printMatrix(char (*mtrx)[MATRIX_H],int w,int h){
    //writing matrix
    for(int r=0;r<h;r++){
        for(int c=0;c<w;c++){
            printf("%c",mtrx[c][r]);
        }
        printf("\n");
    }
    //writing separation line
    for(int c=0;c<w;c++){
        printf("%c",'-');
    }
    printf("\n");
}
//print the submatrix with width w and height h of matrix (w and h must be <= MATRIX_W and MATRIX_H respectively)
//into fp output file
void writeMatrix(FILE* fp_out,char (*mtrx)[MATRIX_H], int w,int h){
    //writing matrix
    for(int r=0;r<h;r++){
        for(int c=0;c<w;c++){
            fprintf(fp_out, "%c",mtrx[c][r]);
        }
        fprintf(fp_out, "\n");
    }
    //writing separation line
    for(int c=0;c<w;c++){
        fprintf(fp_out, "%c",'-');
    }
    fprintf(fp_out, "\n");
}
//function to compress a matrix column to the top, eliminating whitespaces between dots
void compressColumn(int column, char (*mtrx)[MATRIX_H]){
    int go=1;
    int r=0;
    //printf("begin compression\n");
    while(go){
        //there is a whitespace on this row?
        if(mtrx[column][r]==' '){ //yes
            //there is a dot on some position underneath?
            int next_dot_pos=r;
            int found=0;
            int searching=1;
            while(searching==1){
                if(mtrx[column][next_dot_pos]!=' '){
                    searching=0;
                    found=1;
                }else{
                    next_dot_pos++;
                    if(next_dot_pos==MATRIX_H){
                        searching=0;
                    }
                }
            }
            if(found==1){ //yes
                //move all the dots from that position to current position
                for(int moved=0;(next_dot_pos+moved)<MATRIX_H;moved++){
                    mtrx[column][r+moved]=mtrx[column][next_dot_pos+moved];
                }
                //fill the column bottom with a number of whitespaces equal to the number of shifted positions
                for(int added=0;added<(next_dot_pos-r);added++){
                    mtrx[column][MATRIX_H-1-added]=' ';
                }
            }else{ //no
                go=0;
            }
        }
        r++;
        if(r==MATRIX_H){
            go=0;
        }
    }
    //printf("end compression\n");
}
//function to fill a column (from top) with num characters c, without moving the already present characters
//returns the position (row) of the first inserted element
int fillColumn(int column, char (*mtrx)[MATRIX_H],int num,char c){
    int remaining=num;
    int pos=0;
    int retval=0;
    while(remaining!=0 && pos<MATRIX_H){
        while(mtrx[column][pos]!=' ' && pos<MATRIX_H){
            pos++;
        }
        if(pos<MATRIX_H){
            mtrx[column][pos]=c;
            if(remaining==num){//first inserted element
                retval=pos;
            }
            remaining--;
        }
    }
    return retval;
}
//copy a matrix inside another
//if substitute char is '-' the chars will be copied, otherwise they will be substituted with that char
void copyMatrix(char (*from)[MATRIX_H],char (*to)[MATRIX_H],char substitute){
    for(int c=0;c<MATRIX_W;c++){
        for(int r=0;r<MATRIX_H;r++){
            if(from[c][r]==' ' || substitute=='-'){
                to[c][r]=from[c][r];
            }else{
                to[c][r]=substitute;
            }
        }
    }
}
//get a dot name with horizontal priority (scanning is done starting from top right and the inner loop is on the columns)
//name is created as <dot><pref>_<number> where dot is the dot character, pref is pref string and number
//is the operand number computed with horizontal priority (starting from top right)
void getNameHorizontal(int c,int r,char (*mtrx)[MATRIX_H],char name[16],char pref[4]){
    int c_pos=MATRIX_W-1;
    int r_pos=0;
    int num=0;
    while(r_pos <=r && r_pos<MATRIX_H){
        while(((r_pos<r && c_pos>=0) || (r_pos==r && c_pos>=c))&&c_pos>=0){
            if(mtrx[c_pos][r_pos]==mtrx[c][r]){
                num++;
            }
            c_pos--;
        }
        r_pos++;
        c_pos=MATRIX_W-1;
    }
    num--;
    name[0]=mtrx[c][r];
    name[1]='\0';
    strcat(name,pref);
    strcat(name,"_");
    char nums[14];
    itoa(num,nums,10);
    strcat(name,nums);
}
//get a dot name with vertical priority  (scanning is done starting from top right and the inner loop is on the rows)
//name is created as <dot><pref>_<number> where dot is the dot character, pref is pref string and number
//is the operand number computed with vertical priority (starting from top right)
void getNameVertical(int c,int r,char (*mtrx)[MATRIX_H],char name[16],char pref[4]){
    int c_pos=MATRIX_W-1;
    int r_pos=0;
    int num=0;
    while(c_pos >=c && c_pos>=0){
        while(((c_pos>c && r_pos<MATRIX_H) || (c_pos==c && r_pos<=r))&&r_pos<MATRIX_H){
            if(mtrx[c_pos][r_pos]==mtrx[c][r]){
                num++;
            }
            r_pos++;
        }
        c_pos--;
        r_pos=0;
    }
    num--;
    name[0]=mtrx[c][r];
    name[1]='\0';
    strcat(name,pref);
    strcat(name,"_");
    char nums[14];
    itoa(num,nums,10);
    strcat(name,nums);
}
//clear matrix with whitespaces
void clearMatrix(char (*mtrx)[MATRIX_H]){
    for(int c=0;c<MATRIX_W;c++){
        for(int r=0;r<MATRIX_H;r++){
            mtrx[c][r]=' ';
        }
    }
}
//this function executes the dadda formatting of one layer of the tree on from matrix with target height
//the result is directly stored inside to matrix (target MUST be <= MATRIX_H)
void dadda(int target,char (*from)[MATRIX_H],char (*to)[MATRIX_H]){
    //start from upper right
    int carry_dots=0;
    int totadders=0;
    //clear tmpmatrix
    clearMatrix(to);

    for(int c=MATRIX_W-1;c>=0;c--){
        //counting dots passed to next layer
        int count=0;
        for(int r=0;r<MATRIX_H;r++){
            if(from[c][r]!=' '){
                count++;
            }
        }
        int next_dots=carry_dots+count;
        //printf("dots %d carry %d dots passed %d ",count,carry_dots,next_dots);
        int FAn=0,HAn=0; //number of Fa and HA of current layer
        int tmp_next_dots=0;
        //number of potential dots of next layer greater than target?
        if((next_dots)>target){ //yes
            //compute the number of FA that will overcome the target, create one less FA than this number
            tmp_next_dots=next_dots;
            while(tmp_next_dots>=target){
                FAn++;
                tmp_next_dots-=2;
            }
            FAn--;
            //target perfectly matched?
            tmp_next_dots=next_dots-FAn*2;
            if(tmp_next_dots!=target){ //no
                    //create one HA
                HAn=1;
            }
        }
        //printf("FA %d HA %d",FAn,HAn);

        //produce dots on next layer

        //compress the dots
        compressColumn(c,from);
        //compute the number of dots that must directly pass to next layer and carry dots of next column
        //starting position
        int pass_start=FAn*3+HAn*2;
        //number of dots from that position
        int n=0;
        for(int r=pass_start;r<MATRIX_H;r++){
            if(from[c][r]!=' '){
                n++;
            }
        }
        //create new HA and FA Sum dots (F and H char) on the same column
        //create Carry dots of next column (diagonally to sum dots, so one row below,using C char, if not at the matrix border)
        for(int fac=0;fac<FAn;fac++){
            //creating full adder dot
            int pos=fillColumn(c,to,1,'F');
            if(c>0){    //creating carry dot on diagonal position
                to[c-1][pos+1]='C';
            }
        }
        for(int hac=0;hac<HAn;hac++){
            //creating half adder dot
            int pos=fillColumn(c,to,1,'H');
            if(c>0){    //creating carry dot on diagonal position
                to[c-1][pos+1]='C';
            }
        }

        //fill the column with the number of directly passed dots
        fillColumn(c,to,n,'N');
        //save the new number of carry dots of next column
        carry_dots=FAn+HAn;
        totadders+=carry_dots;
        //compress the dots
        compressColumn(c,to);
        //printf("\n");

    }
    printf("number of layer adders: %d\n",totadders);
    totadd+=totadders;
}

int main(int argc, char **argv){
    printf("Dadda generator - HELLO\n");
    FILE *fp_in;
    FILE *fp_out;
    FILE *fp_net;

    //input file
    fp_in = fopen(IN_FILENAME, "r");
    if (fp_in == NULL){
        printf("Error: cannot open %s\n",IN_FILENAME);
        exit(2);
    }
    fp_out = fopen(LOG_FILENAME, "w");
    if (fp_out == NULL){
        printf("Error: cannot open %s\n",LOG_FILENAME);
        exit(2);
    }
    fp_net = fopen(NET_FILENAME, "w");
    if (fp_net == NULL){
        printf("Error: cannot open %s\n",NET_FILENAME);
        exit(2);
    }

    char in_str[MATRIX_W+1];
    int row=0;
    int c=0;
    //scan file to load characters on matrix
    printf("Reading input file\n");
    char ch;
    while((ch = fgetc(fp_in)) != EOF){
        //printf("%s\n",in_str);
        if((ch != '\n') && (ch != '\r')){
            matrix[c++][row]=ch;
        }else{
            row++;
            c=0;
        }
    }
    printMatrix(matrix,MATRIX_W, MATRIX_H);
    writeMatrix(fp_out,matrix,MATRIX_W, MATRIX_H);
    //NETLIST CREATION
    printf("Starting netlist creation\n");
    //convert to dot notation (all N characters) into tmp matrix
    printf("Converting to neutral notation (each 'N' is a dot)\n");
    copyMatrix(matrix,tmpmatrix,'N');
    printMatrix(tmpmatrix,MATRIX_W, MATRIX_H);
    writeMatrix(fp_out,tmpmatrix,MATRIX_W, MATRIX_H);
    //assign operand names with horizontal priority into matrix and assign dot names with vertical priority into tmp matrix
    //map matrix with corresponding dots on tmp matrix (same coordinates)
    //assign matrix bits as inputs
    char tmpname[16];
    for(int col=0;col<MATRIX_W;col++){
        for(int row=0;row<MATRIX_H;row++){
            if(matrix[col][row]!=' '){
                getNameHorizontal(col,row,matrix,tmpname,"i\0");
                fprintf(fp_net,"I%s\n",tmpname);
                fprintf(fp_net,"A%s=",tmpname);
                getNameVertical(col,row,tmpmatrix,tmpname,"0\0");
                fprintf(fp_net,"%s\n",tmpname);
            }
        }
    }
    //move content of tmp matrix into matrix and source matrix
    copyMatrix(tmpmatrix,matrix,'N');
    copyMatrix(tmpmatrix,sourcematrix,'N');

    //computing dadda tree
    printf("Starting Dadda tree computation\n");
    printf("Sum dots will be written as 'F' (for FAs) or 'H' (for HAs)\n");
    printf("Carry dots will be written as 'C'\n");

    int current_h=MATRIX_H;
    int layer=0;
    char layerS_old[3];
    char layerS_new[3];
    while(current_h>2){
        //create next dadda layer from sourcematrix into tmpmatrix
        //computing current layer target
        int target=2;
        int old_target=0;
        while(target<current_h){
            old_target=target;
            target=(int)(3*((float)target/2));
        }
        target=old_target;
        //create next dadda layer
        printf("Computing next layer of dadda tree (target=%d)\n",target);
        dadda(target,sourcematrix,tmpmatrix);
        //CREATE PORT MAPS
        itoa(layer,layerS_old,10);
        itoa(layer+1,layerS_new,10);
        //start from top right
        for(int c=MATRIX_W-1;c>=0;c--){
            int available_in=0;
            int available_carry=0;
            //all the names are assigned with vertical priority
            //scan down for F/H (full/half adders) on tmp matrix
            for(int r=0;r<MATRIX_H;r++){
                //when a F/H is found
                if(tmpmatrix[c][r]=='F' || tmpmatrix[c][r]=='H'){
                    char type=tmpmatrix[c][r];
                    //create component of full/half adder
                    fprintf(fp_net,"%c",type);
                    //with the first three/two available dots (first dots not already used by another full/half adder) on matrix as input
                    int inputs=0;
                    if(type=='F'){
                        inputs=3;
                    }else{
                        inputs=2;
                    }
                    while(inputs>0 && available_in<MATRIX_H){
                        if(matrix[c][available_in]!=' '){
                            getNameVertical(c,available_in,matrix,tmpname,layerS_old);
                            fprintf(fp_net,"%s=",tmpname);
                            inputs--;
                        }
                        available_in++;
                    }
                    // using the current F/H dot on tmp matrix as output
                    getNameVertical(c,r,tmpmatrix,tmpname,layerS_new);
                    fprintf(fp_net,"%s=",tmpname);
                    //and the first available C of the next column as carry out (if last column, assign to carry out a floating pin (- character into raw file)
                    if(c==0){
                        fprintf(fp_net,"-\n");
                    }else{
                        int found=0;
                        while(found==0 && available_carry<MATRIX_H){
                            if(tmpmatrix[c-1][available_carry]=='C'){
                                getNameVertical(c-1,available_carry,tmpmatrix,tmpname,layerS_new);
                                fprintf(fp_net,"%s\n",tmpname);
                                found=1;
                            }
                            available_carry++;
                        }
                    }
                }
            }
            //map the N dots of tmpmatrix with the remaining N dots of matrix,all the names are assigned with vertical priority
            for(int r=0;r<MATRIX_H;r++){
                if(tmpmatrix[c][r]=='N'){
                    fprintf(fp_net,"A");
                    int found=0;
                    while(available_in<MATRIX_H && found==0){
                        if(matrix[c][available_in]!=' '){
                            getNameVertical(c,available_in,matrix,tmpname,layerS_old);
                            fprintf(fp_net,"%s=",tmpname);
                            found=1;
                        }
                        available_in++;
                    }
                    getNameVertical(c,r,tmpmatrix,tmpname,layerS_new);
                    fprintf(fp_net,"%s\n",tmpname);
                }
            }
        }

        //copy tmp matrix into matrix
        copyMatrix(tmpmatrix,matrix,'-');
        //copy tmp matrix into source matrix converting to dot notation (all N characters)
        copyMatrix(tmpmatrix,sourcematrix,'N');

        current_h=target;
        layer++;
        //print and write matrix
        printMatrix(matrix,MATRIX_W, current_h);
        writeMatrix(fp_out,matrix,MATRIX_W, current_h);
    }
    //creating RCA
    printf("Creating output RCA\n");
    int firstfound=0;
    int outbase=0;
    char lastcarryname[16]; //last column carry name
    char outnumS[16];   //current column number (starting from outbase)
    char outname[16];   //current column output name
    char carryname[16]; //current column carry name
    int adders=0;
    int go=1;
    clearMatrix(tmpmatrix);
    //start from right column
    for(int c=MATRIX_W-1;c>=0 && go==1;c--){
        if(firstfound==0){
            outbase=c;
        }
        //current column number
        itoa(outbase-c,outnumS,10);
        //writing current output name
        strcpy(outname,"Y_");
        strcat(outname,outnumS);
        //writing carry names
        strcpy(lastcarryname,carryname);
        if(c>0){
            strcpy(carryname,"Co_");
            strcat(carryname,outnumS);
        }else{
            strcpy(carryname,"-");
        }


        if(matrix[c][0]==' ' && matrix[c][1]==' '){//zero operands
            if(firstfound==1){//first column with operands already found
                //map the preceding carry as next column output
                fprintf(fp_net,"A%s=",lastcarryname);
                fprintf(fp_net,"%s\n",outname);
                //create output
                fprintf(fp_net,"O%s\n",outname);
                tmpmatrix[c][0]='Y';
                go=0;   //end iteration
            }
        }else if((matrix[c][0]==' ' && matrix[c][1]!=' ') || (matrix[c][1]==' ' && matrix[c][0]!=' ')){//one operand?
            if(firstfound==0){//first column with operands
                firstfound=1;
                //map the operand as carry in of next column
                if(matrix[c][0]==' '){
                    getNameVertical(c,1,matrix,tmpname,layerS_new);
                }else{
                    getNameVertical(c,0,matrix,tmpname,layerS_new);
                }
                fprintf(fp_net,"A%s=",tmpname);
                fprintf(fp_net,"%s\n",carryname);
            }else{
                //map the operand as input of an HA with the carry of the preceding column as other input
                if(matrix[c][0]==' '){
                    getNameVertical(c,1,matrix,tmpname,layerS_new);
                }else{
                    getNameVertical(c,0,matrix,tmpname,layerS_new);
                }
                fprintf(fp_net,"H%s=",tmpname);
                fprintf(fp_net,"%s=",lastcarryname);
                fprintf(fp_net,"%s=",outname);
                fprintf(fp_net,"%s\n",carryname);
                adders++;
                //write output
                fprintf(fp_net,"O%s\n",outname);
                tmpmatrix[c][0]='Y';

            }
        }else{  //two operands
            if(firstfound==0){//first column with operands
                firstfound=1;
                //map the operands as input of an HA
                getNameVertical(c,0,matrix,tmpname,layerS_new);
                fprintf(fp_net,"H%s=",tmpname);
                getNameVertical(c,1,matrix,tmpname,layerS_new);
                fprintf(fp_net,"%s=",tmpname);

                fprintf(fp_net,"%s=",outname);
                fprintf(fp_net,"%s\n",carryname);
                adders++;
                //write output
                fprintf(fp_net,"O%s\n",outname);
                tmpmatrix[c][0]='Y';
            }else{
                //map operands as input of a FA with the carry in of the preceding column as other input
                getNameVertical(c,0,matrix,tmpname,layerS_new);
                fprintf(fp_net,"F%s=",tmpname);
                getNameVertical(c,1,matrix,tmpname,layerS_new);
                fprintf(fp_net,"%s=",tmpname);

                fprintf(fp_net,"%s=",lastcarryname);
                fprintf(fp_net,"%s=",outname);
                fprintf(fp_net,"%s\n",carryname);
                adders++;
                //write output
                fprintf(fp_net,"O%s\n",outname);
                tmpmatrix[c][0]='Y';

            }
        }
    }
    printf("number of RCA adders: %d\n",adders);
    printMatrix(tmpmatrix,MATRIX_W, 1);
    writeMatrix(fp_out,tmpmatrix,MATRIX_W, 1);
    printf("total adders: (%d (dadda) %d (RCA) = ",totadd,adders);
    totadd+=adders;
    printf("%d (tot)\n",totadd);

    fclose(fp_in);
    fclose(fp_out);
    printf("Done.\n");
    return 0;

}
