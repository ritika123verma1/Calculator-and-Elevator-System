`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 04:11:22 PM
// Design Name: 
// Module Name: calculator_system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// ======================================
// PROFESSIONAL VERILOG CALCULATOR SYSTEM
// With Input System via Buttons/Switches
// Supports: +, -, *, /, %, ^2, sqrt
// ======================================

module calculator_system (
    input clk,
    input reset,
    input [3:0] operand_a,
    input [3:0] operand_b,
    input [2:0] operation,   // 3-bit opcode: 000=add, 001=sub, 010=mul, 011=div, 100=mod, 101=square, 110=sqrt
    input confirm_btn,       // to let the calcultor to calculate calculation
    output reg [7:0] result,
    output reg error_flag    // division by zero or sqrt(-ve)
);

// Opcodes
parameter ADD  = 3'b000,
          SUB  = 3'b001,
          MUL  = 3'b010,
          DIV  = 3'b011,
          MOD  = 3'b100,
          SQRE = 3'b101,
          SQRT = 3'b110;

reg [7:0] temp_result;
//hmara result positive edge of clock par change hoga 
always @(posedge clk or posedge reset) begin
    if (reset) begin
        result <= 8'd0;
        error_flag <= 0;
    end else if (confirm_btn) begin
        error_flag <= 0;
        case (operation)
            ADD:  temp_result = operand_a + operand_b;
            SUB:  temp_result = operand_a - operand_b;
            MUL:  temp_result = operand_a * operand_b;
            DIV:  begin
                if (operand_b == 0) begin
                    error_flag <= 1;
                    temp_result = 8'd0;
                end else temp_result = operand_a / operand_b;
            end
            MOD:  begin
                if (operand_b == 0) begin
                    error_flag <= 1;
                    temp_result = 8'd0;
                end else temp_result = operand_a % operand_b;
            end
            SQRE: temp_result = operand_a * operand_a;
            SQRT: begin
                if (operand_a == 0) temp_result = 0;
                else if (operand_a == 1) temp_result = 1;
                else if (operand_a <= 3) temp_result = 1;
                else if (operand_a <= 8) temp_result = 2;
                else if (operand_a <= 15) temp_result = 3;
                else temp_result = 4; // approximation sqrt()
            end
            default: temp_result = 8'd0;
        endcase
        result <= temp_result;
    end
end

endmodule
