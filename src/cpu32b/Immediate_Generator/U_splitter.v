module U_splitter (
    input [31:0] A,
    output [6:0] opcode,
    output [4:0] rd,
    output [19:0] imm31_12 
);

assign opcodes = A[6:0];
assign rd = A[11:7];
assign imm31_12 = A[31:12];

endmodule