module Mux_2to1 (
    input wire sel,              // Select signal
    input wire [31:0] in0,      // Input 0
    input wire [31:0] in1,      // Input 1
    output wire [31:0] out      // Output
);

    assign out = (sel) ? in1 : in0;

endmodule

