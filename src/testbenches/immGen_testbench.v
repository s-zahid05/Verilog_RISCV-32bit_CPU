module immGen_tb;

    // Inputs to the immGen module
    reg [31:0] ins;  // Instruction input
    reg [2:0] sel;   // Selector input for immediate type

    // Output from the immGen module
    wire [31:0] imm31_0;

    // Clock signal
    reg clk;

    // Instantiate the immGen module
    immGen uut (
        .ins(ins),
        .sel(sel),
        .imm31_0(imm31_0)
    );

    // Clock generation: toggle clock every 5 time units
    initial begin
        clk = 0; // Initialize the clock
        forever #5 clk = ~clk; // Toggle the clock every 5 time units
    end

    // Test instruction set (you can modify these as per your needs)
    reg [31:0] instruction_memory [0:7];
    integer i;

    initial begin
        // Load instructions into memory (you can replace these with actual RISC-V instructions)
        instruction_memory[0] = 32'h00000013; // NOP (ADDI x0, x0, 0)
        instruction_memory[1] = 32'h00400113; // ADDI x2, x0, 4
        instruction_memory[2] = 32'h00800193; // ADDI x3, x0, 8
        instruction_memory[3] = 32'h00C00213; // ADDI x4, x0, 12
        instruction_memory[4] = 32'h01000293; // ADDI x5, x0, 16
        instruction_memory[5] = 32'h01400313; // ADDI x6, x0, 20
        instruction_memory[6] = 32'h01800393; // ADDI x7, x0, 24
        instruction_memory[7] = 32'h01C00413; // ADDI x8, x0, 28

        // Start feeding instructions on each clock cycle
        for (i = 0; i < 8; i = i + 1) begin
            // Set instruction and sel value
            ins = instruction_memory[i];
            sel = 3'b000; // Change the selector based on immediate type (I-type, S-type, etc.)

            // Wait for one clock cycle
            @(posedge clk);
        end

        // End simulation after all instructions are processed
        #10 $finish;
    end

    // Monitor the output
    initial begin
        $monitor("At time %t, ins = %h, sel = %b, imm31_0 = %h", $time, ins, sel, imm31_0);
    end

endmodule
