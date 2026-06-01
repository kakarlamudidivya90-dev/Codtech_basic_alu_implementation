// ============================================================================
// COMPANY NAME: CODTECH IT SOLUTIONS 
// INTERN NAME:  Kakarlamudi divya
// INTERN ID:    CITS998
// DOMAIN:       Digital VLSI Design / RTL Verification
// TASK TITLE:   Design and Implementation of a Basic 4-bit ALU
// ============================================================================ 

 `timescale 1ns / 1ps

module alu_4bit (
    input  wire [3:0] a,           // 4-bit input operand A
    input  wire [3:0] b,           // 4-bit input operand B
    input  wire [2:0] alu_control, // 3-bit control signal to select operation
    output reg  [3:0] alu_result,  // 4-bit output result of the operation
    output reg        carry_out,   // Carry out flag for addition
    output reg        zero_flag    // Zero flag set high if alu_result is 0
);

    // Combination logic block sensitive to any change in inputs
    always @(*) begin
        // Default values to prevent unwanted latches
        alu_result = 4'b0000;
        carry_out  = 1'b0;
        
        case (alu_control)
            3'b000: begin // Arithmetic Addition
                {carry_out, alu_result} = a + b;
            end
            
            3'b001: begin // Arithmetic Subtraction
                alu_result = a - b;
                carry_out  = (a < b) ? 1'b1 : 1'b0; // Borrow indicator
            end
            
            3'b010: begin // Bitwise AND
                alu_result = a & b;
            end
            
            3'b011: begin // Bitwise OR
                alu_result = a | b;
            end
            
            3'b100: begin // Bitwise XOR
                alu_result = a ^ b;
            end
            
            3'b101: begin // Bitwise NOR
                alu_result = ~(a | b);
            end
            
            3'b110: begin // Logical Left Shift
                alu_result = a << 1;
            end
            
            3'b111: begin // Logical Right Shift
                alu_result = a >> 1;
            end
            
            default: begin // Default fallback
                alu_result = 4'b0000;
                carry_out  = 1'b0;
            end
        endcase
        
        // Sequential evaluation for the Zero Flag
        if (alu_result == 4'b0000) begin
            zero_flag = 1'b1;
        end else begin
            zero_flag = 1'b0;
        end
    end

endmodule
