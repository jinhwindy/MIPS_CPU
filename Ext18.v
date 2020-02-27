`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 11:25:53
// Design Name: 
// Module Name: Ext18
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


module Ext18(
input [15:0]IMEM,
output [31:0]odata
    );
    assign odata={{14{IMEM[15]}},IMEM,2'd0};
endmodule
