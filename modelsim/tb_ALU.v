`timescale 1ns/1ps

module tb_ALU;

    reg [31:0] X, Y;
    reg [3:0] S;
    wire [31:0] Result1, Result2;
    wire CF, OF, Equal;

    ALU uut (
        .X(X),
        .Y(Y),
        .S(S),
        .Result1(Result1),
        .Result2(Result2),
        .CF(CF),
        .OF(OF),
        .Equal(Equal)
    );

    initial begin
        // 테스트 케이스
        X = 32'd10; Y = 32'd5; S = 4'b0000; #10; print_outputs;
        X = 32'd100; Y = 32'd200; S = 4'b0010; #10; print_outputs;
        X = 32'd50; Y = 32'd50; S = 4'b0011; #10; print_outputs;
        X = 32'hFFFFFFFF; Y = 32'd1; S = 4'b0100; #10; print_outputs;
        X = 32'h80000000; Y = 32'h80000000; S = 4'b0101; #10; print_outputs;
    end

    task print_outputs;
        begin
            $display("Time=%0t | X=%d | Y=%d | S=%b | Result1=%d | Result2=%d | CF=%b | OF=%b | Equal=%b",
                     $time, X, Y, S, Result1, Result2, CF, OF, Equal);
        end
    endtask

endmodule
