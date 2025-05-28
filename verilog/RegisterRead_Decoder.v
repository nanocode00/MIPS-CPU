module RegisterRead_Decoder(
    input [5:0] op,
    input [5:0] Funct,
    output ReadRs,
    output ReadRt
);

    wire RTYPE, BEQ, BNE, ADDI, ADDIU, SLTI, ANDI, ORI, COP0, LW, SW;

    assign RTYPE = op == 6'b000000;
    assign BEQ   = op == 6'b000100;
    assign BNE   = op == 6'b000101;
    assign ADDI  = op == 6'b001000;
    assign ADDIU = op == 6'b001001;
    assign SLTI  = op == 6'b001010;
    assign ANDI  = op == 6'b001100;
    assign ORI   = op == 6'b001101;
    assign COP0  = op == 6'b010000;
    assign LW    = op == 6'b100011;
    assign SW    = op == 6'b101011;

    wire SLL, SRL, SRA, JR, ADD, ADDU, SUB, AND, OR, NOR, SLT, SLTU;

    assign SLL     = Funct == 6'b000000;
    assign SRL     = Funct == 6'b000010;
    assign SRA     = Funct == 6'b000011;
    assign JR      = Funct == 6'b001000;
    assign ADD     = Funct == 6'b100000;
    assign ADDU    = Funct == 6'b100001;
    assign SUB     = Funct == 6'b100010;
    assign AND     = Funct == 6'b100100;
    assign OR      = Funct == 6'b100101;
    assign NOR     = Funct == 6'b100111;
    assign SLT     = Funct == 6'b101010;
    assign SLTU    = Funct == 6'b101011;

    assign ReadRs = (RTYPE && (ADD || AND || ADDU || SUB || OR || NOR || SLT || SLTU || JR)) ||
        ADDI || ADDIU || ANDI || ORI || LW || BEQ || BNE || SLTI || SW;
    
    assign ReadRt = (RTYPE && (ADD || ADDU || AND || SLL || SRA || SRL || SUB || OR || NOR || SLT || SLTU)) ||
        BEQ || BNE || COP0 || SW;

endmodule
