module Shifter (
    input [31:0] in,
    input [4:0] shamt,
    input [1:0] ctrl, // 00: SLL, 01: SRA, 10: SRL
    output reg [31:0] out
);

    initial out = 32'b0;

    always @(*) begin
        case (ctrl)
            2'b00: out = in << shamt;
            2'b01: out = $signed(in) >>> shamt;
            2'b10: out = in >> shamt;
            default: out = 32'b0;
        endcase
    end

endmodule
