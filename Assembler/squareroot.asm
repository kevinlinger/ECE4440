#Calculates n^.5 rounded down to the nearest integer, where n
#is the value at the OPR label.
#When n=3100, final R0(hex)=0037 and LED=7.

STRT:  LIL  R1 <OPR       # Load operator address into R1
       LIH  R1 >OPR       #!! LIL must come before LIH to because LIL sign-extends
       LD   R6 R1 0       # Load operator into R6
       LIL  R0 0         # Initialize R0=0
       MOV  R15 R6        # CMP R6 R0
       SUB  R15 R0        # Check for R3=0
       BZ   DONE
       LIL  R0 1          # Initialize R0=1 (!!! only takes 1 assignment because s-extend)
       LIL  R1 0         # Initialize R1=0
       MOV  R2 R0         # Set R2=R0
       LIL  R5 1          # Initialize R5=1 (Decrementor) (!!! only takes 1 LIL because s-extend)
LOOP:  ADD  R1 R0         # Add Loop
       SUB  R2 R5
       MOV  R15 R2        # CMP R2 R5
       SUB  R15 R5
       BN   OUT
       BR  LOOP
OUT:   MOV  R15 R6        # CMP R1 R6
       SUB  R15 R1
       BZ   DONE
       BN   OVER          # BP OVER (!!! NB: works because CMP R1 R6 was inverted above)
       SUB  R1 R1         # Reset R1=0
       ADD  R0 R5         # Increment R0
       MOV  R2 R0         # Set R2=R0
       BR  LOOP
OVER:  SUB  R0 R5
DONE:  BR  DONE
OPR:   DATA  3100         # Operator