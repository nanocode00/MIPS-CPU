module Funct_Decoder(
    input [5:0] Funct,
    output [3:0] ALU,
    output IsJR,
    output IsSyscall,
    output IsShamt
);

    wire SLL, SRL, SRA, JR, SYSCALL, ADD, ADDU, SUB, AND, OR, NOR, SLT, SLTU;

    assign SLL     = !Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] && !Funct[4] && !Funct[5]; //000000
    assign SRL     = !Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] &&  Funct[4] && !Funct[5]; //000010
    assign SRA     = !Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] &&  Funct[4] &&  Funct[5]; //000011
    assign JR      = !Funct[0] && !Funct[1] &&  Funct[2] && !Funct[3] && !Funct[4] && !Funct[5]; //001000
    assign SYSCALL = !Funct[0] && !Funct[1] &&  Funct[2] &&  Funct[3] && !Funct[4] && !Funct[5]; //001100
    assign ADD     =  Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] && !Funct[4] && !Funct[5]; //100000
    assign ADDU    =  Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] && !Funct[4] &&  Funct[5]; //100001
    assign SUB     =  Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] &&  Funct[4] && !Funct[5]; //100010
    assign AND     =  Funct[0] && !Funct[1] && !Funct[2] &&  Funct[3] && !Funct[4] && !Funct[5]; //100100
    assign OR      =  Funct[0] && !Funct[1] && !Funct[2] &&  Funct[3] && !Funct[4] &&  Funct[5]; //100101
    assign NOR     =  Funct[0] && !Funct[1] && !Funct[2] &&  Funct[3] &&  Funct[4] &&  Funct[5]; //100111
    assign SLT     =  Funct[0] && !Funct[1] &&  Funct[2] && !Funct[3] &&  Funct[4] && !Funct[5]; //101010
    assign SLTU    =  Funct[0] && !Funct[1] &&  Funct[2] && !Funct[3] &&  Funct[4] &&  Funct[5]; //101011

    assign ALU[0]    = OR || NOR || SLT || SLTU;
    assign ALU[1]    = ADD || ADDU || SUB || AND || SLTU;
    assign ALU[2]    = SUB || AND || SRL || NOR || SLT;
    assign ALU[3]    = SRA || ADD || ADDU || AND || SLT;
    assign IsJR      = JR;
    assign IsSyscall = SYSCALL;
    assign IsShamt   = SRA || SRL || SLL;

endmodule
