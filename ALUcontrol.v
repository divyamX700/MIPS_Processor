`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:10:03
// Design Name: 
// Module Name: alucontrol
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


// ALU Control
module alu_control(alu_op, funct, alu_ctl);
 input  [1:0] alu_op;
 input  [5:0] funct;
 output [2:0] alu_ctl;
 wire op00 = ~alu_op[1] & ~alu_op[0]; // lw/sw
 wire op01 = ~alu_op[1] &  alu_op[0]; // beq
 wire op10 =  alu_op[1] & ~alu_op[0]; // R-type
 wire f_add = (funct == 6'h20);
 wire f_sub = (funct == 6'h22);
 wire f_and = (funct == 6'h24);
 wire f_or  = (funct == 6'h25);
 wire f_slt = (funct == 6'h2A);
 assign alu_ctl[2] = op01 | (op10 & (f_sub | f_slt));
 assign alu_ctl[1] = op00 | op01 | (op10 & (f_add | f_sub | f_slt));
 assign alu_ctl[0] = op10 & (f_or  | f_slt);
endmodule
