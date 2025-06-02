`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:12:20
// Design Name: 
// Module Name: 32bitALU
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


// 32-bit ALU: AND, OR, ADD, SUB, SLT
module alu(a, b, alu_control, result, zero);
 input  [31:0] a, b;
 input  [2:0]  alu_control;
 output [31:0] result;
 output        zero;
 wire is_and = (alu_control == 3'b000);
 wire is_or  = (alu_control == 3'b001);
 wire is_add = (alu_control == 3'b010);
 wire is_sub = (alu_control == 3'b110);
 wire is_slt = (alu_control == 3'b111);
 // invert b for subtraction/slt
 wire [31:0] b2 = b ^ {32{is_sub | is_slt}};
 wire        cin0 = is_sub | is_slt;
 // ripple-carry adder
 wire [31:0] sum;
 wire [31:0] carry;
 genvar i;
 generate
   for (i = 0; i < 32; i = i + 1) begin : ADDRIPPLE
     if (i == 0)
       full_adder FA(.a(a[0]), .b(b2[0]), .cin(cin0), .sum(sum[0]), .cout(carry[0]));
     else
       full_adder FA(.a(a[i]), .b(b2[i]), .cin(carry[i-1]), .sum(sum[i]), .cout(carry[i]));
   end
 endgenerate
 // set on less-than: sign of subtraction
 wire set = sum[31];
 wire [31:0] slt_res = {31'b0, set};
 // final result
 assign result = is_and        ? (a & b)    :
                 is_or         ? (a | b)    :
                 (is_add|is_sub)? sum       :
                 is_slt        ? slt_res    :
                 32'b0;
 assign zero = (result == 32'b0);
endmodule
