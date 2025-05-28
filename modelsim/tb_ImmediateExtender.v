`timescale 1ns/1ps

module tb_ImmediateExtender;

    reg [15:0] ImmIn;
    reg ZeroExtend;
    wire [31:0] ImmOut;

    ImmediateExtender uut (
        .ImmIn(ImmIn),
        .ZeroExtend(ZeroExtend),
        .ImmOut(ImmOut)
    );

    initial begin
        // Zero extension 테스트
        ImmIn = 16'h1234; ZeroExtend = 1; #10; print_output("ZeroExtend=1 (양수)");
        ImmIn = 16'hFFFF; ZeroExtend = 1; #10; print_output("ZeroExtend=1 (음수)");

        // Sign extension 테스트
        ImmIn = 16'h1234; ZeroExtend = 0; #10; print_output("ZeroExtend=0 (양수)");
        ImmIn = 16'hFFFF; ZeroExtend = 0; #10; print_output("ZeroExtend=0 (음수)");
        ImmIn = 16'h8000; ZeroExtend = 0; #10; print_output("ZeroExtend=0 (최소 음수)");
    end

    task print_output(input [63*8:1] label);
        $display("[%s] ImmIn=%h | ZeroExtend=%b | ImmOut=%h",
                 label, ImmIn, ZeroExtend, ImmOut);
    endtask

endmodule
