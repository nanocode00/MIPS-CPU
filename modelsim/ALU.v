module ALU (
    input [31:0] X,
    input [31:0] Y,
    input [3:0] S,
    output [31:0] Result1,
    output [31:0] Result2,
    output CF,
    output OF,
    output Equal
);

    //SLL Shifter
    wire [31:0] shifter_result_sll;
    Shifter shifter_sll (X, Y[4:0], 2'b00, shifter_result_sll);
    
    //SRA Shifter
    wire [31:0] shifter_result_sra;
    Shifter shifter_sra (X, Y[4:0], 2'b01, shifter_result_sra);
    
    //SRL Shifter
    wire [31:0] shifter_result_srl;
    Shifter shifter_srl (X, Y[4:0], 2'b10, shifter_result_srl);

    //Multiplier
    wire [31:0] multiplier_result, multiplier_hi;
    Multiplier multiplier (X, Y, , multiplier_result, multiplier_hi);

    //Divider
    wire [31:0] divider_result, divider_rem;
    Divider divider (X, Y, , divider_result, divider_rem);

    //Adder with Overflow Detection
    wire [31:0] adder_result;
    wire adder_CF, adder_OF;
    Adder adder (X, Y, , adder_result, adder_CF, adder_OF);

    //Subtractor with Overflow Detection
    wire [31:0] subtractor_result;
    wire subtractor_CF, subtractor_OF;
    Subtractor subtractor (X, Y, , subtractor_result, subtractor_CF, subtractor_OF);

    //Logic Operations
    wire [31:0] and_result = X & Y;
    wire [31:0] or_result  = X | Y;
    wire [31:0] xor_result = X ^ Y;
    wire [31:0] nor_result  = ~(X | Y);

    //Signed Comparator
    wire [31:0] comparator_signed_result;
    wire lt_signed;
    Comparator_Signed comparator_signed (X, Y, , , lt_signed);
    Bit_Extender bit_extender_signed (lt_signed, comparator_signed_result);

    //Unsigned Comparator
    wire [31:0] comparator_unsigned_result;
    wire lt_unsigned;
    Comparator_Unsigned comparator_unsigned (X, Y, , Equal, lt_unsigned);
    Bit_Extender bit_extender_unsigned (lt_unsigned, comparator_unsigned_result);

    always @(*) begin
        case (S)
            4'b0000: Result1 = shifter_result_sll;
            4'b0001: Result1 = shifter_result_sra;
            4'b0010: Result1 = shifter_result_srl;
            4'b0011: Result1 = multiplier_result;
            4'b0100: Result1 = divider_result;
            4'b0101: Result1 = adder_result;
            4'b0110: Result1 = subtractor_result;
            4'b0111: Result1 = and_result;
            4'b1000: Result1 = or_result;
            4'b1001: Result1 = xor_result;
            4'b1010: Result1 = nor_result;
            4'b1011: Result1 = comparator_signed_result;
            4'b1100: Result1 = comparator_unsigned_result;
            default: Result1 = 32'h00000000;
        endcase
    end

    always @(*) begin
        case (S)
            4'b0011: Result2 = multiplier_hi;
            4'b0100: Result2 = divider_rem;
            default: Result2 = 32'h00000000;
        endcase
    end

    always @(*) begin
        case (S)
            4'b0101: CF = adder_CF;
            4'b0110: CF = subtractor_CF;
            default: CF = 1'b0;
        endcase
    end

    always @(*) begin
        case (S)
            4'b0101: OF = adder_OF;
            4'b0110: OF = subtractor_OF;
            default: OF = 1'b0;
        endcase
    end

endmodule

module Shifter (
    input [31:0] in,        // rt
    input [4:0] shamt,      // shamt field
    input [1:0] ctrl,       // 00: SLL, 01: SRA, 10: SRL
    output reg [31:0] out
);

    always @(*) begin
        case (ctrl)
            2'b00: out = in << shamt;                      // SLL
            2'b01: out = $signed(in) >>> shamt;            // SRA
            2'b10: out = in >> shamt;                      // SRL
            default: out = 32'bx;                          // undefined
        endcase
    end

endmodule

module Multiplier (
    input [31:0] X,
    input [31:0] Y,
    input cin,
    output [31:0] result, //lower 32 bits
    output [31:0] hi      //upper 32 bits
);

    assign {hi, result} = X * Y;

endmodule

module Divider (
    input [31:0] X,
    input [31:0] Y,
    input upper,
    output [31:0] result, //quotient
    output [31:0] rem     //remainder
);

    assign result = (Y != 0) ? X / Y : 32'hFFFFFFFF;
    assign rem = (Y != 0) ? X % Y : 32'hDEAD_BEEF;

endmodule

module Comparator_Signed (
    input signed [31:0] X,
    input signed [31:0] Y,
    output gt,
    output eq,
    output lt
);

    assign eq = X == Y;
    assign gt = X > Y;
    assign lt = X < Y;

endmodule

module Comparator_Unsigned (
    input [31:0] X,
    input [31:0] Y,
    output gt,
    output eq,
    output lt
);

    assign gt = X > Y;
    assign eq = X == Y;
    assign lt = X < Y;

endmodule

module Bit_Extender (
    input  in,
    output [31:0] out
);

    assign out = {31'b0, in};

endmodule