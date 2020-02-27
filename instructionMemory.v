`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 08:41:21
// Design Name: 
// Module Name: instructionMemory
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


module instructionMemory(
input [31:0]PC,
output [31:0]inst
    );
    reg [31:0]mem[0:1023];
    /*
    initial begin
    mem[1]=32'h05410002;
    end
    */
    initial begin 
    $readmemh("C:/Users/Lenovo/Desktop/testtxt.txt", mem); 
    end
    assign inst=mem[PC[31:2]][31:0];
endmodule
