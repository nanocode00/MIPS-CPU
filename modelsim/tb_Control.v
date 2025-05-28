`timescale 1ns/1ps

module tb_Control;

    reg [5:0] op;
    reg [5:0] Funct;
    wire IsJAL, RegWrite, MemtoReg, IsCOP0, MemWrite, MemRead;
    wire IsJR, Branch, BneOrBeq, Jump;
    wire [3:0] ALUop;
    wire ALUSrc, IsShamt, IsSyscall, ZeroExtend, RegDst, ReadRs, ReadRt;

    Control uut (
        .op(op),
        .Funct(Funct),
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
        $display("Time | op | Funct | Outputs...");

        // R-type: add
        op = 6'b000000; Funct = 6'b100000; #10;
        print_outputs;

        // R-type: jr
        op = 6'b000000; Funct = 6'b001000; #10;
        print_outputs;

        // R-type: syscall
        op = 6'b000000; Funct = 6'b001100; #10;
        print_outputs;

        // lw
        op = 6'b100011; Funct = 6'bxxxxxx; #10;
        print_outputs;

        // sw
        op = 6'b101011; Funct = 6'bxxxxxx; #10;
        print_outputs;

        // beq
        op = 6'b000100; Funct = 6'bxxxxxx; #10;
        print_outputs;

        // j
        op = 6'b000010; Funct = 6'bxxxxxx; #10;
        print_outputs;

        // jal
        op = 6'b000011; Funct = 6'bxxxxxx; #10;
        print_outputs;
    end

    task print_outputs;
        begin
            $display("Time=%0t | op=%b | Funct=%b | IsJAL=%b | RegWrite=%b | MemtoReg=%b | IsCOP0=%b | MemWrite=%b | MemRead=%b | IsJR=%b | Branch=%b | BneOrBeq=%b | Jump=%b | ALUop=%b | ALUSrc=%b | IsShamt=%b | IsSyscall=%b | ZeroExtend=%b | RegDst=%b | ReadRs=%b | ReadRt=%b",
                     $time, op, Funct,
                     IsJAL, RegWrite, MemtoReg, IsCOP0, MemWrite, MemRead,
                     IsJR, Branch, BneOrBeq, Jump, ALUop,
                     ALUSrc, IsShamt, IsSyscall, ZeroExtend, RegDst, ReadRs, ReadRt);
        end
    endtask

endmodule
