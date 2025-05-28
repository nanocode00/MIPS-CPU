vsim work.tb_ImmediateExtender
delete wave *

# 입력
add wave -format literal -radix hexadecimal tb_ImmediateExtender/ImmIn
add wave -format literal -radix binary      tb_ImmediateExtender/ZeroExtend

# 출력
add wave -format literal -radix hexadecimal tb_ImmediateExtender/ImmOut

run 100ns
