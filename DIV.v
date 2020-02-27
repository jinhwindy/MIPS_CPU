`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/28 13:55:19
// Design Name: 
// Module Name: DIV
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


module DIV(
input [31:0]dividend,//被除数
input [31:0]divisor,//除数
input start,
input clock,
input reset,
output [31:0]q,
output [31:0]r,
output reg busy
    );
    reg [7:0]count;
    reg [31:0]reg_q;
    reg [31:0]reg_r;
    reg [31:0]reg_b;
    reg r_sign;
    wire [32:0]sub_add;
    wire [31:0]temp_q;
    assign r=r_sign?~dividend[31]?reg_r+reg_b:~(reg_r+reg_b)+1:~dividend[31]?reg_r:~reg_r+1;
    assign q=(dividend[31]==divisor[31])?reg_q:~reg_q+1;
    //assign temp_q=dividend[31]?~dividend+1:dividend;
    //assign sub_add=r_sign?{reg_r,temp_q[31-count]}+{1'b0,reg_b}:{reg_r,temp_q[31-count]}-{1'b0,reg_b};//进行加减法，作为余数
    assign sub_add=r_sign?{reg_r,reg_q[31]}+{1'b0,reg_b}:{reg_r,reg_q[31]}-{1'b0,reg_b};//进行加减法，作为余数
    always@(posedge clock or posedge reset)begin
    if(reset)begin
    count<=8'b0;
    busy<=0;
    end
    else begin
    if(start)begin
    reg_r<=31'b0;
    r_sign<=0;
    reg_q<=dividend[31]?~dividend+1:dividend;
    reg_b<=divisor[31]?~divisor+1:divisor;
    count<=8'b0;
    busy<=1'b1;
    end
    else if(busy)begin
    reg_r<=sub_add[31:0];//reg_r余数
    r_sign<=sub_add[32];
    reg_q<={reg_q[30:0],~sub_add[32]};
    count<=count+8'b1;
    if(count==8'd31)busy<=0;
    end
    end
    end
endmodule

