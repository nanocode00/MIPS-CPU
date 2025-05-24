module Adder(
    input [31:0] X,
    input [31:0] Y,
    input cin,
    output [31:0] Result,
    output CF,
    output OF
);

    wire [31:0] w;
    fadd fadds [31:0] (X, Y, {w[30:0], cin}, Result, w);
    assign CF = w[31];
    assign OF = w[31] ^ w[30];

endmodule

module fadd(
    input x,
    input y,
    input cin,
    output sum,
    output cout
);

    assign sum = x ^ y ^ cin;
    assign cout = (x && y) || ((x ^ y) && cin);

endmodule
