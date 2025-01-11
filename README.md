# Verilog_RISCV32bit_CPU
This project focuses on the implementation of a fully functioning single-cycle RISC-V, 32-bit CPU on an FPGA. The design encompasses several key components, including a register file, program counter (PC), data memory, instruction memory, arithmetic logic unit (ALU), immediate generator (imm_gen), and a control unit. Each of these components are connected to execute RISC-V instructions efficiently.

Below is an illustration of the overall CPU architecture:
![Scheme-it-export-RISC-V-Arch32-2024-11-03-19-36](https://github.com/user-attachments/assets/329b0414-3d94-4842-985f-eab31c1b9f58)
Note: This diagram provides a simplified view, excluding the control unit.

Future updates to the CPU will include the addition of pipelining, branch prediction, and a forwarding unit to support efficient data hazard management. While no specific timeline is set, these enhancements are intended to significantly improve performance by enabling concurrent instruction execution.

Below you will find a table that includes all the instructions that have been implemented for the single cycle processor.

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
| LUI          | 0110111 |        |         | U    |
| SW           | 0100011 |        |         | S    |
| LW           | 0000011 |        |         | I    |
| BLT          | 1100011 | 100    |         | B    |
| BGE          | 1100011 | 101    |         | B    |
| BEQ          | 1100011 | 000    |         | B    |
| BLTU         | 1100011 | 110    |         | B    |
| BGEU         | 1100011 | 111    |         | B    |
| BNE          | 1100011 | 001    |         | B    |


