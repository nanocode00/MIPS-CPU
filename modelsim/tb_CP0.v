`timescale 1ns/1ps

module tb_CP0;

    reg clk;
    reg enable;
    reg [2:0] ExpSrc;
    reg [31:0] Inst, PCin, Din;
    wire IsEret, HasExp, ExRegWrite, ExpBlock;
    wire [31:0] PCout, Dout;

    CP0 uut (
        .clk(clk),
        .enable(enable),
        .ExpSrc(ExpSrc),
        .Inst(Inst),
        .PCin(PCin),
        .Din(Din),
        .IsEret(IsEret),
        .HasExp(HasExp),
        .ExRegWrite(ExRegWrite),
        .ExpBlock(ExpBlock),
        .PCout(PCout),
        .Dout(Dout)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // 0. 초기화
        enable = 0;
        ExpSrc = 3'b000;
        Inst   = 32'h00000000;
        PCin   = 32'h00000000;
        Din    = 32'h00000000;
        #10;

        // 1. 예외 발생: syscall 시뮬레이션 (ExpSrc = 001)
        enable = 1;
        ExpSrc = 3'b001;
        Inst   = 32'h0000000C;   // syscall
        PCin   = 32'h00400020;
        #12; // clk=0일 때 통과되도록 (EPC 갱신 조건)

        print_state("예외 발생 → EPC 저장 시도");

        // 2. mfc0: EPC 레지스터 출력 (sel=0)
        ExpSrc = 3'b000;
        enable = 1;
        Inst   = 32'b010000_00000_00010_00000_00000_000000; // mfc0, sel=0
        #10;

        print_state("mfc0으로 EPC 읽기 → Dout 확인");

        // 3. eret 명령 수행 → IsEret = 1, PCout == EPC
        Inst = 32'h42000018; // eret
        #10;

        print_state("eret 수행 → PCout = EPC 기대");

        // 4. 아무 일도 없는 상황 (EPC 고정)
        enable = 0;
        Inst = 32'h00000000;
        ExpSrc = 3'b000;
        PCin = 32'hABCDABCD;
        #10;

        print_state("정상 상태 → EPC 유지 확인");
    end

    task print_state(input [80*8:1] label);
        $display("[%s] Time=%0t | HasExp=%b | IsEret=%b | PCin=%h | EPC/PCout=%h | Dout=%h",
                 label, $time, HasExp, IsEret, PCin, PCout, Dout);
    endtask

endmodule
