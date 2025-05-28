module InstructionMemory (
    input [8:0] Address,
    input sel,
    output [31:0] Data
);

    reg [31:0] rom0 [0:511]; // 0 ~ 1FF
    reg [31:0] rom1 [0:511]; // 0 ~ 1FF

    initial begin
        $readmemh("benchmark.hex", rom0);
        $readmemh("exception_service.hex", rom1);
    end

    assign Data = sel ? rom1[Address] : rom0[Address];

endmodule
