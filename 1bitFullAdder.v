`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:10:57
// Design Name: 
// Module Name: 1bitFA
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


// 1-bit Full Adder: gate-level implementation
module full_adder(a, b, cin, sum, cout);
 input  a, b, cin;
 output sum, cout;
 wire   axb, ab, bc, ac;
 xor G1(axb, a, b);
 xor G2(sum, axb, cin);
 and G3(ab, a, b);
 and G4(bc, b, cin);
 and G5(ac, a, cin);
 or  G6(cout, ab, bc, ac);
endmodule
