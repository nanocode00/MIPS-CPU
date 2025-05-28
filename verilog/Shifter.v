module Shifter (
    input [31:0] in,
    input [4:0] shamt,
    input [1:0] ctrl, // 00: SLL, 01: SRA, 10: SRL
    output reg [31:0] out
);

    always @(*) begin
        case (ctrl)
            2'b00: out = in << shamt;
            2'b01: out = $signed(in) >>> shamt;
            2'b10: out = in >> shamt;
            default: out = 32'bx;
        endcase
    end

endmodule
