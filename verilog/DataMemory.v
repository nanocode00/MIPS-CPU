module DataMemory (
    input clk,
    input Load,
    input Store,
    input [9:0] Address,
    input [31:0] DataIn,
    output [31:0] DataOut
);

    reg [31:0] ram [0:1023]; // 0 ~ 3FF

    always @(posedge clk) begin
        if (Store)
            ram[Address] <= DataIn;
    end

    always @(*) begin
        if (Load)
            DataOut = ram[Address];
        else
            DataOut = 32'h00000000;
    end

endmodule
