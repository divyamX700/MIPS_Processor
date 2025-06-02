`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:07:10
// Design Name: 
// Module Name: RegDstmux
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


// 3:1 RegDst multiplexer: rt, rd, or $31 (jal)
module mux3_regdst(rt, rd, sel_regdst, sel_jal, reg_dst);
 input  [4:0] rt, rd;
 input        sel_regdst, sel_jal;
 output [4:0] reg_dst;
 wire   [4:0] sel_jal_ext    = {5{sel_jal}};
 wire   [4:0] sel_regdst_ext = {5{sel_regdst}};
 wire   [4:0] tmp = (rd & sel_regdst_ext) | (rt & ~sel_regdst_ext);
 assign reg_dst = (tmp & ~sel_jal_ext) | (5'd31 & sel_jal_ext);
endmodule
