`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2024 09:09:46 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input [31:0] inPC,
    output reg [31:0] outPC,    // Changed to reg
    input clk,
    input reset,
    output reg [31:0] outPC4    // Changed to reg
);

    always @(posedge clk) 
    begin
        if (reset) begin
            outPC <= 32'h00000000;
            outPC4 <= 32'h00000000;
        end else begin
            outPC <= inPC;
            outPC4 <= inPC + 32'h00000004;
        end
    end

endmodule

