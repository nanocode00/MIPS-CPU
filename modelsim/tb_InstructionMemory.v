`timescale 1ns/1ps

module tb_InstructionMemory;

    reg [8:0] Address;
    reg sel;
    wire [31:0] Data;

    InstructionMemory uut (
        .Address(Address),
        .sel(sel),
        .Data(Data)
    );

    initial begin
        // ROM 선택: rom0
        sel = 0;
        Address = 9'h000; #10;
        print_output("rom0[000]");

        Address = 9'h004; #10;
        print_output("rom0[004]");

        // ROM 선택: rom1
        sel = 1;
        Address = 9'h000; #10;
        print_output("rom1[000]");

        Address = 9'h004; #10;
        print_output("rom1[004]");

        // 테스트 종료 없이 대기
    end

    task print_output(input [31*8:1] label);
        $display("[%s] Address=%h | sel=%b | Data=%h", label, Address, sel, Data);
    endtask

endmodule
