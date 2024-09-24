module reg_file (
    input wire clk,                    
    input wire we,                     
    input wire [4:0] rs1, rs2, rd,      
    input wire [31:0] write_data,      
    output wire [31:0] read_data1,    
    output wire [31:0] read_data2    
);

    reg [31:0] reg_array [31:0];


    assign read_data1 = reg_array[rs1];
    assign read_data2 = reg_array[rs2];


    always @(posedge clk) begin
        if (we && rd != 0) begin 
            reg_array[rd] <= write_data;
        end
    end

    initial begin
        reg_array[0] <= 32'b0;
    end
endmodule
