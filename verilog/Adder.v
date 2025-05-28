module Adder(
    input [31:0] X,
    input [31:0] Y,
    input cin,
    output [31:0] Result,
    output CF,
    output OF
);

    wire [32:0] sum_ext;
    assign sum_ext = {1'b0, X} + {1'b0, Y} + cin;
    assign Result = sum_ext[31:0];
    assign CF = sum_ext[32];
    assign OF = (X[31] == Y[31]) && (Result[31] != X[31]);

endmodule
