`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 11:22:27
// Design Name: 
// Module Name: t_l_c
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


module t_l_c(
    input clk,
    input rst,
    output reg NS_R,NS_G,NS_Y, //north-south lights
    output reg EW_R,EW_G,EW_Y  //east-west lights
    );
    
    reg [1:0] current_state, next_state;
    
    parameter NS_GREEN   = 2'b00;
    parameter NS_YELLOW  = 2'b01;
    parameter EW_GREEN   = 2'b10;
    parameter EW_YELLOW  = 2'b11;
    
    reg[3:0] timer;
    
    parameter GREEN_TIME  = 4'd5;
    parameter YELLOW_TIME = 4'd2;
    
    //state transition logic
    always @(posedge clk or posedge rst)
     begin
      if (rst)
        begin
          current_state <= NS_GREEN;
          timer <= NS_GREEN;
        end
      else
       if (timer == 0)
        begin
          current_state <= next_state;
          
          case(next_state)
           NS_GREEN, EW_GREEN : timer <= GREEN_TIME;
           NS_YELLOW, EW_YELLOW : timer <= YELLOW_TIME;
           default : timer <= GREEN_TIME;
          endcase
        end
       else
         timer <= timer - 1;
     end
       
  //next state logic
  always @(*)
    begin
        case (current_state)
            NS_GREEN:   next_state = NS_YELLOW;
            NS_YELLOW:  next_state = EW_GREEN;
            EW_GREEN:   next_state = EW_YELLOW;
            EW_YELLOW:  next_state = NS_GREEN;
            default:    next_state = NS_GREEN;
        endcase
    end
    
    //output logic based on the current logic
           
     always @(*) begin
        // Default all lights OFF
        NS_R = 0; NS_Y = 0; NS_G = 0;
        EW_R = 0; EW_Y = 0; EW_G = 0;

        case (current_state)
            NS_GREEN:   begin NS_G = 1; EW_R = 1; end
            NS_YELLOW:  begin NS_Y = 1; EW_R = 1; end
            EW_GREEN:   begin EW_G = 1; NS_R = 1; end
            EW_YELLOW:  begin EW_Y = 1; NS_R = 1; end
        endcase
    end

endmodule
