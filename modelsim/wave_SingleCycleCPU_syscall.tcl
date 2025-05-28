vsim work.tb_SingleCycleCPU
delete wave *

# ===== 입력 클럭 및 제어 =====
add wave -format logic    -radix binary   tb_SingleCycleCPU/Clock
add wave -format literal  -radix binary   tb_SingleCycleCPU/ExpSrc

# ===== 출력 (10진수 표시) =====
add wave -format literal  -radix decimal  tb_SingleCycleCPU/Hex
add wave -format literal  -radix decimal  tb_SingleCycleCPU/J
add wave -format literal  -radix decimal  tb_SingleCycleCPU/R
add wave -format literal  -radix decimal  tb_SingleCycleCPU/I
add wave -format literal  -radix decimal  tb_SingleCycleCPU/TotalCycles

# ===== Syscall 관련 신호 =====
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/Inst
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/Din
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/Dout
add wave -format logic    -radix binary       tb_SingleCycleCPU/uut/IsSyscall
add wave -format literal  -radix decimal      tb_SingleCycleCPU/uut/R1      ;# v0
add wave -format literal  -radix decimal      tb_SingleCycleCPU/uut/R2      ;# a0
add wave -format literal  -radix decimal      tb_SingleCycleCPU/uut/Hex
add wave -format logic    -radix binary       tb_SingleCycleCPU/uut/Halt

add wave -format literal -radix decimal tb_SingleCycleCPU/uut/X
add wave -format literal -radix decimal tb_SingleCycleCPU/uut/Y
add wave -format literal -radix binary  tb_SingleCycleCPU/uut/ALUop
add wave -format literal -radix decimal tb_SingleCycleCPU/uut/ALU_Result

add wave -format literal -radix decimal tb_SingleCycleCPU/uut/RW      ;# 쓰기 대상
add wave -format logic   -radix binary  tb_SingleCycleCPU/uut/WE      ;# 쓰기 enable
add wave -format literal -radix decimal tb_SingleCycleCPU/uut/Din
add wave -format logic -radix binary tb_SingleCycleCPU/uut/RegDst


# ===== 실행 =====
run 100ns
