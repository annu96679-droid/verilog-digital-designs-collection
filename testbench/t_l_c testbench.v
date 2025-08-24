`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.07.2025 11:55:50
// Design Name: 
// Module Name: tlc_stimuli
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


module tlc_stimuli();
reg clk, rst;
wire NS_R, NS_G, NS_Y, EW_R, EW_G, EW_Y;

    // Instantiate the design
t_l_c uut (.clk(clk), .rst(rst), .NS_R(NS_R), .NS_G(NS_G), .NS_Y(NS_Y),.EW_R(EW_R), .EW_G(EW_G), .EW_Y(EW_Y));
   

    // Clock generation: 10ns period
 initial 
 begin
    clk = 0;
    forever #5 clk = ~clk;
end

    // Test sequence
initial 
begin
   $monitor("time = %0t | clk = %b | rst = %b || NS_R = %b | NS_G = %b | NS_Y = %b | EW_R = %b | EW_ G = %b |EW_Y = %b",$time, clk, rst, NS_R, NS_G, NS_Y, EW_R, EW_G, EW_Y);
        rst = 1; #10;
        rst = 0; #300;  // Run simulation for 300 time units
        $finish;
    end
endmodule
