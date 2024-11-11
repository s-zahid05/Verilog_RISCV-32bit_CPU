`timescale 1ns / 1ps

module RiscV_Top_tb;

    reg clk;
  reg reset;
  
  // Instantiate the CPU
  // Internal signals
    wire [31:0] PCp4, outPC;             // Program Counter related signals
    wire [31:0] instruction;             // Instruction memory output
    wire [31:0] alu_result, mem_data;    // ALU and memory data
    wire [31:0] read_data1, read_data2;  // Read data from register file
    wire [31:0] imm_out, bsel, asel;           // Immediate output and ALU B input
    wire [31:0] ResultMux;
    wire [2:0] immsel;
    wire [3:0] ALUop;                    // ALU control signal
    wire branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite, ResultSrc; // Control signals
    wire zero, carry, overflow, PCSrc;   // ALU status signals
    wire brEq, brLt;                     // Branch signals from brancher
    wire brUn; 
    
    // PC-related signals
    wire [31:0] pc_in, pc_out;
    
    // Signals from instruction fields
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    wire [4:0] rd = instruction[11:7];

    // Instantiate PC (Program Counter)
    PC program_counter (
        .clk(clk),
        .reset(reset),
        .inPC(pc_in),
        .outPC(outPC)
    );
    
    // Next PC logic (branching)
    assign PCp4 = outPC + 4;
    assign PCSrc = branch & (funct3 == 3'b000 ? brEq : (funct3 == 3'b001 ? ~brEq : brLt)); // Branch condition
    assign pc_in = PCSrc ? (outPC + imm_out) : PCp4;

    // Instruction memory (Fetch stage)
    INS_MEM ins_mem_inst (
        .reset(reset),
        .read_address(outPC),   // Read instruction based on PC output
        .instruction_out(instruction)
    );
    
    // Register file
    RegFile reg_file (
        .clk(clk),
        .Rs1(rs1),
        .Rs2(rs2),
        .Rd(rd),
        .RegW(RegWrite),
        .Wd(ResultMux),  // Data to write back into the register
        .rd1(read_data1),
        .rd2(read_data2)
    );
    
    // Immediate generation
    immGen immgen (
        .ins(instruction),
        .sel(immsel),
        .imm31_0(imm_out)
    );
    
    // ALU Source MUX
    Mux_2to1 m2_1 (
        .in0(read_data2),
        .in1(imm_out),
        .sel(ALUsrc),
        .out(bsel)
    );
    
    // ALU
    ALU alu (
        .A(read_data1),
        .B(bsel),
        .ALUsel(ALUop),
        .D(alu_result),
        .Zero(zero),
        .Carry(carry),
        .Overflow(overflow)
    );

    // Data memory (load/store)
    DMEM dmem (
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Address(alu_result),
        .writeData(read_data2),
        .readData(mem_data)
    );
    
    // Brancher
    brancher brancher_inst (
        .dataA(read_data1),
        .dataB(read_data2),
        .brUn(brUn),     // Unsigned mode from control unit
        .brEq(brEq),     // Output for equality comparison
        .brLt(brLt)      // Output for less-than comparison
    );
    
    Mux_2to1 ResMux (
        .in0(alu_result),
        .in1(mem_data),
        .sel(MemtoReg),
        .out(ResultMux)  // Connect to data written to register file
    );
    
    // Control unit
    ControlUnit cu (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .branch(branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUsrc(ALUsrc),
        .RegWrite(RegWrite),
        .ALUop(ALUop),
        .immsel(immsel),
        .ResultSrc(ResultSrc),
        .brEq(brEq),    // Connect brEq output from brancher
        .brLt(brLt)     // Connect brLt output from brancher
    );


  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 ns clock period
  end

  // Stimulus
  initial begin
    // Initialize
    reset = 1;
    #10;
    reset = 0;
    
    // Monitor signals
    $monitor("Time: %0d, PC: %h, Instruction: %h, ALU Result: %h, Imm: %h, Memory Data: %h, x5: %h, x6: %h, x7: %h, rs1: %h, rs2: %h, rd: %h",
             $time, outPC, instruction, alu_result, imm_out, mem_data, reg_file.Registers[5], reg_file.Registers[6], reg_file.Registers[7], rs1, rs2, rd);
                      
    
    // Run the simulation for some time
    #200;
    
    $finish;
  end

endmodule