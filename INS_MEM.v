`timescale 1ns / 1ps

module INS_MEM #(parameter MEM_SIZE = 64) (
    input reset,
    input clk,
    input enable,
    input [31:0] read_address1,
    input [31:0] read_address2,
    output reg [31:0] instruction_out1,
    output reg [31:0] instruction_out2,
    input write_enable,
    input [31:0] write_data,
    input [31:0] write_address
);

    reg [31:0] Memory [MEM_SIZE-1:0];

    initial begin
        $readmemh("instructions.hex", Memory);
    end

    always @(posedge clk) begin
        if (reset) begin
            for (integer i = 0; i < MEM_SIZE; i = i + 1) begin
                Memory[i] <= 32'h00000000;
            end
        end else if (enable) begin
            if (read_address1 < MEM_SIZE) 
                instruction_out1 <= Memory[read_address1];
            else
                instruction_out1 <= 32'h00000000;
            
            if (read_address2 < MEM_SIZE) 
                instruction_out2 <= Memory[read_address2];
            else
                instruction_out2 <= 32'h00000000;
        end

        if (write_enable && write_address < MEM_SIZE) begin
            Memory[write_address] <= write_data;
        end
    end

endmodule
