`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:16:35
// Design Name: 
// Module Name: controlunit
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


// Main Control Unit
module control_unit(opcode, reg_dst, alu_src, mem_to_reg, reg_write,
                   mem_read, mem_write, branch, jump, jal, alu_op);
 input  [5:0] opcode;
 output       reg_dst, alu_src, mem_to_reg, reg_write;
 output       mem_read, mem_write, branch, jump, jal;
 output [1:0] alu_op;
 // decode fields
 wire is_rtype = (opcode == 6'h00);
 wire is_lw    = (opcode == 6'h23);
 wire is_sw    = (opcode == 6'h2B);
 wire is_beq   = (opcode == 6'h04);
 wire is_j     = (opcode == 6'h02);
 wire is_jal   = (opcode == 6'h03);
 assign reg_dst    = is_rtype;
 assign alu_src    = is_lw | is_sw;
 assign mem_to_reg = is_lw;
 assign reg_write  = is_rtype | is_lw | is_jal;
 assign mem_read   = is_lw;
 assign mem_write  = is_sw;
 assign branch     = is_beq;
 assign jump       = is_j | is_jal;
 assign jal        = is_jal;
 assign alu_op[1]  = is_rtype;
 assign alu_op[0]  = is_beq;
endmodule
