module Shifter (
    input [31:0] A,
    input [4:0] B,
    input [1:0] ALUsel,     // 00: left shift, 01: logical right shift, 10: arithmetic right shift
    output [31:0] Result
);

    assign Result = (ALUsel == 2'b01) ? (A << B) :
                    (ALUsel == 2'b10) ? (A >> B) :
                    (ALUsel == 2'b11) ? ($signed(A) >>> B) : 32'd0;

endmodule
