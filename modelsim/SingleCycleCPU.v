module SingleCycleCPU(
    input Clock,
    input [2:0] ExpSrc,
    output [31:0] Hex,
    output reg [31:0] J,
    output reg [31:0] R,
    output reg [31:0] I,
    output reg [31:0] TotalCycles
);

    // wires
    wire clk, Halt;

    wire clk_PC;
    wire [31:0] PC_plus_4;

    wire IsJAL, RegWrite, MemtoReg, IsCOP0, MemWrite, MemRead, IsJR, Branch, BneOrBeq, Jump, ALUSrc, IsShamt, IsSyscall, RegDst, ZeroExtend;
    wire [0:3] ALUop;

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
    assign PC_plus_4 = PC + 4;

    initial PC <= 32'b00000000;
    initial PC_Buffer <= 32'b00000000;

    always @(posedge clk_PC) begin
        if (!HasExp) begin
            if (IsEret && IsCOP0) PC <= PCout;
            else begin
                if (IsJR) PC <= R1;
                else begin
                    if (!Jump) begin
                        if (Branch && (Equal ^ BneOrBeq)) PC <= PC_plus_4 + (ImmExt << 2);
                        else PC <= PC_plus_4;
                    end
                    else PC <= {PC_plus_4[31:28], Inst[25:0], 2'b00};
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
    assign RW = IsJAL ? 5'b11111 : (RegDst ? Inst[15:11] : Inst[20:16]);
    assign Din = (!IsCOP0) ? ((!IsJAL) ? (MemtoReg ? Data : ALU_Result) : PC + 4) : Dout;
    assign WE = IsCOP0 ? ExRegWrite : RegWrite;
    RegisterFile registerfile(R1N, R2N, RW, Din, WE, clk, R1, R2, , );

    // Immediate Extender
    ImmediateExtender immediateextender(Inst[15:0], ZeroExtend, ImmExt);

    // CP0
    CP0 cp0(clk, IsCOP0, ExpSrc, Inst, PC_Buffer, R2, IsEret, HasExp, ExRegWrite, ExpBlock, PCout, Dout);

    // Statistics
    initial begin
        J <= 32'b0;
        R <= 32'b0;
        I <= 32'b0;
        TotalCycles <= 32'b0;
    end

    Statistics statistics(Inst[31:26], i, r, j);

    always @(posedge clk) begin
        J = J + j;
        R = R + r;
        I = I + i;
        TotalCycles = TotalCycles + 1;
    end

    // ALU
    assign X = IsShamt ? R2 : R1;
    assign Y = IsShamt ? {27'b0, Inst[10:6]} : (ALUSrc ? ImmExt : R2);
    ALU alu(X, Y, ALUop, ALU_Result, , , , Equal);

    // Data Memory
    DataMemory datamemory(clk, MemRead, MemWrite, ALU_Result[11:2], R2, Data);

    // Syscall Decoder
    SyscallDecoder syscalldecoder(clk, IsSyscall, R1, R2, Halt, Hex);

endmodule
