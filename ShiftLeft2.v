`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:09:06
// Design Name: 
// Module Name: shiftleft2
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


// Shift-left-2 for branch offset
module shift_left_2(in, out);
 input  [31:0] in;
 output [31:0] out;
 assign out = {in[29:0], 2'b00};
endmodule
