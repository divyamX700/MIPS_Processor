`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:08:17
// Design Name: 
// Module Name: signextend
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


// Sign-extend 16?32
module sign_extender(imm_in, imm_out);
 input  [15:0] imm_in;
 output [31:0] imm_out;
 wire   sign_bit = imm_in[15];
 assign imm_out = {{16{sign_bit}}, imm_in};
endmodule
