module RegisterRead_Decoder(
    input [5:0] op,
    input [5:0] Funct,
    output ReadRs,
    output ReadRt
);

    wire RTYPE, BEQ, BNE, ADDI, ADDIU, SLTI, ANDI, ORI, BEQ, COP0, LW, SW;

    assign RTYPE = !op[0] && !op[1] && !op[2] && !op[3] && !op[4] && !op[5]; //000000
    assign BEQ   = !op[0] && !op[1] && !op[2] &&  op[3] && !op[4] && !op[5]; //000100
    assign BNE   = !op[0] && !op[1] && !op[2] &&  op[3] && !op[4] &&  op[5]; //000101
    assign ADDI  = !op[0] && !op[1] &&  op[2] && !op[3] && !op[4] && !op[5]; //001000
    assign ADDIU = !op[0] && !op[1] &&  op[2] && !op[3] && !op[4] &&  op[5]; //001001
    assign SLTI  = !op[0] && !op[1] &&  op[2] && !op[3] && !op[4] &&  op[5]; //001010
    assign ANDI  = !op[0] && !op[1] &&  op[2] &&  op[3] && !op[4] && !op[5]; //001100
    assign ORI   = !op[0] && !op[1] &&  op[2] &&  op[3] && !op[4] &&  op[5]; //001101
    assign COP0  = !op[0] &&  op[1] && !op[2] && !op[3] && !op[4] && !op[5]; //010000
    assign LW    =  op[0] && !op[1] && !op[2] && !op[3] &&  op[4] &&  op[5]; //100011
    assign SW    =  op[0] && !op[1] &&  op[2] && !op[3] &&  op[4] &&  op[5]; //101011

    wire SLL, SRL, SRA, JR, ADD, ADDU, SUB, AND, OR, NOR, SLT, SLTU;

    assign SLL  = !Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] && !Funct[4] && !Funct[5]; //000000
    assign SRL  = !Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] &&  Funct[4] && !Funct[5]; //000010
    assign SRA  = !Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] &&  Funct[4] &&  Funct[5]; //000011
    assign JR   = !Funct[0] && !Funct[1] &&  Funct[2] && !Funct[3] && !Funct[4] && !Funct[5]; //001000
    assign ADD  =  Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] && !Funct[4] && !Funct[5]; //100000
    assign ADDU =  Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] && !Funct[4] &&  Funct[5]; //100001
    assign SUB  =  Funct[0] && !Funct[1] && !Funct[2] && !Funct[3] &&  Funct[4] && !Funct[5]; //100010
    assign AND  =  Funct[0] && !Funct[1] && !Funct[2] &&  Funct[3] && !Funct[4] && !Funct[5]; //100100
    assign OR   =  Funct[0] && !Funct[1] && !Funct[2] &&  Funct[3] && !Funct[4] &&  Funct[5]; //100101
    assign NOR  =  Funct[0] && !Funct[1] && !Funct[2] &&  Funct[3] &&  Funct[4] &&  Funct[5]; //100111
    assign SLT  =  Funct[0] && !Funct[1] &&  Funct[2] && !Funct[3] &&  Funct[4] && !Funct[5]; //101010
    assign SLTU =  Funct[0] && !Funct[1] &&  Funct[2] && !Funct[3] &&  Funct[4] &&  Funct[5]; //101011

    assign ReadRs = (RTYPE && (ADD || AND || ADDU || SUB || OR || NOR || SLT || SLTU || JR)) ||
        ADDI || ADDIU || ANDI || ORI || LW || BEQ || BNE || SLTI || SW;
    
    assign ReadRt = (RTYPE && (ADD || ADDU || AND || SLL || SRA || SRL || SUB || OR || NOR || SLT || SLTU)) ||
        BEQ || BNE || COP0 || SW;

endmodule
