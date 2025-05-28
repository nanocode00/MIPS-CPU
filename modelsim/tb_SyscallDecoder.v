`timescale 1ns/1ps

module tb_SyscallDecoder;

    reg clk;
    reg Enable;
    reg [31:0] v0, a0;
    wire Halt;
    wire [31:0] Hex;

    SyscallDecoder uut (
        .clk(clk),
        .Enable(Enable),
        .v0(v0),
        .a0(a0),
        .Halt(Halt),
        .Hex(Hex)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // 초기화
        Enable = 0; v0 = 32'd0; a0 = 32'd0; #10;

        // 정상 syscall (v0 != 10)
        Enable = 1; v0 = 32'd1; a0 = 32'h12345678; #10;
        print_status("Syscall v0 != 10");

        // 종료 syscall (v0 == 10)
        Enable = 1; v0 = 32'd10; a0 = 32'hCAFEBABE; #10;
        print_status("Syscall v0 == 10 (should halt)");

        // Disable 상태
        Enable = 0; v0 = 32'd10; a0 = 32'hAAAAAAAA; #10;
        print_status("Syscall disabled");
    end

    task print_status(input [63*8:1] label);
        $display("[%s] v0=%d | a0=%h | Halt=%b | Hex=%h", label, v0, a0, Halt, Hex);
    endtask

endmodule
