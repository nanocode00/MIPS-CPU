module Divider (
    input [31:0] X,
    input [31:0] Y,
    input upper,          // unused
    output [31:0] result, // quotient
    output [31:0] rem     // remainder
);

    assign result = (Y != 0) ? X / Y : 32'hFFFFFFFF;
    assign rem = (Y != 0) ? X % Y : 32'hDEAD_BEEF;

endmodule
