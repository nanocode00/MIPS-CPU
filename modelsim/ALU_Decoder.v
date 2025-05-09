module ALU_Decoder(
    input [5:0] op,
    output [3:0] ALUop
);

    wire RTYPE, J, JAL, BEQ, BNE, ADDI, ADDIU, SLTI, ANDI, ORI, BEQ, COP0, LW, SW;

    assign RTYPE = !op[0] && !op[1] && !op[2] && !op[3] && !op[4] && !op[5]; //000000
    assign J     = !op[0] && !op[1] && !op[2] && !op[3] &&  op[4] && !op[5]; //000010
    assign JAL   = !op[0] && !op[1] && !op[2] && !op[3] &&  op[4] &&  op[5]; //000011
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

    assign ALUop[0] = ANDI || SLTI;
    assign ALUop[1] = RTYPE || ADDI || LW || SW || BNE || BEQ || ANDI || ADDIU || ADDI || J || JAL || COP0;
    assign ALUop[2] = ANDI || SLTI;
    assign ALUop[3] = RTYPE || ADDI || LW || SW || BNE || BEQ || ANDI || SLTI || ADDIU || ADDI || J || JAL || COP0;

endmodule
