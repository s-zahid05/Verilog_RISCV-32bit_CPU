module B_splitter (
    input [31:0] A,
    output [6:0] opcode,
    output [0:0] imm11,
    output [3:0] imm4_1,
    output [2:0] funct3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [5:0] imm10_5,
    output [0:0] imm12
  );

assign opcodes = A[6:0];
assign imm11 = A[7];
assign imm4_1 = A[11:8];
assign funct3 = A[14:12];
assign rs1 = A[19:15];
assign rs2 = A[24:20];
assign imm10_5 = A[30:25];
assign imm12 = A[31];


endmodule