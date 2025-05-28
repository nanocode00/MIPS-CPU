module Control(
    input [5:0] op,
    input [5:0] Funct,
    output IsJAL,
    output RegWrite,
    output MemtoReg,
    output IsCOP0,
    output MemWrite,
    output MemRead,
    output IsJR,
    output Branch,
    output BneOrBeq,
    output Jump,
    output [3:0] ALUop,
    output ALUSrc,
    output IsShamt,
    output IsSyscall,
    output ZeroExtend,
    output RegDst,
    output ReadRs,
    output ReadRt
);

    wire RTYPE, COP0;
    assign RTYPE = op == 6'b000000;
    assign COP0  = op == 6'b010000;

    // OP Decoding
    Opcode_Decoder opcode_decoder(op, MemRead, MemWrite, ALUSrc, Jump, MemtoReg, Branch, RegDst, RegWrite, BneOrBeq, IsJAL, ZeroExtend);
    RegisterRead_Decoder registerread_decoder(op, Funct, ReadRs, ReadRt);

    // ALU Decoding
    wire [3:0] ALUop_F, ALUop_A;
    wire jr, syscall, shamt;

    Funct_Decoder funct_decoder(Funct, ALUop_F, jr, syscall, shamt);
    ALU_Decoder alu_decoder(op, ALUop_A);

    wire IsSpecial;
    assign IsSpecial = RTYPE;
    
    assign IsJR = IsSpecial ? jr : 1'b0;
    assign IsSyscall = IsSpecial ? syscall : 1'b0;
    assign IsShamt = IsSpecial ? shamt : 1'b0;

    assign ALUop = (!IsSpecial) ? ALUop_A : ALUop_F;

    assign IsCOP0 = COP0;

endmodule
