vsim work.tb_Statistics
delete wave *

# 입력
add wave -format literal -radix binary tb_Statistics/op

# 출력
add wave -format literal -radix binary tb_Statistics/i
add wave -format literal -radix binary tb_Statistics/r
add wave -format literal -radix binary tb_Statistics/j

run 150ns
