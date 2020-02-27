`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/28 13:59:46
// Design Name: 
// Module Name: MUL
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


module MUL(
    input clk,
    input [31:0]a,
    input [31:0]b,
    output reg[63:0]z
    );
    wire [31:0]temp1;
    wire [31:0]temp2;
    /*
    reg [2:0]counter;
   reg sign; 
   reg sign1;
   reg [63:0]temp;
   wire [31:0]temp1;
   wire [31:0]temp2;
   reg [31:0]temp3;
   reg [63:0] store0;
   reg [63:0] store1;
   reg [63:0] store2;
   reg [63:0] store3;
   reg [63:0] store4;
   reg [63:0] store5;
   reg [63:0] store6;
   reg [63:0] store7;
   reg [63:0] store8;
   reg [63:0] store9;
   reg [63:0] store10;
   reg [63:0] store11;
   reg [63:0] store12;
   reg [63:0] store13;
   reg [63:0] store14;
   reg [63:0] store15;
   reg [63:0] store16;
   reg [63:0] store17;
   reg [63:0] store18;
   reg [63:0] store19;
   reg [63:0] store20;
   reg [63:0] store21;
   reg [63:0] store22;
   reg [63:0] store23;
   reg [63:0] store24;
   reg [63:0] store25;
   reg [63:0] store26;
   reg [63:0] store27;
   reg [63:0] store28;
   reg [63:0] store29;
   reg [63:0] store30;
   reg [63:0] store31;
   always@(posedge clk or posedge reset )begin
   if(reset)begin
   busy<=0;
   sign<=0;
   sign1<=0;
   temp<=64'b0;
   store0<=64'b0;
   store1<=64'b0;
   store2<=64'b0;
   store3<=64'b0;
   store4<=64'b0;
   store5<=64'b0;
   store6<=64'b0;
   store7<=64'b0;
   store8<=64'b0;
   store9<=64'b0;
   store10<=64'b0;
   store11<=64'b0;
   store12<=64'b0;
   store13<=64'b0;
   store14<=64'b0;
   store15<=64'b0;
   store16<=64'b0;
   store17<=64'b0;
   store18<=64'b0;
   store19<=64'b0;
   store20<=64'b0;
   store21<=64'b0;
   store22<=64'b0;
   store23<=64'b0;
   store24<=64'b0;
   store25<=64'b0;
   store26<=64'b0;
   store27<=64'b0;
   store28<=64'b0;
   store29<=64'b0;
   store30<=64'b0;
   store31<=64'b0;
   end
   else begin
   if(counter==2)begin
   busy<=0;
   counter<=0;
   end
   else busy<=1;
    counter<=counter+1;
      sign<=(a[31]!=b[31])?1:0;
      store0<=temp1[0]?{32'b0,temp2}:64'b0;
      store1<=temp1[1]?{31'b0,temp2,1'b0}:64'b0;
      store2<=temp1[2]?{30'b0,temp2,2'b0}:64'b0;
      store3<=temp1[3]?{29'b0,temp2,3'b0}:64'b0;
      store4<=temp1[4]?{28'b0,temp2,4'b0}:64'b0;
      store5<=temp1[5]?{27'b0,temp2,5'b0}:64'b0;
      store6<=temp1[6]?{26'b0,temp2,6'b0}:64'b0;
      store7<=temp1[7]?{25'b0,temp2,7'b0}:64'b0;
      store8<=temp1[8]?{24'b0,temp2,8'b0}:64'b0;
      store9<=temp1[9]?{23'b0,temp2,9'b0}:64'b0;
      store10<=temp1[10]?{22'b0,temp2,10'b0}:64'b0;
      store11<=temp1[11]?{21'b0,temp2,11'b0}:64'b0;
      store12<=temp1[12]?{20'b0,temp2,12'b0}:64'b0;
      store13<=temp1[13]?{19'b0,temp2,13'b0}:64'b0;
      store14<=temp1[14]?{18'b0,temp2,14'b0}:64'b0;
      store15<=temp1[15]?{17'b0,temp2,15'b0}:64'b0;
      store16<=temp1[16]?{16'b0,temp2,16'b0}:64'b0;
      store17<=temp1[17]?{15'b0,temp2,17'b0}:64'b0;
      store18<=temp1[18]?{14'b0,temp2,18'b0}:64'b0;
      store19<=temp1[19]?{13'b0,temp2,19'b0}:64'b0;
      store20<=temp1[20]?{12'b0,temp2,20'b0}:64'b0;
      store21<=temp1[21]?{11'b0,temp2,21'b0}:64'b0;
      store22<=temp1[22]?{10'b0,temp2,22'b0}:64'b0;
      store23<=temp1[23]?{9'b0,temp2,23'b0}:64'b0;
      store24<=temp1[24]?{8'b0,temp2,24'b0}:64'b0;
      store25<=temp1[25]?{7'b0,temp2,25'b0}:64'b0;
      store26<=temp1[26]?{6'b0,temp2,26'b0}:64'b0;
      store27<=temp1[27]?{5'b0,temp2,27'b0}:64'b0;
      store28<=temp1[28]?{4'b0,temp2,28'b0}:64'b0;
      store29<=temp1[29]?{3'b0,temp2,29'b0}:64'b0;
      store30<=temp1[30]?{2'b0,temp2,30'b0}:64'b0; 
      store31<=temp1[31]?{1'b0,temp2,31'b0}:64'b0; 
      temp<=store0+store1+store2+store3+store4+store5+store6+store7+store8+store9+store10+store11+store12+store13+store14+store15+store16+store17+store18+store19+store20+store21+store22+store23+store24+store25+store26+store27+store28+store29+store30+store31;
      sign1<=sign;
   end
   end
   assign z=sign1?(~temp+1):temp;
   assign temp1=a[31]?(~a+1):a;
   assign temp2=b[31]?(~b+1):b;
   */
      always@(*)begin
      z <=(a[31]==b[31])?( (temp1[0] ? {32'b0,temp2}:64'b0) 
      + (temp1[1] ? {31'b0,temp2,1'b0} : 64'b0)
      +(temp1[2] ? {30'b0, temp2, 2'b0} : 64'b0) 
      + (temp1[3] ? {29'b0,temp2,3'b0} : 64'b0)
      +(temp1[4] ? {28'b0, temp2, 4'b0} : 64'b0) 
      + (temp1[5] ? {27'b0,temp2,5'b0} : 64'b0)
      +(temp1[6] ? {26'b0, temp2, 6'b0} : 64'b0) 
      + (temp1[7] ? {25'b0,temp2,7'b0} : 64'b0)
      +(temp1[8] ? {24'b0, temp2, 8'b0} : 64'b0) 
      + (temp1[9] ? {23'b0,temp2,9'b0} : 64'b0)
      +(temp1[10] ? {22'b0, temp2, 10'b0} : 64'b0) 
      + (temp1[11] ? {21'b0,temp2,11'b0} : 64'b0)
      +(temp1[12] ? {20'b0, temp2, 12'b0} : 64'b0) 
      + (temp1[13] ? {19'b0,temp2,13'b0} : 64'b0)
      +(temp1[14] ? {18'b0, temp2, 14'b0} : 64'b0) 
      + (temp1[15] ? {17'b0,temp2,15'b0} : 64'b0)
      +(temp1[16] ? {16'b0, temp2, 16'b0} : 64'b0) 
      + (temp1[17] ? {15'b0,temp2,17'b0} : 64'b0)
      +(temp1[18] ? {14'b0, temp2, 18'b0} : 64'b0) 
      + (temp1[19] ? {13'b0,temp2,19'b0} : 64'b0)
      +(temp1[20] ? {12'b0, temp2, 20'b0} : 64'b0) 
      + (temp1[21] ? {11'b0,temp2,21'b0} : 64'b0)
      +(temp1[22] ? {10'b0, temp2, 22'b0} : 64'b0) 
      + (temp1[23] ? {9'b0,temp2,23'b0} : 64'b0)
      +(temp1[24] ? {8'b0, temp2, 24'b0} : 64'b0) 
      + (temp1[25] ? {7'b0,temp2,25'b0} : 64'b0)
      +(temp1[26] ? {6'b0, temp2, 26'b0} : 64'b0) 
      + (temp1[27] ? {5'b0,temp2,27'b0} : 64'b0)
      +(temp1[28] ? {4'b0, temp2, 28'b0} : 64'b0) 
      + (temp1[29] ? {3'b0,temp2,29'b0} : 64'b0)
      +(temp1[30] ? {2'b0, temp2, 30'b0} : 64'b0) 
      + (temp1[31] ? {1'b0,temp2,31'b0} : 64'b0)):
      (~((temp1[0] ? {32'b0,temp2}:64'b0) 
      + (temp1[1] ? {31'b0,temp2,1'b0} : 64'b0)
      +(temp1[2] ? {30'b0, temp2, 2'b0} : 64'b0) 
      + (temp1[3] ? {29'b0,temp2,3'b0} : 64'b0)
      +(temp1[4] ? {28'b0, temp2, 4'b0} : 64'b0) 
      + (temp1[5] ? {27'b0,temp2,5'b0} : 64'b0)
      +(temp1[6] ? {26'b0, temp2, 6'b0} : 64'b0) 
      + (temp1[7] ? {25'b0,temp2,7'b0} : 64'b0)
      +(temp1[8] ? {24'b0, temp2, 8'b0} : 64'b0) 
      + (temp1[9] ? {23'b0,temp2,9'b0} : 64'b0)
      +(temp1[10] ? {22'b0, temp2, 10'b0} : 64'b0) 
      + (temp1[11] ? {21'b0,temp2,11'b0} : 64'b0)
      +(temp1[12] ? {20'b0, temp2, 12'b0} : 64'b0) 
      + (temp1[13] ? {19'b0,temp2,13'b0} : 64'b0)
      +(temp1[14] ? {18'b0, temp2, 14'b0} : 64'b0) 
      + (temp1[15] ? {17'b0,temp2,15'b0} : 64'b0)
      +(temp1[16] ? {16'b0, temp2, 16'b0} : 64'b0) 
      + (temp1[17] ? {15'b0,temp2,17'b0} : 64'b0)
      +(temp1[18] ? {14'b0, temp2, 18'b0} : 64'b0) 
      + (temp1[19] ? {13'b0,temp2,19'b0} : 64'b0)
      +(temp1[20] ? {12'b0, temp2, 20'b0} : 64'b0) 
      + (temp1[21] ? {11'b0,temp2,21'b0} : 64'b0)
      +(temp1[22] ? {10'b0, temp2, 22'b0} : 64'b0) + (temp1[23] ? {9'b0,temp2,23'b0} : 64'b0)+(temp1[24] ? {8'b0, temp2, 24'b0} : 64'b0) + (temp1[25] ? {7'b0,temp2,25'b0} : 64'b0)+(temp1[26] ? {6'b0, temp2, 26'b0} : 64'b0) + (temp1[27] ? {5'b0,temp2,27'b0} : 64'b0)+(temp1[28] ? {4'b0, temp2, 28'b0} : 64'b0) + (temp1[29] ? {3'b0,temp2,29'b0} : 64'b0)+(temp1[30] ? {2'b0, temp2, 30'b0} : 64'b0) + (temp1[31] ? {1'b0,temp2,31'b0} : 64'b0))+1);
      end
   assign temp1=a[31]?(~a+1):a;
   assign temp2=b[31]?(~b+1):b;
endmodule
