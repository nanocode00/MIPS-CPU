module Control(
    input [5:0] op,
    input [5:0] Funct,
    output IsJAL,
    output IsShamt,
    output MemtoReg,
    output RegWrite,
    output BneOrBeq,
    output [3:0] ALUop,
    output ALUSrc,
    output IsSyscall,
    output ZeroExtend,
    output MemRead,
    output MemWrite,
    output Jump,
    output Branch,
    output RegDst,
    output IsJR,
    output IsCOP0,
    output ReadRs,
    output ReadRt
);

    wire RTYPE, COP0;
    assign RTYPE = !op[0] && !op[1] && !op[2] && !op[3] && !op[4] && !op[5]; //000000
    assign COP0  = !op[0] &&  op[1] && !op[2] && !op[3] && !op[4] && !op[5]; //010000

    Opcode_Decoder opcode_decoder(op, MemRead, MemWrite, ALUSrc, Jump, MemtoReg, Branch, RegDst, RegWrite, BneOrBeq, IsJAL, ZeroExtend);
    RegisterRead_Decoder registerread_decoder(op, Funct, ReadRs, ReadRt);

    wire [3:0] ALUop_F, ALUop_A;
    wire jr, syscall, shamt;

    Funct_Decoder funct_decoder(Funct, ALUop_F, jr, syscall, shamt);
    ALU_Decoder alu_decoder(op, ALUop_A);

    wire IsSpecial;
    assign IsSpecial = RTYPE;
    
    mux2to1 mux_jr(1'b0, jr, IsSpecial, IsJR);
    mux2to1 mux_syscall(1'b0, syscall, IsSpecial, IsSyscall);
    mux2to1 mux_shamt(1'b0, shamt, IsSpecial, IsShamt);

    mux2to1vec4 mux_aluop(ALUop_F, ALUop_A, !IsSpecial, ALUop);

    assign IsCOP0 = COP0;

endmodule

module mux2to1(
    input a,
    input b,
    input sel,
    output o
);

    assign o = (!sel && a) || (sel && b);

endmodule


module mux2to1vec4(
    input [3:0] a,
    input [3:0] b,
    input sel,
    output [3:0] o
);

    assign o = ({4{!sel}} & a) | ({4{sel}} & b);

endmodule
