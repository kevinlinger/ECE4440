# R0=10 (LED=A)
        LIL R7 0xFF
        LIL R10 1
        LIL R9 0
        LIH R7 0xFF
        LIH R10 0
        LIH R9 0
        MOV R8 R7
        OR R8 R7
     ST R7 R8
     SUB R8 R10
     MOV R7 R8
     OR R7 R8
     LIL R6 3
     LIH R6 0
     SUB R8 R6 
L1:     MOV R0 R9 
        OR R0 R9
L2:     MOV R1 R10
        OR R1 R10
L3:    	LIL R2 5
     LIH R2 0
     MOV R3 R9
     OR R3 R9
     MOV R15 R1
     SUB R15 R2
     BN     L01
     MOV R15 R2 
     SUB R15 R1 
     BN     L01
     ADD R3 R10
L01:  MOV R15 R9
      SUB R15 R3
      BZ L8
      JMP L17
L6:   MOV R2 R10 
     OR R2 R10
     MOV R3 R1
     ADD R3 R2
     MOV R1 R3
     OR R1 R3
     JMP L3
L8:   MOV R2 R10
      OR R2 R10
L10:  MOV R3 R9
      OR R3 R9
     MOV R15 R2
     SUB R15 R1
     BN L02
    MOV R15 R1 
     SUB R15 R2 
     BN     L02
     MOV R3 R3
     ADD R3 R10
L02:     MOV R15 R9
     SUB R15 R3
     BZ L15
     JMP L6
L13:     MOV R3 R10
     OR R3 R10
	MOV R4 R2
   ADD R4 R3
   MOV R2 R4
   OR R2 R4     
     JMP L10
L15:   MOV R3 R0 
     ADD R3 R2
     MOV R0 R3
     OR R0 R3
     JMP L13
     JMP L6
L17:     MOV R11 R0
     OR R11 R0
     MOV R8 R7
     OR R8 R7
     ADD R8 R10
     LD R7 R8 0
     JMP DONE
     ADD R8 R10
 L18:     MOV R8 R7
     OR R8 R7
     ADD R8 R10
     LD R7 R8 0
     JMP DONE
     ADD R8 R10
     LIL R6 3
     LIH R6 0
     ADD R8 R6     
DONE:  MOV R0 R11
     OR R0 R11
DONE1: JMP DONE1
 