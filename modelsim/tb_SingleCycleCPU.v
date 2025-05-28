`timescale 1ns/1ps

module tb_SingleCycleCPU;

    reg Clock;
    reg [2:0] ExpSrc;
    wire [31:0] Hex;
    wire [31:0] J, R, I, TotalCycles;

    SingleCycleCPU uut (
        .Clock(Clock),
        .ExpSrc(ExpSrc),
        .Hex(Hex),
        .J(J),
        .R(R),
        .I(I),
        .TotalCycles(TotalCycles)
    );

    initial begin
        Clock = 0;
        #5;
        forever #5 Clock = ~Clock;
    end

    initial begin
        ExpSrc = 3'b000;  // 예외 없음
    end

    always @(posedge Clock) begin
        $display("Time: %0t | Stats - J: %0d, R: %0d, I: %0d | TotalCycles: %0d | Hex: %0d",
                 $time, J, R, I, TotalCycles, Hex);
    end

endmodule
