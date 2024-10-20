`timescale 1ns / 1ps

module PC_INS_MEM_tb;

    // Inputs for PC and INS_MEM
    reg clk;
    reg reset;

    // Outputs for PC
    wire [31:0] outPC;   // Program Counter (PC) output
    wire [31:0] instruction, imm_out;  // Instruction fetched from instruction memory

    // Instantiate PC (Program Counter)
    PC pc_inst (
        .clk(clk),
        .reset(reset),
        .inPC(pc_in),
        .outPC(outPC)
    );

    // Instantiate Instruction Memory (INS_MEM)
    INS_MEM ins_mem_inst (
        .reset(reset),
        .read_address(outPC),   // Read instruction based on PC output
        .instruction_out(instruction)
    );
    
    immGen immgen (
        .ins(instruction),
        .sel(immsel),
        .imm31_0(imm_out)
    );

    // Internal signal for next PC value (PC increment logic)
    wire [31:0] pc_in;
    assign pc_in = outPC + 4;  // Increment PC by 4 for each instruction fetch

    // Testbench clock generation
    always #5 clk = ~clk;  // Clock signal with 10ns period (5ns high, 5ns low)

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        
        // Wait for some time and then deassert reset
        #10 reset = 0;

        // Monitor the key signals
        $monitor("Time: %0d, PC: %h, Instruction: %h", $time, outPC, instruction);

        // Run simulation for some time
        #100;
        
        // Finish the simulation
        $finish;
    end

endmodule
