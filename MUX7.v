`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 11:04:13
// Design Name: 
// Module Name: MUX7
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


module MUX7(
input M7,
input [31:0]MUX2data,MUX1data,
output [31:0]odata
    );
   assign odata=M7?MUX1data:MUX2data;
endmodule
