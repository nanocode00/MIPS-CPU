module Multiplier (
    input [31:0] X,
    input [31:0] Y,
    input cin,            // unused
    output [31:0] result, // lower 32 bits
    output [31:0] hi      // upper 32 bits
);

    assign {hi, result} = X * Y;

endmodule
