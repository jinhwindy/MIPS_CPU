`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 09:21:13
// Design Name: 
// Module Name: RegisterFile
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


module RegisterFile(
input signjalr,
input signmfc0,
input signmul,
input signmflo,
input signmfhi,
input [31:0]npc,
input [31:0]hodata,
input [31:0]lodata,
input [31:0]mulz,
input [31:0]rdata,
input [31:0]data,
input reset,
input [4:0]Rsc,Rtc,Rdc,
input RF_W,
input   RF_CLK,
output [31:0]Rs,Rt
    );
    reg [31:0]array_reg[0:31];
    always@(negedge RF_CLK or posedge reset)begin
    if(reset) begin
    array_reg[0]<=0;
    array_reg[1]<=0;
    array_reg[2]<=0;
    array_reg[3]<=0;
    array_reg[4]<=0;
    array_reg[5]<=0;
    array_reg[6]<=0;
    array_reg[7]<=0;
    array_reg[8]<=0;
    array_reg[9]<=0;
    array_reg[10]<=0;
    array_reg[11]<=0;
    array_reg[12]<=0;
    array_reg[13]<=0;
    array_reg[14]<=0;
    array_reg[15]<=0;
    array_reg[16]<=0;
    array_reg[17]<=0;
    array_reg[18]<=0;
    array_reg[19]<=0;
    array_reg[20]<=0;
    array_reg[21]<=0;
    array_reg[22]<=0;
    array_reg[23]<=0;
    array_reg[24]<=0;
    array_reg[25]<=0;
    array_reg[26]<=0;
    array_reg[27]<=0;
    array_reg[28]<=0;
    array_reg[29]<=0;
    array_reg[30]<=0;
    array_reg[31]<=0;
    end
    if(RF_W&&Rdc)begin
    if(signmfc0)array_reg[Rdc]<=rdata;
    else if(signmul)array_reg[Rdc]<=mulz;
    else if(signmfhi)array_reg[Rdc]<=hodata;
    else if(signmflo)array_reg[Rdc]<=lodata;
    else if(signjalr)array_reg[Rdc]<=npc;
    else array_reg[Rdc]<=data;
    end
    end
    assign Rs=array_reg[Rsc];
    assign Rt=array_reg[Rtc];
endmodule
