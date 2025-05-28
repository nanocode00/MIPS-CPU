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

    // Shifters
    wire [31:0] shifter_result_sll, shifter_result_sra, shifter_result_srl;
    Shifter shifter_sll (X, Y[4:0], 2'b00, shifter_result_sll);
    Shifter shifter_sra (X, Y[4:0], 2'b01, shifter_result_sra);
    Shifter shifter_srl (X, Y[4:0], 2'b10, shifter_result_srl);

    // Multiplier
    wire [31:0] multiplier_result, multiplier_hi;
    Multiplier multiplier (X, Y, 1'b0, multiplier_result, multiplier_hi);

    // Divider
    wire [31:0] divider_result, divider_rem;
    Divider divider (X, Y, 1'b0, divider_result, divider_rem);

    // Adder
    wire [31:0] adder_result;
    wire adder_CF, adder_OF;
    Adder adder (X, Y, 1'b0, adder_result, adder_CF, adder_OF);

    // Subtractor
    wire [31:0] subtractor_result;
    wire subtractor_CF, subtractor_OF;
    Subtractor subtractor (X, Y, 1'b0, subtractor_result, subtractor_CF, subtractor_OF);

    // Logics
    wire [31:0] and_result = X & Y;
    wire [31:0] or_result  = X | Y;
    wire [31:0] xor_result = X ^ Y;
    wire [31:0] nor_result  = ~(X | Y);

    // Comparators
    wire lt_signed, lt_unsigned;
    Comparator_Signed comparator_signed (X, Y, , , lt_signed);
    Comparator_Unsigned comparator_unsigned (X, Y, , Equal, lt_unsigned);

    // Result1 Multiplexer
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
            4'b1011: Result1 = {31'b0, lt_signed};
            4'b1100: Result1 = {31'b0, lt_unsigned};
            default: Result1 = 32'h00000000;
        endcase
    end

    // Result2 Multiplexer
    always @(*) begin
        case (S)
            4'b0011: Result2 = multiplier_hi;
            4'b0100: Result2 = divider_rem;
            default: Result2 = 32'h00000000;
        endcase
    end

    // CF/OF Multiplexer
    always @(*) begin
        case (S)
            4'b0101: {OF, CF} = {adder_OF, adder_CF};
            4'b0110: {OF, CF} = {subtractor_OF, subtractor_CF};
            default: {OF, CF} = 2'b00;
        endcase
    end

endmodule
