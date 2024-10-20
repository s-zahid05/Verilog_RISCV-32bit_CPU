`timescale 1ns / 1ps

module ControlUnit_tb;

    // Inputs for Control Unit
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [6:0] funct7;
    reg [4:0] rs1, rs2, rd;

    // Outputs from Control Unit
    wire branch, MemRead, MemtoReg, MemWrite, ALUsrc, RegWrite;
    wire [3:0] ALUop;

    // Inputs for ALU
    reg [31:0] A, B;

    // Outputs from ALU
    wire [31:0] D;
    wire Zero, Carry, Overflow;
    
    reg [31:0] ins;
    wire [1:0] immsel;
    wire [31:0] imm_out;
    wire [31:0] bsel; // Add this declaration


    // Instantiate the ControlUnit module
    ControlUnit cu (
        .opcode(opcode),
        .branch(branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .ALUsrc(ALUsrc),
        .RegWrite(RegWrite),
        .ALUop(ALUop),
        .funct3(funct3),
        .funct7(funct7),
        .rs1(rs1),
        .rs2(rs2),
        .immsel(immsel)
    );
    
    immGen immgen (
        .ins(ins),
        .sel(immsel),
        .imm31_0(imm_out)   
    );
    
    Mux_2to1 m2_1 (
        .in0(B),
        .in1(imm_out),
        .sel(ALUsrc),
        .out(bsel)
    );
    
    // Instantiate the ALU module
    ALU alu (
        .A(A),
        .B(bsel),
        .ALUsel(ALUop),
        .D(D),
        .Zero(Zero),
        .Carry(Carry),
        .Overflow(Overflow)
    );
    
    

    // Test sequence
    initial begin
    // Initialize inputs for Control Unit and ALU
        opcode = 7'b0000000;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        rs1 = 5'b00000;
        rs2 = 5'b00000;
        rd = 5'b00000;
        A = 32'd0;
        B = 32'd0;
        ins = {funct7, rs2, rs1, funct3, rd, opcode};

        // Wait for global reset
        #10;

        // Test R-type ADD (opcode: 0110011, funct3: 000, funct7: 0000000)
        opcode = 7'b0110011;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        A = 32'd10;
        B = 32'd20;
        #10;
        $display("Before MUX - B: %h, imm_out: %h, ALUsrc: %b", B, imm_out, ALUsrc);
        $display("imm_out after ins = %h: %h", ins, imm_out);
        #10; // Allow time for signals to propagate
        $display("MUX output (bsel): %h", bsel);

        $display("ADD: ALUop = %b, D = %d, Zero = %b, Carry = %b, Overflow = %b, ALUsrc = %b", ALUop, D, Zero, Carry, Overflow, ALUsrc);
        
        // Test R-type SUB (opcode: 0110011, funct3: 000, funct7: 0100000)
        funct7 = 7'b0100000;
        A = 32'd30;
        B = 32'd15;
        #10;
        $display("SUB: ALUop = %b, D = %d, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);
        
        // Test XOR (opcode: 0110011, funct3: 100, funct7: 0000000)
        funct3 = 3'b100;
        funct7 = 7'b0000000;
        A = 32'hFF00FF00;
        B = 32'h00FF00FF;
        #10;
        $display("XOR: ALUop = %b, D = %h, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);

        // Test OR (opcode: 0110011, funct3: 110, funct7: 0000000)
        funct3 = 3'b110;
        funct7 = 7'b0000000;
        A = 32'h0F0F0F0F;
        B = 32'hF0F0F0F0;
        #10;
        $display("OR: ALUop = %b, D = %h, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);

        // Test AND (opcode: 0110011, funct3: 111, funct7: 0000000)
        funct3 = 3'b111;
        funct7 = 7'b0000000;
        A = 32'hFFFFFFFF;
        B = 32'h0F0F0F0F;
        #10;
        $display("AND: ALUop = %b, D = %h, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);
        
        // Test SLL (opcode: 0110011, funct3: 001, funct7: 0000000)
        funct3 = 3'b001;
        funct7 = 7'b0000000;
        A = 32'h00000001;
        B = 32'd4;
        #10;
        $display("SLL: ALUop = %b, D = %h, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);

        // Test SRL (opcode: 0110011, funct3: 101, funct7: 0000000)
        funct3 = 3'b101;
        funct7 = 7'b0000000;
        A = 32'h000000F0;
        B = 32'd4;
        #10;
        $display("SRL: ALUop = %b, D = %h, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);

        // Test SRA (opcode: 0110011, funct3: 101, funct7: 0100000)
        funct3 = 3'b101;
        funct7 = 7'b0100000;
        A = 32'hF0000000;
        B = 32'd4;
        #10;
        $display("SRA: ALUop = %b, D = %h, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);

        // Test SLT (opcode: 0110011, funct3: 010, funct7: 0000000)
        funct3 = 3'b010;
        funct7 = 7'b0000000;
        A = 32'd10;
        B = 32'd20;
        #10;
        $display("SLT: ALUop = %b, D = %d, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);
        
        // Test SLTU (opcode: 0110011, funct3: 011, funct7: 0000000)
        funct3 = 3'b011;
        funct7 = 7'b0000000;
        A = 32'd10;
        B = 32'd5;
        #10;
        $display("SLTU: ALUop = %b, D = %d, Zero = %b, Carry = %b, Overflow = %b", ALUop, D, Zero, Carry, Overflow);
        // Initialize inputs for Control Unit
        opcode = 7'b0000000;
        funct3 = 3'b000;
        funct7 = 7'b0000000;
        rs1 = 5'b00000;
        rs2 = 5'b00000;

        // Initialize inputs for ALU
        A = 32'd0;
        B = 32'd0;

        // Wait for global reset
        #10;

        // Test immediate generation for ADDI (opcode: 0010011, funct3: 000)
        opcode = 7'b0010011; funct3 = 3'b000; rs1 = 5'b00000; rd = 5'b00001;
        ins = 32'h06400093;
        A = 32'd12; // ADDI x1, x0, 1
        #10;
        $display("ADDI: imm_out = %h", imm_out); // Should output 0x00000001

        ins = 32'b11111111111100000000000010010011;
        A = 32'd16; // ADDI x1, x0, -1 (0xFFF)
        #10;
        $display("ADDI: imm_out = %h", imm_out); // Should output 0xFFFFFFF

        ins = 32'b00000000001100000000000010010011;
        A = 32'd12; // ADDI x1, x0, 3
        #10;
        $display("ADDI: imm_out = %h", imm_out); // Should output 0x00000003


        // Test immediate generation for SLTI (opcode: 0010011, funct3: 010)
        funct3 = 3'b010; // SLTI
        ins = 32'b00000000000100000000000010101111;
        A = 32'd14; // SLTI x1, x0, 1
        #10;
        $display("SLTI: imm_out = %h", imm_out); // Should output 0x00000001

        ins = 32'b11111111111100000000000010101111;
        A = 32'd14; // SLTI x1, x0, -1
        #10;
        $display("SLTI: imm_out = %h", imm_out); // Should output 0xFFFFFFF

        // Test immediate generation for SLTIU (opcode: 0010011, funct3: 011)
        funct3 = 3'b011; // SLTIU
        ins = 32'b00000000000100000000000011001111;
        A = 32'd15; // SLTIU x1, x0, 1
        #10;
        $display("SLTIU: imm_out = %h", imm_out); // Should output 0x00000001

        ins = 32'b11111111111100000000000011001111; 
        A = 32'd19;// SLTIU x1, x0, -1
        #10;
        $display("SLTIU: imm_out = %h", imm_out); // Should output 0xFFFFFFFF


        // Test immediate generation for XORI (opcode: 0010011, funct3: 100)
        funct3 = 3'b100;
        A = 32'd32; // XORI
        ins = 32'b00000000001100000000000011100111; // XORI x1, x0, 3
        #10;
        $display("XORI: imm_out = %h", imm_out); // Should output 0x00000003

        // Test immediate generation for ORI (opcode: 0010011, funct3: 110)
        funct3 = 3'b110;
        A = 32'd78; // ORI
        ins = 32'b00000000010000000000000011000111; // ORI x1, x0, 4
        #10;
        $display("ORI: imm_out = %h", imm_out); // Should output 0x00000004

        // Test immediate generation for ANDI (opcode: 0010011, funct3: 111)
        funct3 = 3'b111;
        A = 32'd14; // ANDI
        ins = 32'b00000000001000000000000010100111; // ANDI x1, x0, 2
        #10;
        $display("ANDI: imm_out = %h", imm_out); // Should output 0x00000002

        // Test immediate generation for SLLI (opcode: 0010011, funct3: 001, funct7: 0000000)
        funct3 = 3'b001; funct7 = 7'b0000000; // SLLI
        A = 32'd25;
        ins = 32'b00000000001100000000000000100101; // SLLI x1, x0, 3
        #10;
        $display("SLLI: imm_out = %h", imm_out); // Should output 0x00000003

        // Test completed, finish simulation
        $finish;
    end

endmodule
