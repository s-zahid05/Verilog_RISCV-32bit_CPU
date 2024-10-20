module J_splitter (
    input [31:0] A,
    output [6:0] opcode,
    output [4:0] rd, 
    output [7:0] imm19_12,
    output [0:0] imm11,
    output [9:0] imm10_1,
    output [9:0] imm20
);

assign opcodes = A[6:0];
assign rd = A[11:7];
assign imm19_12 = A[19:12];
assign imm11 = A[20];
assign imm10_1 = A[30:21];
assign imm20 = A[31];


endmodule