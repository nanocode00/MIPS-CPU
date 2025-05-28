`timescale 1ns/1ps

module tb_RegisterFile;

    reg clk;
    reg WE;
    reg [4:0] reg1_number, reg2_number, write_reg_number;
    reg [31:0] write_data;
    wire [31:0] reg1, reg2, a0, v0;

    RegisterFile uut (
        .reg1_number(reg1_number),
        .reg2_number(reg2_number),
        .write_reg_number(write_reg_number),
        .write_data(write_data),
        .WE(WE),
        .clk(clk),
        .reg1(reg1),
        .reg2(reg2),
        .a0(a0),
        .v0(v0)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // 초기화
        WE = 0;
        reg1_number = 0;
        reg2_number = 0;
        write_reg_number = 0;
        write_data = 0;
        #10;

        // Write to register 4 (a0)
        WE = 1; write_reg_number = 5'd4; write_data = 32'hAAAA_BBBB; #10;

        // Write to register 2 (v0)
        WE = 1; write_reg_number = 5'd2; write_data = 32'h1234_5678; #10;

        // Read from registers
        WE = 0;
        reg1_number = 5'd4;
        reg2_number = 5'd2;
        #10;

        print_outputs;
    end

    task print_outputs;
        begin
            $display("Time=%0t | reg1=%h | reg2=%h | a0=%h | v0=%h",
                     $time, reg1, reg2, a0, v0);
        end
    endtask

endmodule
