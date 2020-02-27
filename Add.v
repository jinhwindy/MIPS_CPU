`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 11:28:57
// Design Name: 
// Module Name: Add
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


module Add(
input [31:0]a,b,
output reg[31:0]odata
    );
    reg[32:0]temp;
    always@*begin
     temp={a[31],a}+{b[31],b};
     odata=temp[31:0];
    end
endmodule
