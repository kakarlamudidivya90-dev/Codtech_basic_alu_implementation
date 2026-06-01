// ============================================================================
// COMPANY NAME: CODTECH IT SOLUTIONS 
// INTERN NAME:  kakarlamudi Divya 
// INTERN ID:    CITS908
// DOMAIN:       Digital VLSI Design / RTL Verification
// TASK TITLE:   Testbench for Basic 4-bit ALU
// ============================================================================

 `timescale 1ns / 1ps

module tb_alu_4bit;

    // Inputs to the Device Under Test (DUT)
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] alu_control;

    // Outputs from the Device Under Test (DUT)
    wire [3:0] alu_result;
    wire       carry_out;
    wire       zero_flag;

    // Instantiate the 4-bit ALU module
    alu_4bit uut (
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .carry_out(carry_out),
        .zero_flag(zero_flag)
    );

    // Stimulus block
  initial begin $dumpfile("dump.vcd"); $dumpvars(0, tb_alu_4bit); a=4'b0000; b=4'b0000; alu_control=3'b000; 
        // Initialize inputs
        a = 4'b0000;
        b = 4'b0000;
        alu_control = 3'b000;
        
        // Monitor window for console logging
        $monitor("Time=%0dns | Control=%b | A=%b B=%b | Result=%b | Carry=%b | Zero=%b", 
                 $time, alu_control, a, b, alu_result, carry_out, zero_flag);
        
        #10;
        
        // Test Case 1: Addition (4 + 5 = 9)
        a = 4'b0100; b = 4'b0101; alu_control = 3'b000; #10;
        
        // Test Case 2: Addition with Carry (12 + 6 = 18 -> Result 2, Carry 1)
        a = 4'b1100; b = 4'b0110; alu_control = 3'b000; #10;
        
        // Test Case 3: Subtraction (10 - 4 = 6)
        a = 4'b1010; b = 4'b0100; alu_control = 3'b001; #10;
        
        // Test Case 4: Bitwise AND
        a = 4'b1100; b = 4'b1010; alu_control = 3'b010; #10;
        
        // Test Case 5: Bitwise OR
        a = 4'b1100; b = 4'b1010; alu_control = 3'b011; #10;
        
        // Test Case 6: Bitwise XOR (Should trigger zero flag if identical)
        a = 4'b1111; b = 4'b1111; alu_control = 3'b100; #10;
        
        // Test Case 7: Left Shift A
        a = 4'b0011; alu_control = 3'b110; #10;

        // End simulation
        $finish;
    end

endmodule
