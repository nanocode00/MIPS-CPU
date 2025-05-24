module Subtractor(
    input [31:0] X,
    input [31:0] Y,
    input bin,
    output [31:0] Result,
    output CF,
    output OF
);

    wire [31:0] w;
    fsub fsubs [31:0] (X, Y, {w[30:0], bin}, Result, w);
    assign CF = w[31];
    assign OF = w[31] ^ w[30];

endmodule

module fsub(
    input x,
    input y,
    input bin,
    output diff,
    output bout
);

    assign diff = x ^ y ^ bin;
    assign bout = (~x && y) || (bin && ~(x ^ y));

endmodule
