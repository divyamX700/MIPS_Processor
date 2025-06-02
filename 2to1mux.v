`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:06:02
// Design Name: 
// Module Name: mux2to1
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


// 2:1 multiplexer (32-bit) using gate-level logic
module mux2(d0, d1, sel, y);
 input  [31:0] d0, d1;
 input         sel;
 output [31:0] y;
 wire   [31:0] sel_ext = {32{sel}};
 assign y = (d0 & ~sel_ext) | (d1 & sel_ext);
endmodule
