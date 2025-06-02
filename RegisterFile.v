`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:15:40
// Design Name: 
// Module Name: regfile
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


// Register File: 32×32, 2 read, 1 write (behavioral retains RTL nature)
module register_file(clk, we, ra1, ra2, wa, wd, rd1, rd2);
 input         clk, we;
 input  [4:0]  ra1, ra2, wa;
 input  [31:0] wd;
 output [31:0] rd1, rd2;
 reg    [31:0] rf [0:31];
 integer i;
 initial for (i = 0; i < 32; i = i + 1) rf[i] = 32'd0;
 assign rd1 = rf[ra1];
 assign rd2 = rf[ra2];
 always @(posedge clk)
   if (we) rf[wa] <= wd;
endmodule
