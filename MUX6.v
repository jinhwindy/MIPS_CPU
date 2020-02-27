`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 11:00:57
// Design Name: 
// Module Name: MUX6
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


module MUX6(
input M6,
input [31:0]MUX4data,PC,
output [31:0]odata
    );
    assign odata=M6?PC:MUX4data;
endmodule
