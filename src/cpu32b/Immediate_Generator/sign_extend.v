module sign_extend #(
    parameter IN_WIDTH = 12 
)(
    input  wire [IN_WIDTH-1:0] in,  
    output wire [31:0] out          
);

    assign out = {{(32-IN_WIDTH){in[IN_WIDTH-1]}}, in};

endmodule
