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


module RegFile(
    input clk, reset, RegW,
    input [4:0] Rs1,  
    input [4:0] Rs2,  
    input [4:0] Rd,   
    input [31:0] Wd,
    output [31:0] rd1, rd2
    );

    reg [31:0] Registers [31:0];

    assign rd1 = Registers[Rs1];
    assign rd2 = Registers[Rs2];

    always @ (posedge clk) begin 
        if (reset == 1'b1) begin
            for (integer i = 0; i < 32; i = i + 1) begin
                Registers[i] <= 32'h0;
            end
        end
        else if (RegW == 1'b1 && Rd != 5'b00000) begin
            Registers[Rd] <= Wd;  
        end
    end
endmodule

