`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 09:13:11
// Design Name: 
// Module Name: PC
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


module PC(
input busy,
input [31:0]instruction,
input signexc_addr,
input [31:0]exc_addr,
input PC_CLK,Reset,
input [31:0]npcORother,
output reg [31:0]Address
    );
    reg [7:0]counter;
    always@(posedge PC_CLK or posedge Reset)begin
    if(Reset==1)begin
    Address<=32'h00400000;//重点修改//////////////////////////////////////////////////////////////////////////////////////
    counter<=0;
    end
   else if(signexc_addr)Address<=exc_addr+32'h00400000;
   else if((instruction[31:26]==6'b0&&(instruction[5:0]==6'b011010||instruction[5:0]==6'b011011)))begin//除法的34个延时
   counter<=counter+1;
       if(counter==8'd34)begin
       Address<=npcORother;
       counter<=0;
       end
   end
  else  Address<=npcORother;
   end
endmodule
