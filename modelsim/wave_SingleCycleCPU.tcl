vsim work.tb_SingleCycleCPU
delete wave *

# ===== 입력 =====
add wave -format logic    -radix binary   tb_SingleCycleCPU/Clock
add wave -format literal  -radix binary   tb_SingleCycleCPU/ExpSrc

# ===== 출력 =====
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/Hex
add wave -format literal  -radix decimal      tb_SingleCycleCPU/J
add wave -format literal  -radix decimal      tb_SingleCycleCPU/R
add wave -format literal  -radix decimal      tb_SingleCycleCPU/I
add wave -format literal  -radix decimal      tb_SingleCycleCPU/TotalCycles

# ===== PC 관련 신호 =====
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/PC
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/PC_plus_4
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/PC_Buffer
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/PCout
add wave -format literal  -radix hexadecimal  tb_SingleCycleCPU/uut/Inst

# 시뮬레이션 실행
run 100ns
