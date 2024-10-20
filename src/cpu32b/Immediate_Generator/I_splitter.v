module I_splitter (
    input [31:0] A,
    output [6:0] opcode,
    output [4:0] rd,
    output [2:0] funct3,
    output [4:0] rs1,
    output [11:0] imm11_0
);

assign opcodes = A[6:0];
assign rd = A[11:7];
assign funct3 = A[14:12];
assign rs1 = A[19:15];
assign imm11_0 = A[31:20];


endmodule