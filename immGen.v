module immGen (
    input [31:0] ins,
    input [2:0] sel,
    output [31:0] imm31_0
);

    wire [31:0] I_out, S_out, B_out, U_out, J_out;
    wire [11:0] B_combine, S_combine, imm11_0;
    wire [19:0] imm31_12;
    wire [6:0] imm11_5;
    wire [4:0] imm4_0, imm4_1;
    wire [5:0] imm10_5;
    wire [9:0] imm10_1;
    wire [7:0] imm19_12;
    wire imm11, imm12, imm11J, imm20;

    // I Splitter logic
    I_splitter i_split (
        .A(ins),
        .imm11_0(imm11_0)
    );

    sign_extend #(.IN_WIDTH(12)) i_extend (
        .in(imm11_0),
        .out(I_out)
    );

    // S Splitter logic
    S_splitter s_split (      
        .A(ins),
        .imm4_0(imm4_0),
        .imm11_5(imm11_5)
    );

    assign S_combine = {imm11_5, imm4_0};

    sign_extend #(.IN_WIDTH(12)) s_extend (
        .in(S_combine),
        .out(S_out)
    );

    // B Splitter logic
    B_splitter b_split (
        .A(ins),
        .imm11(imm11),
        .imm12(imm12),
        .imm4_1(imm4_1),
        .imm10_5(imm10_5)
    );

    assign B_combine = {imm12, imm11, imm10_5, imm4_1, 1'b0};  // Fixed semicolon

    sign_extend #(.IN_WIDTH(13)) B_extend (
        .in(B_combine),
        .out(B_out)
    );

    // U Splitter logic
    U_splitter u_split (
        .A(ins),
        .imm31_12(imm31_12)
    );

    assign U_combine = {imm31_12, 12'b0};  // Fixed semicolon

    // J Splitter logic
    J_splitter j_split (
        .A(ins),
        .imm11(imm11J),
        .imm20(imm20),
        .imm10_1(imm10_1),
        .imm19_12(imm19_12)
    );

    assign J_combine = {imm20, imm19_12, imm10_1, imm11J, 1'b0};

    sign_extend #(.IN_WIDTH(21)) j_extend (
        .in(J_combine),
        .out(J_out)
    );

    // Multiplexer for selecting the immediate value based on the instruction type
    Mux_8to1 mux (
        .sel(sel),
        .a(I_out),
        .b(S_out),
        .c(B_out),
        .d(J_out),
        .e(U_out),
        .out(imm31_0)
    );

endmodule
