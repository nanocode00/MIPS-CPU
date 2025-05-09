module Opcode_Decoder(
    input [5:0] op,
    output MemRead,
    output MemWrite,
    output ALUSrc,
    output Jump,
    output MemtoReg,
    output Branch,
    output RegDst,
    output RegWrite,
    output BneBeq,
    output IsJAL,
    output ZeroExtend
);

    wire RTYPE, J, JAL, BEQ, BNE, ADDI, ADDIU, SLTI, ANDI, ORI, XORI, BEQ, COP0, LW, SW;

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
    assign XORI  = !op[0] && !op[1] &&  op[2] &&  op[3] &&  op[4] && !op[5]; //001110
    assign COP0  = !op[0] &&  op[1] && !op[2] && !op[3] && !op[4] && !op[5]; //010000
    assign LW    =  op[0] && !op[1] && !op[2] && !op[3] &&  op[4] &&  op[5]; //100011
    assign SW    =  op[0] && !op[1] &&  op[2] && !op[3] &&  op[4] &&  op[5]; //101011

    assign MemRead    = LW;
    assign MemWrite   = SW;
    assign ALUSrc     = ADDI || LW || SW || ANDI || ORI || SLTI || ADDIU || ADDI;
    assign Jump       = J || JAL;
    assign MemtoReg   = LW;
    assign Branch     = BEQ || BNE;
    assign RegDst     = RTYPE;
    assign RegWrite   = RTYPE || ADDI || LW || ANDI || ORI || SLTI || ADDIU || ADDI || JAL || COP0;
    assign BneBeq     = BNE;
    assign IsJAL      = JAL;
    assign ZeroExtend = ANDI || ORI || XORI;

endmodule
