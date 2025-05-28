module ImmediateExtender(
    input [15:0] ImmIn,
    input ZeroExtend,
    output [31:0] ImmOut
);

    assign ImmOut = ZeroExtend ? {16'h0000, ImmIn} : {{16{ImmIn[15]}}, ImmIn};

endmodule