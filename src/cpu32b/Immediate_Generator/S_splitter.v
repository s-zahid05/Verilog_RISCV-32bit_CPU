module S_splitter (
    input [31:0] A,
    output [6:0] opcode,
    output [4:0] imm4_0,
    output [2:0] funct3,
    output [4:0] rs1,
    output [4:0] rs2,
    output [6:0] imm11_5
);

assign opcodes = A[6:0];
assign imm4_0 = A[11:7];
assign funct3 = A[14:12];
assign rs1 = A[19:15];
assign rs2 = A[24:20];
assign imm11_5 = A[31:25];


endmodule