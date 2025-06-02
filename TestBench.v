`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:01:20
// Design Name: 
// Module Name: testbench
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


module tb_single_cycle_mips;
 reg     clk;
 reg     reset;
 integer i;
 // Instantiate single-cycle MIPS processor
 single_cycle_mips UUT(
   .clk(clk),
   .reset(reset)
 );
 // Clock: 10 ns period
 initial begin
   clk = 0;
   forever #5 clk = ~clk;
 end
 // Reset at start
 initial begin
   reset = 1;
   #12;
   reset = 0;
 end
 // Preload registers and instruction memory
 initial begin
   // Set up initial register values
   UUT.RF.rf[8] = 32'd10; // $t0
   UUT.RF.rf[9] = 32'd3;  // $t1
   // Load test program
   UUT.IM.imem[0]  = 32'hAC080003; // sw  $t0, 3($zero)
   UUT.IM.imem[1]  = 32'h8C0F0003; // lw  $t7, 3($zero)
   UUT.IM.imem[2]  = 32'h01095020; // add $t2, $t0, $t1
   UUT.IM.imem[3]  = 32'h01095822; // sub $t3, $t0, $t1
   UUT.IM.imem[4]  = 32'h01886020; // add $t4, $t4, $t0
   UUT.IM.imem[5]  = 32'h01096825; // or  $t1, $t0, $t1
   UUT.IM.imem[6]  = 32'h0128702A; // slt $t6, $t1, $t0
   UUT.IM.imem[7]  = 32'h00000000; // nop (removed intermediate jump)
   UUT.IM.imem[8]  = 32'h00000000; // nop
   UUT.IM.imem[9]  = 32'h11090002; // beq $t0, $t1, 2
   UUT.IM.imem[10] = 32'h01095020; // add $t2, $t0, $t1 (branch target)
   UUT.IM.imem[11] = 32'h00000000; // nop
   UUT.IM.imem[12] = 32'h0C00000E; // jal 14
   UUT.IM.imem[13] = 32'hAC0A0004; // sw  $t2, 4($zero)
   UUT.IM.imem[14] = 32'h01095020; // subroutine: add $t2, $t0, $t1
   UUT.IM.imem[15] = 32'h0800000F; // final jump: to address 15 (self-loop/end)
   // Clear rest of instruction memory
   for (i = 16; i < 256; i = i + 1)
     UUT.IM.imem[i] = 32'd0;
 end
 // Monitor processor state in descriptive format
 always @(posedge clk) begin
   // Display time and PC
   $display("Time=%0t ns, PC=0x%h", $time, UUT.pc);
   // Display all registers
   for (i = 0; i < 32; i = i + 1) begin
     $display("R[%0d] = 0x%08h (%0d)", i, UUT.RF.rf[i], UUT.RF.rf[i]);
   end
   // Separator line
   $display("------------------------------");
 end
 // End simulation after sufficient cycles
 initial #300 $finish;
endmodule
