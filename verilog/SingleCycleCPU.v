module SingleCycleCPU(
    input Clock,
    input [2:0] ExpSrc,
    output Hex,
    output J,
    output R,
    output I,
    output TotalCycles
);

    // wires
    wire clk, Halt;

    wire clk_PC;

    wire IsJAL, RegWrite, MemtoReg, IsCOP0, MemWrite, MemRead, IsJR, Branch, BneOrBeq, Jump, ALUSrc, IsShamt, IsSyscall, RegDst, ZeroExtend;
    wire [3:0] ALUop;

    wire [31:0] Inst;

    wire [4:0] R1N, R2N, RW;
    wire [31:0] R1, R2, Din;
    wire WE;

    wire [31:0] ImmExt;

    wire ExpBlock, IsEret, ExRegWrite, HasExp;
    wire [31:0] PCout, Dout;

    wire i, r, j;

    wire [31:0] X, Y, ALU_Result;
    wire Equal;

    wire [31:0] Data;

    // Clock Signal
    assign clk = Halt ? 1'b1 : Clock;
    
    // PC
    reg [31:0] PC;
    reg [31:0] PC_Buffer;

    assign clk_PC = ((IsEret && IsCOP0) || HasExp) ? (!clk) : clk;

    always @(posedge clk_PC) begin
        if (!HasExp) begin
            if (IsEret && IsCOP0) PC <= PCout;
            else begin
                if (IsJR) PC <= R1;
                else begin
                    if (!Jump) begin
                        if (Branch && (Equal ^ BneOrBeq)) PC <= PC + 4 + (ImmExt << 2);
                        else PC <= PC + 4
                    end
                    else PC <= {{(PC + 4)}[31:28], Inst[25:0], 2'b00};
                end
            end
        end
        else PC <= 32'h00000800;
    end


    always @(posedge HasExp) begin
        PC_Buffer <= PC;
    end
    
    // Instruction Memory
    InstructionMemory instructionmemory(PC[10:2], PC[11], Inst);

    // Control
    Control control(Inst[31:26], Inst[5:0], IsJAL, RegWrite, MemtoReg, IsCOP0, MemWrite, MemRead, IsJR, Branch, BneOrBeq, Jump, ALUop, ALUSrc, IsShamt, IsSyscall, RegDst, ZeroExtend, , );

    // RegFile
    assign R1N = IsSyscall ? 5'b00010 : Inst[25:21];
    assign R2N = IsSyscall ? 5'b00100 : Inst[20:16];
    assign RW = isJAL ? 5'b11111 : (RegDst ? Inst[15:11] : Inst[20:16]);
    assign Din = (!IsCOP0) ? ((!IsJAL) ? (MemtoReg ? Data : ALU_Result) : PC + 4) : Dout;
    assign WE = IsCOP0 ? ExRegWrite : RegWrite;
    RegisterFile registerfile(R1N, R2N, RW, Din, WE, clk, R1, R2, , );

    // Immediate Extender
    ImmediateExtender immediateextender(Inst[15:0], ZeroExtend, ImmExt);

    // CP0
    CP0 cp0(clk, IsCOP0, ExpSrc, Inst, PC_Buffer, R2, IsEret, HasExp, ExRegWrite, ExpBlock, PCout, Dout);

    // Statistics
    reg [31:0] RJ, RR, RI, Cycle;

    initial begin
        RJ <= 32'b0;
        RR <= 32'b0;
        RI <= 32'b0;
        Cycle <= 32'b0;
    end

    Statistics statistics(Inst[31:26], i, r, j);

    always @(posedge clk) begin
        RJ += j;
        RR += r;
        RI += i;
        Cycle++;
    end

    assign R = RR;
    assign J = RJ;
    assign I = RI;

    // ALU
    assign X = IsShamt ? R2 : R1;
    assign Y = IsShamt ? {27'b0, Inst[10:6]} : (ALUSrc ? ImmExt : R2);
    ALU alu(X, Y, ALUop, ALU_Result, , , , Equal);

    // Data Memory
    DataMemory datamemory(clk, MemRead, MemWrite, ALU_Result[11:2], R2, Data);

    // Syscall Decoder
    SyscallDecoder syscalldecoder(clk, IsSyscall, R1, R2, Halt, Hex);

endmodule