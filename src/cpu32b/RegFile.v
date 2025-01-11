`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2024 05:19:43 PM
// Design Name: 
// Module Name: RegFile
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module RegFile(
    input clk, reset, RegW,
    input [4:0] Rs1,  
    input [4:0] Rs2,  
    input [4:0] Rd,   
    input [31:0] Wd,
    output [31:0] rd1, rd2
    );

    reg [31:0] Registers [31:0];  // Declare the register array

    // Output the values from registers Rs1 and Rs2
    assign rd1 = Registers[Rs1];
    assign rd2 = Registers[Rs2];

    // Initialization in simulation (done once at the beginning of simulation)
    initial begin
        Registers[0] = 32'b0;  // Register 0 is hardwired to 0 in RISC-V
        Registers[1] = 32'b0;
        Registers[2] = 32'b0;
        Registers[3] = 32'b0;
        Registers[4] = 32'b0;
        Registers[5] = 32'b0;
        Registers[6] = 32'b0;
        Registers[7] = 32'b0;
        Registers[8] = 32'b0;
        Registers[9] = 32'b0;
        Registers[10] = 32'b0;
        Registers[11] = 32'b0;
        Registers[12] = 32'b0;
        Registers[13] = 32'b0;
        Registers[14] = 32'b0;
        Registers[15] = 32'b0;
        Registers[16] = 32'b0;
        Registers[17] = 32'b0;
        Registers[18] = 32'b0;
        Registers[19] = 32'b0;
        Registers[20] = 32'b0;
        Registers[21] = 32'b0;
        Registers[22] = 32'b0;
        Registers[23] = 32'b0;
        Registers[24] = 32'b0;
        Registers[25] = 32'b0;
        Registers[26] = 32'b0;
        Registers[27] = 32'b0;
        Registers[28] = 32'b0;
        Registers[29] = 32'b0;
        Registers[30] = 32'b0;
        Registers[31] = 32'b0;
    end

    // Write logic
    always @ (posedge clk) begin
        if (RegW == 1'b1 && Rd != 5'b00000) begin
            Registers[Rd] <= Wd;  // Write to register Rd with value Wd
        end
    end
endmodule




