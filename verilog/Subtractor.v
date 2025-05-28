module Subtractor(
    input [31:0] X,
    input [31:0] Y,
    input bin,
    output [31:0] Result,
    output CF,
    output OF
);

    wire [32:0] diff_ext;
    assign diff_ext = {1'b0, X} - {1'b0, Y} - bin;
    assign Result = diff_ext[31:0];
    assign CF = diff_ext[32];
    assign OF = (X[31] != Y[31]) && (Result[31] != X[31]);

endmodule
