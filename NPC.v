`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/27 18:54:31
// Design Name: 
// Module Name: NPC
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


module NPC(
input [31:0]Address,
//input clk,reset,
//output reg[31:0]address
output [31:0]address
    );
//always@(negedge clk or posedge reset)begin
//if(reset)address<=32'h00400000;
//else if(~clk)address<=Address+32'd4;
assign address=Address+32'd4;
//end
endmodule

