`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/28 13:41:19
// Design Name: 
// Module Name: sregister
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


module sregister(
input clk,
input rst,
input rr,//¼Ä´æÆ÷¶Á
input rw,//¼Ä´æÆ÷Ð´
input [31:0]data,
output [31:0]odata
    );
    reg [31:0]register;
    always@(negedge clk or  posedge rst)begin
    if(rst==1)register<=31'd0;
    else if(rw)register<=data;
    end
    assign odata=(rr)?register:0;
endmodule
