`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:13:35
// Design Name: 
// Module Name: dmemory
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


// Data Memory: sync write, async read, 256 words
module data_memory(clk, we, addr, wd, rd);
 input         clk, we;
 input  [31:0] addr, wd;
 output [31:0] rd;
 reg    [31:0] dmem [0:255];
 integer i;
 initial for (i = 0; i < 256; i = i + 1) dmem[i] = 32'd0;
 assign rd = dmem[addr[31:2]];
 always @(posedge clk)
   if (we) dmem[addr[31:2]] <= wd;
endmodule
