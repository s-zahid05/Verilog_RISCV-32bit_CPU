`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2024 05:46:41 PM
// Design Name: 
// Module Name: DMEM
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

module DMEM(
    input clk, 
    input reset, 
    input MemWrite, 
    input MemRead,
    input [31:0] Address, 
    input [31:0] writeData,
    output reg [31:0] readData  // Made readData a reg for explicit timing control
);
     
    reg [31:0] Dmemory [63:0];  
    wire [5:0] memAddress = Address[7:2];  // Using word address, extracted from Address[7:2]
    
    // Process memory reads/writes based on clock edge and control signals
    always @ (posedge clk) begin
        if (reset == 1'b1) begin
            for (integer i = 0; i < 64; i = i + 1) begin
                Dmemory[i] <= 32'h0;  // Reset memory contents to 0
            end
        end
        else if (MemWrite) begin
            // Write data on a positive clock edge if MemWrite is asserted
            Dmemory[memAddress] <= writeData;
        end
    end
    
    always @(*) begin
        if (MemRead) begin
            // Read data asynchronously when MemRead is asserted
            readData = Dmemory[memAddress];
        end else begin
            readData = 32'h0; // Default to 0 if MemRead is not active
        end
    end
endmodule

