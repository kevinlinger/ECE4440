# +--------------------------------------+
# | Stack to Stack Accumulate Tester     |
# | Move data from one stack (R1-R2) to  |
# | another (R3-R4), then accumulate in  |
# | R0.	(LED=9)				 |

STRT:	LIL	R1 <STK1	# Load Stack A address into R1
	LIH	R1 >STK1
	LIL	R2 <STK3	# Load Stack A pointer into R2
	LIH	R2 >STK3	
	LIL	R3 <STKB	# Load Stack B address into R3
	LIH	R3 >STKB	
	SUB R0 R0		# Initialize result register (R0=0)
	LIL R5 1		# Initialize Incrementor/Decrementor (R5=1)
	LIH R5 0		 
	
	MOV R4 R3	
	AND R4 R3		# Initialize Second Stack Pointer (R4=R3-1)
	SUB R4 R5
TSLOOP:	MOV R15 R2
	SUB R15 R1		# Transfer Loop
	BN RDLOOP
	LD R6 R2 0
	SUB R2 R5
	ADD R4 R5
	ST R6 R4
	JMP TSLOOP
RDLOOP:	MOV R15 R4
	SUB R15 R3		# Read Stack B and Accumulate Loop
	BN DONE
	LD R6 R4 0
	SUB R4 R5
	ADD R0 R6
	JMP RDLOOP
DONE:	JMP DONE
STK1:	DATA	0x0003		# Stack A element 1
STK2:	DATA	0x000A		# Stack A element 2
STK3:	DATA	0x000C		# Stack A element 3
STKB:	DATA	0x0000		# Beginning of stack B