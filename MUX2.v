`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 10:29:04
// Design Name: 
// Module Name: MUX2
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


module MUX2(
input [31:0]Rt,Ddata,
input [31:0]Adata,
input [5:0]opcode,
input M2,
output [31:0]odata
    );
    assign odata=M2?Adata:(opcode==6'b100011||opcode==6'b100000||opcode==6'b100100||opcode==6'b100101||opcode==6'b100001)?Ddata:Rt;
endmodule
