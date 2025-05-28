module Funct_Decoder(
    input [5:0] Funct,
    output [3:0] ALU,
    output IsJR,
    output IsSyscall,
    output IsShamt
);

    wire SLL, SRL, SRA, JR, SYSCALL, ADD, ADDU, SUB, AND, OR, NOR, SLT, SLTU;

    assign SLL     = Funct == 6'b000000;
    assign SRL     = Funct == 6'b000010;
    assign SRA     = Funct == 6'b000011;
    assign JR      = Funct == 6'b001000;
    assign SYSCALL = Funct == 6'b001100;
    assign ADD     = Funct == 6'b100000;
    assign ADDU    = Funct == 6'b100001;
    assign SUB     = Funct == 6'b100010;
    assign AND     = Funct == 6'b100100;
    assign OR      = Funct == 6'b100101;
    assign NOR     = Funct == 6'b100111;
    assign SLT     = Funct == 6'b101010;
    assign SLTU    = Funct == 6'b101011;

    assign ALU[0]    = OR || NOR || SLT || SLTU;
    assign ALU[1]    = ADD || ADDU || SUB || AND || SLTU;
    assign ALU[2]    = SUB || AND || SRL || NOR || SLT;
    assign ALU[3]    = SRA || ADD || ADDU || AND || SLT;
    assign IsJR      = JR;
    assign IsSyscall = SYSCALL;
    assign IsShamt   = SRA || SRL || SLL;

endmodule
