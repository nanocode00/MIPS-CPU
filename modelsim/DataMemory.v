module DataMemory (
    input clk,
    input Load,
    input Store,
    input [9:0] Address,
    input [31:0] DataIn,
    output reg [31:0] DataOut
);

    reg [31:0] ram [0:1023]; // 0 ~ 3FF

    integer i;
    initial begin
        for (i = 0; i < 1024; i = i + 1)
            ram[i] = 32'b0;
        DataOut = 32'b0;
    end

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
