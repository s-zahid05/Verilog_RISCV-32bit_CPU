module ALU (
    input [31:0] A, B,
    input [3:0] ALUsel,
    output [31:0] D,
    output wire Zero, Carry, Overflow
);

    wire [31:0] add_result, logic_result, shift_result, cmp_result;
    wire add_carry, add_overflow, cmp_zero, cmp_lt;

    // Instantiate the Adder/Subtractor module
    Add_Sub a_s (
        .A(A),
        .B(B),
        .ALUsel(ALUsel[0]),
        .Result(add_result),
        .Carry(add_carry),
        .Overflow(add_overflow)
    );

    // Instantiate the Logic Unit
    Logic_Unit logic_u (
        .A(A),
        .B(B),
        .ALUsel(ALUsel[1:0]),
        .Result(logic_result)
    );

    // Instantiate the Shifter
    Shifter shift_u (
        .A(A),
        .B(B[4:0]),
        .ALUsel(ALUsel[1:0]),
        .Result(shift_result)
    );

    // Instantiate the Comparator
    Comparator cmp_u (
        .A(A),
        .B(B),
        .ALUsel(ALUsel[0]),
        .lt(cmp_result),
        .zero(cmp_zero)
    );

    // MUX to select the final result
    Mux_4to1 result_mux (
        .a(add_result),
        .b(logic_result),
        .c(shift_result),
        .d(cmp_result),
        .sel(ALUsel[3:2]),
        .out(D)
    );

    // Output signals
    assign Zero = (D == 32'd0);
    assign Carry = add_carry;
    assign Overflow = add_overflow;

endmodule
