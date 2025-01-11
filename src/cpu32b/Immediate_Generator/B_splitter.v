module B_splitter (
    input [31:0] A,
    output reg [6:0] imm10_5,  // immediate bits [10:5]
    output reg [4:0] imm4_1,   // immediate bits [4:1]
    output reg imm11,           // immediate bit [11]
    output reg imm12            // immediate bit [12]
);

    always @(*) begin
        imm12 = A[31];           // imm[12]
        imm11 = A[7];            // imm[11]
        imm10_5 = A[30:25];      // imm[10:5]
        imm4_1 = A[11:8];        // imm[4:1]

//        // Debugging print statements
//        $display("B_splitter: A = %h, imm12 = %b, imm11 = %b, imm10_5 = %b, imm4_1 = %b", A, imm12, imm11, imm10_5, imm4_1);
    end

endmodule

