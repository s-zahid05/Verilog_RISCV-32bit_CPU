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
    input clk, reset, MemWrite, MemRead,
    input [31:0] Address, writeData,
    output [31:0] readData
    );
     
    reg [31:0] Dmemory [63:0];  
    wire [5:0] memAddress = Address[7:2];  
    
    assign readData = (MemRead) ? Dmemory[memAddress] : 32'h0;
    
    always @ (posedge clk) begin
        if(reset == 1'b1) begin
            for(integer i = 0; i < 64; i = i + 1) begin
                Dmemory[i] <= 32'h0;  
            end
        end
        else if(MemWrite) begin
            Dmemory[memAddress] <= writeData;  
        end
    end
endmodule

