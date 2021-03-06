#Team Shi
#Caculates the Fibonacci sequence from 0 to n, where n-1 is the
#value loaded into R1 after the "line 8" comment below.
#When n=23, final R0(hex)=6FF1 and LED=1.

RESET:  DATA    2
ISR:    DATA    0
main: LIL R2 1
  LIH R2 0
  LIL R1 <local_a_main
  LIH R1 >local_a_main
  ST R2 R1 0
# Maximum value of m can be 22
  LIL R1 <local_c_main
  LIH R1 >local_c_main
  ST R2 R1 0
# - - - - - - - - - - - - - - - line 6
  SUB R2 R2  # R2 <-- 0
  LIL R1 <local_n_main
  LIH R1 >local_n_main
  ST R2 R1 0
# - - - - - - - - - - - - - - - line 7
  LIL R1 <local_b_main
  LIH R1 >local_b_main
  ST R2 R1 0
# - - - - - - - - - - - - - - - line 8
# change the following LIL value to alter input (fibo(R1+1))
  LIL R1 22
  LIH R1 0
  LIL R2 <local_m_main
  LIH R2 >local_m_main
  ST R1 R2 0
# - - - - - - - - - - - - - - - line 9
  BR enter_4290768384
top_4290768384: LIL R2 <local_b_main
  LIH R2 >local_b_main
  LD R3 R2 0
  LIL R1 <local_a_main
  LIH R1 >local_a_main
  ST R3 R1 0
# - - - - - - - - - - - - - - - line 12
  LIL R4 <local_c_main
  LIH R4 >local_c_main
  LD R1 R4 0
  ST R1 R2 0
# - - - - - - - - - - - - - - - line 13
  ADD R1 R3
  ST R1 R4 0
# - - - - - - - - - - - - - - - line 14
  LIL R3 <local_n_main
  LIH R3 >local_n_main
  LD R1 R3 0
  LIL R2 1
  LIH R2 0
  ADD R1 R2
  ST R1 R3 0
# - - - - - - - - - - - - - - - line 9
enter_4290768384: LIL R1 <local_m_main
  LIH R1 >local_m_main
  LD R2 R1 0
  LIL R1 <local_n_main
  LIH R1 >local_n_main
  LD R3 R1 0
  MOV R15 R3
  SUB R15 R2
  BN top_4290768384
# - - - - - - - - - - - - - - - line 16
  LIL R1 <local_c_main
  LIH R1 >local_c_main
  LD R0 R1 0
halt: BR halt
local_a_main: DATA 0
local_b_main: DATA 0
local_c_main: DATA 0
local_n_main: DATA 0
local_m_main: DATA 0
# - - - - - - - - - - - - - - - line 15