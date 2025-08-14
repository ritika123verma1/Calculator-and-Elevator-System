`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 04:12:22 PM
// Design Name: 
// Module Name: calculator_tb
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
// Professional Testbench for Calculator
// Author: ChatGPT | OpenAI
// ======================================

`timescale 1ns / 1ps

module calculator_tb();

    // DUT I/Os
    reg clk;
    reg reset;
    reg [3:0] operand_a;
    reg [3:0] operand_b;
    reg [2:0] operation;
    reg confirm_btn;
    wire [7:0] result;
    wire error_flag;

    // Instantiate DUT
    calculator_system uut (
        .clk(clk),
        .reset(reset),
        .operand_a(operand_a),
        .operand_b(operand_b),
        .operation(operation),
        .confirm_btn(confirm_btn),
        .result(result),
        .error_flag(error_flag)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Task for test cases
    task perform_operation;
        input [3:0] a, b;
        input [2:0] op;
        input [8*20:1] op_name;
        begin
            @(negedge clk);//input negative edge par change honge 
            operand_a = a;
            operand_b = b;
            operation = op;
            confirm_btn = 1;
            @(negedge clk);
            confirm_btn = 0;
            #20;
            $display("[%s] A = %0d, B = %0d => Result = %0d, Error = %b", op_name, a, b, result, error_flag);
        end
    endtask

    // Test sequence
    initial begin
        $display("\n===== Calculator Functional Testbench Start =====");

        // Initial reset
        reset = 1;
        operand_a = 0;
        operand_b = 0;
        operation = 0;
        confirm_btn = 0;
        #15;
        reset = 0;

        // Functional cases
        perform_operation(5, 3, 3'b000, "ADD");    // 5 + 3 = 8
        perform_operation(7, 2, 3'b001, "SUB");    // 7 - 2 = 5
        perform_operation(4, 3, 3'b010, "MUL");    // 4 * 3 = 12
        perform_operation(8, 2, 3'b011, "DIV");    // 8 / 2 = 4
        perform_operation(9, 4, 3'b100, "MOD");    // 9 % 4 = 1
        perform_operation(5, 0, 3'b101, "SQR");    // 5^2 = 25
        perform_operation(9, 0, 3'b110, "SQRT");   // sqrt(9) ≈ 3

        // Edge case: divide by zero
        perform_operation(6, 0, 3'b011, "DIV_BY_0");

        // Edge case: sqrt of zero
        perform_operation(0, 0, 3'b110, "SQRT_0");

        // Edge case: subtraction to negative
        perform_operation(2, 6, 3'b001, "NEG_SUB");

        $display("\n===== Testbench Completed Successfully =====\n");
        $finish;
    end

endmodule