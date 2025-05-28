vsim work.tb_ALU
delete wave *

# 입력 신호 (hex)
add wave -format literal -radix hexadecimal tb_ALU/X
add wave -format literal -radix hexadecimal tb_ALU/Y
add wave -format literal -radix binary      tb_ALU/S

# 출력 신호 (hex 및 binary)
add wave -format literal -radix hexadecimal tb_ALU/Result1
add wave -format literal -radix hexadecimal tb_ALU/Result2
add wave -format literal -radix binary      tb_ALU/CF
add wave -format literal -radix binary      tb_ALU/OF
add wave -format literal -radix binary      tb_ALU/Equal

run 100ns
