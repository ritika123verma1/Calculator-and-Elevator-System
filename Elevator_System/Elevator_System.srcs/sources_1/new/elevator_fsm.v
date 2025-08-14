`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 03:48:59 PM
// Design Name: 
// Module Name: elevator_fsm
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

// ============================
// Elevator Control System FSM
// 3 Floors | Verilog | Vivado
// ============================

module elevator_fsm (
    input clk,
    input reset,
    input [1:0] request_floor,     // 2-bit input for floors: 00, 01, 10
    output reg [1:0] current_floor,
    output reg door_open_led,
    output reg [2:0] state_led     // For debugging: shows current FSM state
);

// FSM State Definitions
parameter IDLE           = 3'b000,
          MOVING_UP      = 3'b001,
          MOVING_DOWN    = 3'b010,
          DOOR_OPEN      = 3'b011,
          DOOR_CLOSED    = 3'b100;
         // EMERGENCY_STOP = 3'b101;

reg [2:0] state, next_state;

// State Register
// sequencial block 
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= IDLE;
    else
        state <= next_state;
end

// Next-State Logic
//combinational block 
always @(*) begin
    next_state = state; // default
    case (state)
        IDLE: begin
            if (request_floor > current_floor)
                next_state = MOVING_UP;
            else if (request_floor < current_floor)
                next_state = MOVING_DOWN;
            else
                next_state = DOOR_OPEN;
        end
        MOVING_UP: begin
            if (current_floor == request_floor)
                next_state = DOOR_OPEN;
        end
        MOVING_DOWN: begin
            if (current_floor == request_floor)
                next_state = DOOR_OPEN;
        end
        DOOR_OPEN: begin
            next_state = DOOR_CLOSED;
        end
        DOOR_CLOSED: begin
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

// Output & Floor Update Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_floor <= 2'd0;
    end else begin
        case (state)
            MOVING_UP: begin
                if (current_floor < 2)
                    current_floor <= current_floor + 1;
            end
            MOVING_DOWN: begin
                if (current_floor > 0)
                    current_floor <= current_floor - 1;
            end
            
        endcase
    end
end

// Door LED Logic (Improved reliability)
always @(*) begin
    case (state)
        DOOR_OPEN: door_open_led = 1;
        default:   door_open_led = 0;
    endcase
end

// Debug LED (Optional)
always @(*) begin
    state_led = state;// current FSM state into the output LED lines.
end

endmodule