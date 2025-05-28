module RegisterFile (
    input [4:0] reg1_number,
    input [4:0] reg2_number,
    input [4:0] write_reg_number,
    input [31:0] write_data,
    input WE,
    input clk,
    output [31:0] reg1,
    output [31:0] reg2,
    output [31:0] a0,
    output [31:0] v0
);

    reg [31:0] registers [31:0];

    assign reg1 = (reg1_number == 0) ? 32'b0 : registers[reg1_number];
    assign reg2 = (reg2_number == 0) ? 32'b0 : registers[reg2_number];
    assign a0 = registers[4];
    assign v0 = registers[2];

    always @(posedge clk) begin
        if (WE && write_reg_number != 5'b0)
            registers[write_reg_number] <= write_data;
    end

endmodule
