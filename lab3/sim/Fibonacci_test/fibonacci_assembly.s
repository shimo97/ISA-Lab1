#FIBONACCI SEQUENCE PROGRAM
#This program computes the fibonacci sequence
#inside vector v (first 32 elements)
	.data
	.align 2
v:
	.word 1
	.word 1

	.text
	.align	2
	.globl	__start
__start:
	li x16,30         # put 13 in x16
	la x4,v           # put in x4 the address of v
loop:	
	beq x16,x0,endc   # check all elements have been tested
	lw x8,0(x4)       # load n-2 element in x8
	lw x9,4(x4)       # load n-1 element in x9
	add x10,x8,x9     # add n-2 and n-1 element into x10
	sw x10,8(x4)      # store the result
	addi x4,x4,4   	  # increment n-2 position
	addi x16,x16,-1	  # decrement iterations counter
	jal loop          # next element
endc:	
	jal endc  	  # infinite loop
	addi x0,x0,0
	
