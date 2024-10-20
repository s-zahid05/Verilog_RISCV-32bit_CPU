module ALU_testbench;
    reg [31:0] A, B;
    reg [3:0] ALUsel;
    wire [31:0] D;
    wire Zero, Carry, Overflow;

    // Instantiate the ALU module
    ALU uut (
        .A(A), 
        .B(B), 
        .ALUsel(ALUsel), 
        .D(D), 
        .Zero(Zero), 
        .Carry(Carry), 
        .Overflow(Overflow)
    );

    // Initial block to apply stimulus
    initial begin
        // Initialize inputs
        A = 32'h6; 
        B = 32'h7;
        ALUsel = 4'b0000;  // Test Addition
    end
endmodule
