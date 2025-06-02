`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:14:21
// Design Name: 
// Module Name: imemory
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


// Instruction Memory: async read, 256 words
module instr_memory(addr, instr);
 input  [31:0] addr;
 output [31:0] instr;
 reg    [31:0] imem [0:255];
 integer i;
 initial for (i = 0; i < 256; i = i + 1) imem[i] = 32'd0;
 assign instr = imem[addr[31:2]];
endmodule
