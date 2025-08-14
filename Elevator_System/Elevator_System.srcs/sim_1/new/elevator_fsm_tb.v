`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 03:51:42 PM
// Design Name: 
// Module Name: elevator_fsm_tb
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


// ===================================
// Testbench for Elevator FSM (3 Floors)
// Simulates all transitions floor-by-floor
// ===================================


module elevator_fsm_tb();

    // Testbench Signals
    reg clk;
    reg reset;
    reg [1:0] request_floor;
    wire [1:0] current_floor;
    wire door_open_led;
    wire [2:0] state_led;

    // Instantiate the elevator FSM
    elevator_fsm uut (
        .clk(clk),
        .reset(reset),
        .request_floor(request_floor),
        .current_floor(current_floor),
        .door_open_led(door_open_led),
        .state_led(state_led)
    );

    // Clock Generation (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test Sequence
    initial begin
        $display("=== Starting Elevator FSM Testbench ===");

        // Initial reset
        reset = 1;
        request_floor = 2'b00;
        #20;
        reset = 0;

        // === Test Case 1: Go from 0 -> 1 ===
        request_floor = 2'b01;
        #100;

        // === Test Case 2: Go from 1 -> 2 ===
        request_floor = 2'b10;
        #100;

        // === Test Case 3: Go from 2 -> 1 ===
        request_floor = 2'b01;
        #100;

        // === Test Case 4: Go from 1 -> 0 ===
        request_floor = 2'b00;
        #100;

        // === Test Case 5: Request same floor (0 -> 0) ===
        request_floor = 2'b00;
        #60;

        // === Test Case 6: 0 -> 2 Direct ===
        request_floor = 2'b10;
        #150;

        // === Test Case 7: 2 -> 0 Direct ===
        request_floor = 2'b00;
        #150;

        // End simulation
        $display("=== Finished Elevator FSM Testbench ===");
        $finish;
    end

endmodule