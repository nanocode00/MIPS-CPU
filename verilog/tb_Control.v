`timescale 1ns/1ps

module tb_Control;

    reg [5:0] op;
    reg [5:0] funct;
    wire IsJAL, RegWrite, MemtoReg, IsCOP0, MemWrite, MemRead, IsJR, Branch, BneOrBeq, Jump;
    wire [3:0] ALUop;
    wire ALUSrc, IsShamt, IsSyscall, ZeroExtend, RegDst, ReadRs, ReadRt;

    Control uut (
        .op(op),
        .Funct(funct),
        .IsJAL(IsJAL),
        .RegWrite(RegWrite),
        .MemtoReg(MemtoReg),
        .IsCOP0(IsCOP0),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .IsJR(IsJR),
        .Branch(Branch),
        .BneOrBeq(BneOrBeq),
        .Jump(Jump),
        .ALUop(ALUop),
        .ALUSrc(ALUSrc),
        .IsShamt(IsShamt),
        .IsSyscall(IsSyscall),
        .ZeroExtend(ZeroExtend),
        .RegDst(RegDst),
        .ReadRs(ReadRs),
        .ReadRt(ReadRt)
    );

    initial begin
        $display("Time\tOp\tFunct\tIsJAL\tRegWrite\tMemRead\tMemWrite\tALUSrc\tALUop");
        
        // R-type: ADD
        op = 6'b000000; funct = 6'b100000; #10;
        $display("%0t\t%h\t%h\t%b\t%b\t\t%b\t%b\t\t%b\t%h", $time, op, funct, IsJAL, RegWrite, MemRead, MemWrite, ALUSrc, ALUop);

        // ADDI
        op = 6'b001000; funct = 6'bxxxxxx; #10;

        // ANDI
        op = 6'b001100; funct = 6'bxxxxxx; #10;

        // LW
        op = 6'b100011; funct = 6'bxxxxxx; #10;

        // SW
        op = 6'b101011; funct = 6'bxxxxxx; #10;

        // JAL
        op = 6'b000011; funct = 6'bxxxxxx; #10;

        // JR
        op = 6'b000000; funct = 6'b001000; #10;

        // SYSCALL
        op = 6'b000000; funct = 6'b001100; #10;

        $finish;
    end

endmodule
