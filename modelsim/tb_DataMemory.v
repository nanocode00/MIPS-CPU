`timescale 1ns/1ps

module tb_DataMemory;

    reg clk;
    reg Load;
    reg Store;
    reg [9:0] Address;
    reg [31:0] DataIn;
    wire [31:0] DataOut;

    DataMemory uut (
        .clk(clk),
        .Load(Load),
        .Store(Store),
        .Address(Address),
        .DataIn(DataIn),
        .DataOut(DataOut)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // 초기 상태
        Load = 0;
        Store = 0;
        Address = 10'd0;
        DataIn = 32'h00000000;
        #10;

        // 주소 10에 0xDEADBEEF 저장
        Store = 1;
        Address = 10'd10;
        DataIn = 32'hDEADBEEF;
        #10;
        Store = 0;

        // 주소 20에 0x12345678 저장
        Store = 1;
        Address = 10'd20;
        DataIn = 32'h12345678;
        #10;
        Store = 0;

        // 주소 10 읽기
        Load = 1;
        Address = 10'd10;
        #10;
        print_output("Read from address 10");

        // 주소 20 읽기
        Address = 10'd20;
        #10;
        print_output("Read from address 20");

        // Load 해제 (DataOut = 0 기대)
        Load = 0;
        #10;
        print_output("Load disabled");
    end

    task print_output(input [31*8:1] label);
        $display("[%s] Time=%0t | Address=%d | DataOut=%h", label, $time, Address, DataOut);
    endtask

endmodule
