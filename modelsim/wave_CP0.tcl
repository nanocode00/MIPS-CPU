vsim work.tb_CP0
delete wave *

# 입력 신호
add wave -format logic     -radix binary      tb_CP0/clk
add wave -format literal   -radix binary      tb_CP0/enable
add wave -format literal   -radix binary      tb_CP0/ExpSrc
add wave -format literal   -radix hexadecimal tb_CP0/Inst
add wave -format literal   -radix hexadecimal tb_CP0/PCin
add wave -format literal   -radix hexadecimal tb_CP0/Din

# 출력 신호
add wave -format literal   -radix binary      tb_CP0/IsEret
add wave -format literal   -radix binary      tb_CP0/HasExp
add wave -format literal   -radix binary      tb_CP0/ExRegWrite
add wave -format literal   -radix binary      tb_CP0/ExpBlock
add wave -format literal   -radix hexadecimal tb_CP0/PCout
add wave -format literal   -radix hexadecimal tb_CP0/Dout

run 100ns
