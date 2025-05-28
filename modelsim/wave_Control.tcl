# wave_Control.tcl
# ModelSim 시뮬레이션 실행 및 신호 추가 스크립트

vsim work.tb_Control

# 파형 초기화
delete wave *

# 입력 신호
add wave -format literal -radix binary tb_Control/op
add wave -format literal -radix binary tb_Control/Funct

# 출력 신호
add wave -format literal -radix binary tb_Control/IsJAL
add wave -format literal -radix binary tb_Control/RegWrite
add wave -format literal -radix binary tb_Control/MemtoReg
add wave -format literal -radix binary tb_Control/IsCOP0
add wave -format literal -radix binary tb_Control/MemWrite
add wave -format literal -radix binary tb_Control/MemRead
add wave -format literal -radix binary tb_Control/IsJR
add wave -format literal -radix binary tb_Control/Branch
add wave -format literal -radix binary tb_Control/BneOrBeq
add wave -format literal -radix binary tb_Control/Jump
add wave -format literal -radix binary tb_Control/ALUop
add wave -format literal -radix binary tb_Control/ALUSrc
add wave -format literal -radix binary tb_Control/IsShamt
add wave -format literal -radix binary tb_Control/IsSyscall
add wave -format literal -radix binary tb_Control/ZeroExtend
add wave -format literal -radix binary tb_Control/RegDst
add wave -format literal -radix binary tb_Control/ReadRs
add wave -format literal -radix binary tb_Control/ReadRt

# 시뮬레이션 실행
run 100ns
