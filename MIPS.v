`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.04.2025 16:18:45
// Design Name: 
// Module Name: mips
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


// Top-level Single-Cycle MIPS Processor
module single_cycle_mips(clk, reset);
 input        clk, reset;
 reg    [31:0] pc;
 wire   [31:0] pc_plus4 = pc + 32'd4;
 wire   [31:0] instr;
 // Fetch
 instr_memory IM(.addr(pc), .instr(instr));
 // Decode fields
 wire [5:0]  opcode = instr[31:26];
 wire [4:0]  rs     = instr[25:21];
 wire [4:0]  rt     = instr[20:16];
 wire [4:0]  rd     = instr[15:11];
 wire [15:0] imm16  = instr[15:0];
 wire [25:0] addr26 = instr[25:0];
 // Control
 wire        reg_dst, alu_src, mem_to_reg, reg_write;
 wire        mem_read, mem_write, branch, jump, jal;
 wire  [1:0] alu_op;
 control_unit CU(.opcode(opcode), .reg_dst(reg_dst), .alu_src(alu_src),
                 .mem_to_reg(mem_to_reg), .reg_write(reg_write),
                 .mem_read(mem_read), .mem_write(mem_write),
                 .branch(branch), .jump(jump), .jal(jal), .alu_op(alu_op));
 // Register File
 wire [31:0] reg_data1, reg_data2;
 wire [4:0]  write_reg;
 mux3_regdst M3(.rt(rt), .rd(rd), .sel_regdst(reg_dst), .sel_jal(jal),
                 .reg_dst(write_reg));
 wire [31:0] wb_data;
 register_file RF(.clk(clk), .we(reg_write), .ra1(rs), .ra2(rt),
                  .wa(write_reg), .wd(wb_data), .rd1(reg_data1), .rd2(reg_data2));
 // Sign-extend
 wire [31:0] imm32;
 sign_extender SE(.imm_in(imm16), .imm_out(imm32));
 // ALU operand mux
 wire [31:0] alu_b;
 mux2 M2(.d0(reg_data2), .d1(imm32), .sel(alu_src), .y(alu_b));
 // ALU Control & ALU
 wire [2:0]  alu_ctl;
 wire [31:0] alu_result;
 wire        zero;
 alu_control AC(.alu_op(alu_op), .funct(instr[5:0]), .alu_ctl(alu_ctl));
 alu ALU(.a(reg_data1), .b(alu_b), .alu_control(alu_ctl),
         .result(alu_result), .zero(zero));
 // Data Memory
 wire [31:0] mem_rd;
 data_memory DM(.clk(clk), .we(mem_write), .addr(alu_result),
                .wd(reg_data2), .rd(mem_rd));
 // Write-back
 assign wb_data = jal ? pc_plus4 : (mem_to_reg ? mem_rd : alu_result);
 // Branch & Jump
 wire [31:0] branch_offset;
 shift_left_2 SL2(.in(imm32), .out(branch_offset));
 wire [31:0] branch_addr = pc_plus4 + branch_offset;
 wire [31:0] jump_addr   = {pc_plus4[31:28], addr26, 2'b00};
 wire        take_branch = branch & zero;
 wire [31:0] pc_next     = jump   ? jump_addr
                               : take_branch ? branch_addr
                                             : pc_plus4;
 // PC register
 always @(posedge clk or posedge reset) begin
   if (reset)
     pc <= 32'd0;
   else
     pc <= pc_next;
 end
endmodule
