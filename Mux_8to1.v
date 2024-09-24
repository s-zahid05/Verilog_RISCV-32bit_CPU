module Mux_8to1 (
    input [31:0] a, b, c, d, e, f, g, h,
    input [1:0] sel,
    output reg [31:0] out
);

    always @(*) begin
        case (sel)
            2'b000: out = a;
            2'b001: out = b;
            2'b010: out = c;
            2'b011: out = d;
            2'b100: out = e;
            2'b101: out = f;
            2'b110: out = g;
            2'b111: out = h;
            default: out = 32'd0;
        endcase
    end

endmodule