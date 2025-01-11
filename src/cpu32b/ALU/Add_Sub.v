module Add_Sub (
    input [31:0] A, B,
    input ALUsel,         // 0 for addition, 1 for subtraction
    output [31:0] Result,
    output Carry, Overflow
);

    wire [31:0] B_in;
    wire [32:0] sum;

    // Subtract if ALUsel is 1 (XOR B with ALUsel)
    assign B_in = B ^ {32{ALUsel}};
    assign sum = {1'b0, A} + {1'b0, B_in} + ALUsel;

    // Output the result and flags
    assign Result = sum[31:0];
    assign Carry = sum[32];
    assign Overflow = (A[31] == B_in[31] && Result[31] != A[31]);

endmodule