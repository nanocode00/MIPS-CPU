module wave_test;
    reg clk = 0;
    reg rst = 0;
    reg [3:0] counter = 0;

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (rst) counter <= 0;
        else     counter <= counter + 1;
    end

    initial begin
        $dumpfile("wave_test.vcd");    // VCD 파일 이름
        $dumpvars(0, wave_test);  // 모듈 전체 신호 덤프
        #100;
        $finish;
    end
endmodule
