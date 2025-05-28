`timescale 1ns/1ps

module tb_Statistics;

    reg [5:0] op;
    wire i, r, j;

    Statistics uut (
        .op(op),
        .i(i),
        .r(r),
        .j(j)
    );

    initial begin
        // R-type
        op = 6'b000000; #10; print_type("R-type");

        // J-type
        op = 6'b000010; #10; print_type("J");
        op = 6'b000011; #10; print_type("JAL");

        // I-type
        op = 6'b001000; #10; print_type("ADDI");
        op = 6'b001001; #10; print_type("ADDIU");
        op = 6'b001010; #10; print_type("SLTI");
        op = 6'b001100; #10; print_type("ANDI");
        op = 6'b001101; #10; print_type("ORI");
        op = 6'b000100; #10; print_type("BEQ");
        op = 6'b000101; #10; print_type("BNE");
        op = 6'b100011; #10; print_type("LW");
        op = 6'b101011; #10; print_type("SW");

        // Unknown
        op = 6'b111111; #10; print_type("Unknown");
    end

    task print_type(input [64*8:1] name);
        $display("[%s] op=%b | i=%b | r=%b | j=%b", name, op, i, r, j);
    endtask

endmodule
