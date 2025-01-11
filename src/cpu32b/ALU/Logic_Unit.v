module Logic_Unit (
    input [31:0] A, B,
    input [1:0] ALUsel,     // 00: AND, 01: OR, 10: XOR
    output [31:0] Result
);

    assign Result = (ALUsel == 2'b00) ? (A & B) :
                    (ALUsel == 2'b01) ? (A | B) :
                    (ALUsel == 2'b10) ? (A ^ B) : 32'd0;

endmodule
