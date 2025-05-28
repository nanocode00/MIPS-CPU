module Comparator_Unsigned (
    input [31:0] X,
    input [31:0] Y,
    output gt,
    output eq,
    output lt
);

    assign gt = X > Y;
    assign eq = X == Y;
    assign lt = X < Y;

endmodule
