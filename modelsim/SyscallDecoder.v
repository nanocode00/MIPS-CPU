module SyscallDecoder(
    input clk,
    input Enable,
    input [31:0] v0,
    input [31:0] a0,
    output Halt,
    output reg [31:0] Hex
);

    wire eq_signed;
    Comparator_Signed comparator_signed(v0, 32'h0000000a, , eq_signed, );
    assign Halt = Enable ? eq_signed : 0;

    initial begin
        Hex = 32'b0;
    end

    always @(posedge clk) begin
        if (Enable) Hex <= a0;
    end

endmodule