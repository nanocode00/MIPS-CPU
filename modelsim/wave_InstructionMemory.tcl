vsim work.tb_InstructionMemory
delete wave *

# 입력
add wave -format literal -radix binary      tb_InstructionMemory/Address
add wave -format literal -radix binary      tb_InstructionMemory/sel

# 출력
add wave -format literal -radix hexadecimal tb_InstructionMemory/Data

run 100ns
