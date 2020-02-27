`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 11:11:38
// Design Name: 
// Module Name: Ext16
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


module Ext16(
input [15:0]IMEM,
input [5:0]opcode,
output [31:0]odata
    );
    parameter op_addi=6'b001000,
                          op_addiu=6'b001001,
                          op_andi=6'b001100,
                          op_ori=6'b001101,
                          op_xori=6'b001110,
                          op_lui=6'b001111,
                          op_lw=6'b100011,
                          op_sw=6'b101011,
                          op_beq=6'b000100,
                          op_bne=6'b000101,
                          op_slti=6'b001010,
                          op_sltiu=6'b001011,
                          op_j=6'b000010,
                          op_jal=6'b000011;
    assign odata=(opcode==op_addi||opcode==op_addiu||opcode==op_lw||opcode==op_sw||opcode==op_slti||opcode==op_sltiu)?{{16{IMEM[15]}},IMEM}:{16'd0,IMEM};
endmodule
