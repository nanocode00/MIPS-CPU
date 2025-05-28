module SyscallDecoder(
    input clk,
    input Enable,
    input [31:0] v0,
    input [31:0] a0,
    output Halt,
    output [31:0] Hex
);

    wire eq_signed;
    Comparator_Signed comparator_signed(v0, 32'h0000000a, , eq_signed, );
    assign Halt = Enable ? eq_signed : 0;

    reg [31:0] reghex;
    always @(posedge clk) begin
        if (Enable) reghex <= a0;
    end

    assign Hex = reghex;


endmodule