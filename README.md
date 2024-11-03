# Verilog_RISCV32bit_CPU
This project focuses on the implementation of a fully functioning single-cycle RISC-V, 32-bit CPU on an FPGA. The design encompasses several key components, including a register file, program counter (PC), data memory, instruction memory, arithmetic logic unit (ALU), immediate generator (imm_gen), and a control unit. Each of these components are connected to execute RISC-V instructions efficiently. Below you will find a table that includes all the instructions that have been implemented and tested so far; what remains are the load/store byte instructions and the branching instructions.

| Instructions | Opcode  | funct3 | funct7  | Type |
| ------------ | ------- | ------ | ------- | ---- |
| ADD          | 0110011 | 000    | 0000000 | R    |
| SUB          | 0110011 | 000    | 0100000 | R    |
| XOR          | 0110011 | 100    | 0000000 | R    |
| OR           | 0110011 | 110    | 0000000 | R    |
| AND          | 0110011 | 111    | 0000000 | R    |
| SLL          | 0110011 | 001    | 0000000 | R    |
| SRL          | 0110011 | 101    | 0000000 | R    |
| SRA          | 0110011 | 101    | 0100000 | R    |
| SLT          | 0110011 | 010    | 0000000 | R    |
| SLTU         | 0110011 | 011    | 0000000 | R    |
| ADDI         | 0010011 | 000    | 0000000 | I    |
| XORI         | 0010011 | 100    | 0000000 | I    |
| ORI          | 0010011 | 110    | 0000000 | I    |
| ANDI         | 0010011 | 111    | 0000000 | I    |
| SLLI         | 0010011 | 001    | 0000000 | I    |
| SRLI         | 0010011 | 101    | 0000000 | I    |
| SRAI         | 0010011 | 101    | 0100000 | I    |
| SLTI         | 0010011 | 010    | 0000000 | I    |
| SLTUI        | 0010011 | 011    | 0000000 | I    |
