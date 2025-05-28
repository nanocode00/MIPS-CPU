vsim work.tb_SyscallDecoder
delete wave *

# 입력
add wave -format logic     -radix binary      tb_SyscallDecoder/clk
add wave -format literal   -radix binary      tb_SyscallDecoder/Enable
add wave -format literal   -radix hexadecimal tb_SyscallDecoder/v0
add wave -format literal   -radix hexadecimal tb_SyscallDecoder/a0

# 출력
add wave -format literal   -radix binary      tb_SyscallDecoder/Halt
add wave -format literal   -radix hexadecimal tb_SyscallDecoder/Hex

run 100ns
