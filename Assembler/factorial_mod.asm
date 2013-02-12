#Calculates n!, where n is the value at the DATA label.
#When n=5, final R0(hex)=0078 and LED=8.

RESET:  DATA    2
ISR:    DATA    0
STRT:   LIL     R9 <DATA
        LIH     R9 >DATA
        LD      R0 R9 0
        LIL     R10 0
        LIH     R10 0
        LIL     R11 1
        LIH     R11 0
BASE:   MOV     R15 R0
        SUB     R15 R10
        BZ      ZERO
        MOV     R2 R0
        OR      R2 R10
        BR      LOOP
ZERO:   MOV     R0 R11
        OR      R0 R10
        BR      DONE
LOOP:   SUB     R2 R11
        MOV     R1 R0
        OR      R1 R10
        MOV     R3 R2
        OR      R3 R10
        SUB     R3 R11
        BZ      DONE
        BR      MULT
MULT:   ADD     R0 R1
        SUB     R3 R11
        MOV     R15 R3
        SUB     R15 R11
        BZ      LOOP
        BR      MULT
DONE:   BR      DONE
DATA:   DATA    0x0005