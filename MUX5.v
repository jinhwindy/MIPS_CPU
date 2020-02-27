`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 10:58:20
// Design Name: 
// Module Name: MUX5
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


module MUX5(
input M5,
input [31:0]Adata,NPC,
output [31:0]odata,
input zero,
input [5:0]opcode
    );
    assign odata=(opcode==6'b000100)?zero?Adata:NPC:(opcode==6'b000101)?(~zero)?Adata:NPC:(opcode==6'b000001&&M5)?Adata:NPC;
endmodule
