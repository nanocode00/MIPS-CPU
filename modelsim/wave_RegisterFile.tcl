vsim work.tb_RegisterFile
delete wave *

# 입력 신호
add wave -format logic  -radix binary      tb_RegisterFile/clk
add wave -format literal -radix binary     tb_RegisterFile/WE
add wave -format literal -radix binary     tb_RegisterFile/reg1_number
add wave -format literal -radix binary     tb_RegisterFile/reg2_number
add wave -format literal -radix binary     tb_RegisterFile/write_reg_number
add wave -format literal -radix hexadecimal tb_RegisterFile/write_data

# 출력 신호
add wave -format literal -radix hexadecimal tb_RegisterFile/reg1
add wave -format literal -radix hexadecimal tb_RegisterFile/reg2
add wave -format literal -radix hexadecimal tb_RegisterFile/a0
add wave -format literal -radix hexadecimal tb_RegisterFile/v0

run 100ns
