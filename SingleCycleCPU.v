`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/17 13:14:27
// Design Name: 
// Module Name: SingleCycleCPU
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


module SingleCycleCPU(
input clk,reset,
output [31:0]inst,
output [31:0]pc,
output [31:0]addr
    );
    wire [5:0]opcode;
    wire [31:0]Address;
    wire [5:0]func;
    wire PC_CLK=clk;
    wire RF_CLK=clk;
    wire IM_R=1;
    wire RF_R;
    wire DM_R;
    wire RF_W;
    wire DM_W;
    wire [4:0]Rsc,Rtc,Rdc;
    wire M1,M2,M3,M4,M5,M6,M7;
    //////////////////////////////////////////////////
    wire [5:0]ALUC;
    wire DM_CS;
    ///////////////////////////////////////////////////////
    wire [31:0]data1,data2,data3,data4,data5,data6,data7;
    wire [31:0]datae16,datae18,datae5;
    wire [31:0]adddata,ordata;
   ////////////////////////////////////////////////////////////////
   wire [31:0]aludata,naddress,indata,outdata,Rs,Rt;
    wire [4:0]IMEM10_6;
    wire [15:0]IMEM15_0;
    wire [25:0]IMEM25_0;
    wire zero,carry,negative,overflow;
    wire [31:0]instruction,TPC;
    /////////////////////
    wire hir,hiw,lor,low;
    wire [31:0]hidata,hodata,lidata,lodata;
    ////////////////////////////////
    wire [63:0]mulz,multuz;
    ///////////////////////////////////
    wire [31:0]divq,divr,divuq,divur;
    /////////////////////////////////
    wire busy1,busy2,busy;
    wire [1:0]muxf;
    ///////////////////////////////////////
    wire exception,eret;
    wire [31:0]rdata,exc_addr;
    wire [4:0]cause;
    wire signmfc0;
    wire signmtc0;
    wire signmul;
    wire signmflo;
    wire signmfhi;
    wire signjalr;
    wire [2:0]mode;//选择数据存储器的模式
    wire signexc_addr;
    reg  start;
    reg  counter;
    ///////////////////////////////////////////
    ALU alu(ALUC,data3,data6,aludata,zero,carry,negative,overflow);
    Add add(datae18,naddress,adddata);
    ControlUnit CU(aludata,instruction,opcode,func,RF_R,DM_R,RF_W,DM_W,M1,M2,M3,M4,M5,M6,M7,ALUC,DM_CS,muxf,lor,low,hir,hiw,exception,eret,cause,mode);
    DMEM dm(clk,mode,aludata,DM_CS,DM_W,DM_R,Rt,outdata);
    Ext16 ext16(IMEM15_0,opcode,datae16);
    Ext18 ext18(IMEM15_0,datae18);
    Ext5 ext5(IMEM10_6,datae5);
    MUX1 mux1(ordata,data5,M1,data1);
    MUX2 mux2(Rt,outdata,aludata,opcode,M2,data2);
    MUX3 mux3(M3,Rs,datae5,data3);
    MUX4 mux4(M4,Rt,datae16,data4);
    /////////////////////在bgez中通过判断aludata【0】的值确定是否转移
    MUX5 mux5(aludata[0],adddata,naddress,data5,zero,opcode);
    MUX6 mux6(M6,data4,Address,data6);
    MUX7 mux7(M7,data2,data1,data7);
    NPC npc(Address,naddress);
    OR Or(Address,IMEM25_0,ordata);
    //instructionMemory im(TPC,instruction);
    
    imem your_instance_name (
      .a(TPC[12:2]),      // input wire [10 : 0] a
      .spo(instruction)  // output wire [31 : 0] spo
    );
    
    PC pc1(busy1,instruction,exception,exc_addr,PC_CLK,reset,data7,Address);
    RegisterFile cpu_ref(signjalr,signmfc0,signmul,signmflo,signmfhi,naddress,hodata,lodata,mulz[31:0],rdata,data2,reset,Rsc,Rtc,Rdc,RF_W,RF_CLK,Rs,Rt);
    //////////////////////////////////////////////
    sregister HI(clk,reset,hir,hiw,hidata,hodata);
    sregister LO(clk,reset,lor,low,lidata,lodata);
        //////////////////////////////////////////
        MUL mul(clk,Rs,Rt,mulz);
        MULTU multu(clk,Rs,Rt,multuz);
        DIV div(Rs,Rt,start,clk,reset,divq,divr,busy1);
        DIVU divu (Rs,Rt,start,clk,reset,divuq,divur,busy2);
        MUXfour muxfour(Rs,multuz[63:32],multuz[31:0],divq,divr,divuq,divur,muxf,hidata,lidata);
        CP0 cp0(clk,reset,signmfc0,signmtc0,TPC,instruction[15:11],Rt,exception,eret,cause,rdata,exc_addr);
    assign addr=aludata;
    assign pc=Address;
    assign opcode=IM_R?instruction[31:26]:0;
    assign Rsc=IM_R?instruction[25:21]:0;
    assign Rtc=IM_R?(instruction[31:26]==0)?(instruction[5:0]==6'b001000)?instruction[25:21]:instruction[20:16]:instruction[20:16]:0;
    //assign Rdc=IM_R?((instruction[31:26]==6'b011100&&instruction[5:0]==6'b100000)||(instruction[31:26]==6'b011100&&instruction[5:0]==6'b000010))?instruction[15:11]:(instruction[31:26]==6'b000011||(instruction[31:26]==6'd0&&instruction[5:0]==6'b001001))?6'd31:(instruction[31:26]!=0)?instruction[20:16]:instruction[15:11]:0;
    assign Rdc=IM_R?((instruction[31:26]==6'b011100&&instruction[5:0]==6'b100000)||(instruction[31:26]==6'b011100&&instruction[5:0]==6'b000010))?instruction[15:11]:(instruction[31:26]==6'b000011)?6'd31:(instruction[31:26]!=0)?instruction[20:16]:instruction[15:11]:0;
    assign IMEM10_6=IM_R?instruction[10:6]:0;
    assign IMEM15_0=IM_R?instruction[15:0]:0;
    assign IMEM25_0=IM_R?instruction[25:0]:0;
    assign func=IM_R?instruction[5:0]:0;
    assign inst=IM_R?instruction[31:0]:0;
    assign TPC=Address-32'h00400000;
    assign signmul=(instruction[31:26]==6'b011100&&instruction[5:0]==6'b000010)?1:0;
    assign signmflo=(instruction[31:26]==0&&instruction[5:0]==6'b010010)?1:0;
    assign signmfhi=(instruction[31:26]==0&&instruction[5:0]==6'b010000)?1:0;
    assign signmfc0=(instruction[31:21]==11'b01000000000)?1:0;
    assign signmtc0=(instruction[31:21]==11'b01000000100)?1:0;
    assign signjalr=(instruction[31:26]==6'b0&&instruction[5:0]==6'b001001)?1:0;
    assign signexc_addr=exception;
    assign busy=(instruction[31:26]==6'b0&&instruction[5:0]==6'b011010)?busy1:(instruction[31:26]==6'b0&&instruction[5:0]==6'b011011)?busy2:0;
    always@(negedge clk or posedge reset)begin
    if(reset)begin
    counter<=0;
    start<=0;
    end
    else if(instruction[31:26]==6'B0&&(instruction[5:0]==6'b011010||instruction[5:0]==6'b011011))begin
        if(~counter)begin
        start<=1;
        counter<=1;
        end
        else begin
        start<=0;
        end
    end
    else begin
    counter<=0;
    start<=0;
    end
    end
endmodule
