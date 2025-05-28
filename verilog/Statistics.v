module Statistics(
    input [5:0] op,
    output i,
    output r,
    output j
);

    wire RTYPE, J, JAL, BEQ, BNE, ADDI, ADDIU, SLTI, ANDI, ORI, LW, SW;

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
    assign LW    = op == 6'b100011;
    assign SW    = op == 6'b101011;

    assign i = LW || SW || BNE || BEQ || ANDI || ORI || SLTI || ADDI || ADDIU;
    assign r = RTYPE;
    assign j = J || JAL;

endmodule