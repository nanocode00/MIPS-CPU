module CP0 (
    input clk,
    input enable,
    input [2:0] ExpSrc,
    input [31:0] Inst,
    input [31:0] PCin,
    input [31:0] Din,
    output IsEret,
    output HasExp,
    output ExRegWrite,
    output ExpBlock,
    output [31:0] PCout,
    output [31:0] Dout
);

    reg [31:0] EPC, Status, Block, Cause;
    reg counter0, counter1;

    wire [2:0] BlockSrc;
    wire [1:0] Sel;
    wire ExpClick;
    
    wire [2:0] Src;

    //Signal Decoding
    assign ExRegWrite = !Inst[23];
    assign Sel = Inst[12:11];
    assign IsEret = Inst[5:0] == 6'b000110;

    //Exception Signals
    assign Src = BlockSrc & ExpSrc;
    assign ExpClick = (|Src) && (!ExpBlock);
    
    always @(posedge ExpClick or posedge counter1) begin
        if (counter1) counter0 <= 1'b0;
        else counter0 <= 1'b1;
    end

    always @(negedge HasExp or posedge counter0) begin
        if (counter0) counter1 <= 1'b1;
        else counter1 <= 1'b0;
    end

    assign HasExp = clk && counter0;

    //Registers
    always @(*) begin
        if (!clk) begin
            if (HasExp) EPC <= PCin;
            else if (Sel == 2'b00 && (enable && !ExRegWrite)) EPC <= Din;
        end
    end

    assign PCout = EPC;

    always @(posedge clk) begin
        if (Sel == 2'b01 && (enable && !ExRegWrite))
            Status <= Din;
    end

    assign ExpBlock = Status;

    always @(posedge clk) begin
        if (Sel == 2'b10 && (enable && !ExRegWrite))
            Block <= Din;
    end

    assign BlockSrc = Block[2:0];

    always @(posedge ExpClick) begin
        Cause <= ({32{ExpSrc[0]}} & 32'h00000001) |
                 ({32{ExpSrc[1]}} & 32'h00000003) |
                 ({32{ExpSrc[2]}} & 32'h00000007);
    end

    always @(*) begin
        case (Sel)
            2'b00: Dout = PCout;
            2'b01: Dout = Status;
            2'b10: Dout = Block;
            2'b11: Dout = Cause;
        endcase
    end

endmodule