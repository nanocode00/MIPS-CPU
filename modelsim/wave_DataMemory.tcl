vsim work.tb_DataMemory
delete wave *

# 입력 신호
add wave -format logic     -radix binary      tb_DataMemory/clk
add wave -format literal   -radix binary      tb_DataMemory/Load
add wave -format literal   -radix binary      tb_DataMemory/Store
add wave -format literal   -radix binary      tb_DataMemory/Address
add wave -format literal   -radix hexadecimal tb_DataMemory/DataIn

# 출력 신호
add wave -format literal   -radix hexadecimal tb_DataMemory/DataOut

run 100ns
