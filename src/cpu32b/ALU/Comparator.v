module Comparator (
    input [31:0] A, B,
    input ALUsel,            // 0 for unsigned comparison, 1 for signed comparison
    output [31:0] lt, zero
);

    assign lt = (ALUsel == 1'b0) ? (A < B) :
                ($signed(A) < $signed(B));

    assign zero = (A == B);

endmodule
