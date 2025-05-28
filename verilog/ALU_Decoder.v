module ALU_Decoder(
    input [5:0] op,
    output [3:0] ALUop
);

    wire RTYPE, J, JAL, BEQ, BNE, ADDI, ADDIU, SLTI, ANDI, ORI, COP0, LW, SW;

    assign RTYPE = op == 6'b000000;
    assign J     = op == 6'b000010;
    assign JAL   = op == 6'b000011;
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

    assign ALUop[0] = ANDI || SLTI;
    assign ALUop[1] = RTYPE || LW || SW || BNE || BEQ || ANDI || ADDIU || ADDI || J || JAL || COP0;
    assign ALUop[2] = ANDI || SLTI;
    assign ALUop[3] = RTYPE || LW || SW || BNE || BEQ || ANDI || SLTI || ADDIU || ADDI || J || JAL || COP0;

endmodule
