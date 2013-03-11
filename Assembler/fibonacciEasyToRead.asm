RESET:  DATA    2
ISR:    DATA    0
main: LIL R2 1
  LIH R2 0
  LIL R1 <local_a_main
  LIH R1 >local_a_main
  ST R2 R1 0
  LIL R1 <local_c_main
  LIH R1 >local_c_main
  ST R2 R1 0
  SUB R2 R2  # R2 <-- 0
  LIL R1 <local_n_main
  LIH R1 >local_n_main
  ST R2 R1 0
  LIL R1 <local_b_main
  LIH R1 >local_b_main
  ST R2 R1 0
  LIL R1 22
  LIH R1 0
  LIL R2 <local_m_main
  LIH R2 >local_m_main
  ST R1 R2 0
  BR enter_4290768384
top_4290768384: LIL R2 <local_b_main
  LIH R2 >local_b_main
  LD R3 R2 0
  LIL R1 <local_a_main
  LIH R1 >local_a_main
  ST R3 R1 0
  LIL R4 <local_c_main
  LIH R4 >local_c_main
  LD R1 R4 0
  ST R1 R2 0
  ADD R1 R3
  ST R1 R4 0
  LIL R3 <local_n_main
  LIH R3 >local_n_main
  LD R1 R3 0
  LIL R2 1
  LIH R2 0
  ADD R1 R2
  ST R1 R3 0
enter_4290768384: LIL R1 <local_m_main
  LIH R1 >local_m_main
  LD R2 R1 0
  LIL R1 <local_n_main
  LIH R1 >local_n_main
  LD R3 R1 0
  MOV R15 R3
  SUB R15 R2
  BN top_4290768384
  LIL R1 <local_c_main
  LIH R1 >local_c_main
  LD R0 R1 0
halt: BR halt
local_a_main: DATA 0
local_b_main: DATA 0
local_c_main: DATA 0
local_n_main: DATA 0
local_m_main: DATA 0