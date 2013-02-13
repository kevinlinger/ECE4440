# R0=(sum of data values) (LED=B)

STRT:	LIL	R1 <STKB	
	LIH	R1 >STKB	# Load stack bottom pointer into R1
	LIL	R2 <STKT
	LIH	R2 >STKT	# Load stack top pointer into R2
	MOV R3 R1		# set R3=R1
	LIL R0 0		# Initialize result register (R0=0)
	LIL R5 1		# Initialize Incrementor/Decrementor (R5=1)
LOOP1:	LD R4 R3 0
	ADD R4 R5
	ST R4 R3 0
	MOV R15 R3
	SUB R15 R2
	BZ LOOP2
	ADD R3 R5
	BR LOOP1
LOOP2:	LD R4 R3 0
	SUB R4 R5
	ST R4 R3 0
	MOV R15 R3
	SUB R15 R1
	BZ ACC
	SUB R3 R5
	BR LOOP2
ACC:	LD R4 R3 0
	ADD R0 R4
	MOV R15 R3
	SUB R15 R2
	BZ DONE
	ADD R3 R5
	BR ACC
DONE:	BR DONE
STKB:	DATA	0x0003
	DATA	0x000A
	DATA	0x000C
STKT:	DATA	0x0012