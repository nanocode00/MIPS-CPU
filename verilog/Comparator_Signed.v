module Comparator_Signed (
    input signed [31:0] X,
    input signed [31:0] Y,
    output gt,
    output eq,
    output lt
);

    assign gt = X > Y;
    assign eq = X == Y;
    assign lt = X < Y;

endmodule
