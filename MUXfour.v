`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/28 14:28:13
// Design Name: 
// Module Name: MUXfour
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


module MUXfour(
input [31:0]rs,
input [31:0]multua,
input [31:0]multub,
input [31:0]diva,
input [31:0]divb,
input [31:0]divua,
input [31:0]divub,
input [1:0]m,
output [31:0]a,
output [31:0]b
    );
    //0 mtlo mthi
    //1 multu
    //2 div
    //3 divu
    assign a=(m==2'd0)?rs:(m==2'd1)?multua:(m==2'd2)?diva:(m==2'd3)?divua:0;
    assign b=(m==2'd0)?rs:(m==2'd1)?multub:(m==2'd2)?divb:(m==2'd3)?divub:0;
endmodule
