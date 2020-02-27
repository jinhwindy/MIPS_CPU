`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/17 16:08:24
// Design Name: 
// Module Name: ALU
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


module ALU(
input [5:0]ALUC,
//input [4:0]ALUC,
input [31:0]a,b,
output reg [31:0] r,
output reg zero,
output reg carry,
output reg negative,
output reg overflow
    );
    reg [32:0]temp;
    reg signed [31:0]temp0;
        parameter func_add=6'b000000,
                          func_addu=6'b000001,
                          func_sub=6'b000010,
                          func_subu=6'b000011,
                          func_and=6'b000100,
                          func_or=6'b000101,
                          func_xor=6'b000110,
                          func_nor=6'b000111,
                          func_slt=6'b001000,
                          func_sltu=6'b001001,
                          func_sll=6'b001010,
                          func_srl=6'b001011,
                          func_sra=6'b001100,
                          func_sllv=6'b001101,
                          func_srlv=6'b001110,
                          func_srav=6'b001111,
                          func_jr=6'b010000;
    parameter op_addi=6'b010001,
                          op_addiu=6'b010010,
                          op_andi=6'b010011,
                          op_ori=6'b010100,
                          op_xori=6'b010101,
                          op_lui=6'b010110,
                          op_lw=6'b010111,
                          op_sw=6'b011000,
                          op_beq=6'b011001,
                          op_bne=6'b011010,
                          op_slti=6'b011011,
                          op_sltiu=6'b011100,
                          op_j=6'b011101,
                          op_jal=6'b011110,
                          ///////////////////////////////////////////////////////////
                          op_bgez=6'b011111,
                          op_break=6'b100000,
                          op_div=6'b100001,
                          op_divu=6'b100010,
                          op_eret=6'b100011,
                          op_jalr=6'b100100,
                          op_lb=6'b100101,
                          op_lbu=6'b100110,
                          op_lh=6'b100111,
                          op_lhu=6'b101000,
                          op_mfc0=6'b101001,
                          op_mflo=6'b101010,
                          op_mtc0=6'b101011,
                          op_mthi=6'b101100,
                          op_mtlo=6'b101101,
                          op_mfhi=6'b101110,
                          op_mult=6'b101111,
                          op_multu=6'b110000,
                          op_sb=6'b110001,
                          op_sh=6'b110010,
                          op_syscall=6'b110011,
                          op_clz=6'b110100,
                          op_teq=6'b110101;
    always@*begin
    case(ALUC)
        func_add:begin 
        temp={a[31],a}+{b[31],b};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
        overflow=0;
        else overflow=1;
        //if(~overflow)
        r=temp[31:0];
        end
        func_addu:begin
        temp={1'b0,a}+{1'b0,b};
            if(temp[31:0]==32'd0)zero=1;
            else zero=0;
            if(temp[32]==1)carry=1;
            else carry=0;
            if(temp[31]==1)negative=1;
            else negative=0;
            r=temp[31:0];
        end
        func_subu:begin
        temp=a-b;
        if(temp==0)zero=1;
        else zero=0;
        if(a<b)carry=1;
        else carry=0;
        if(temp[31]==1)negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_sub:begin
        temp={a[31],a}-{b[31],b};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        if(((a[31]&b[31])|(~a[31]&~b[31]))&((a[31]&temp[31])|(~a[31]&~temp[31])))
        overflow=0;
        else overflow=1;
        //if(~overflow)
        r=temp[31:0];
        end
        func_and:begin
        temp[31:0]=a&b;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_or:begin
        temp[31:0]=a|b;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_xor:begin
        temp[31:0]=a^b;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_nor:begin
        temp[31:0]=~(a|b);
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_slt:begin
        temp[31:0]=(a[31]>b[31])?1:(a[31]==b[31])?((a[30:0]<b[30:0])?1:0):0;
        if(a-b==0)zero=1;
        else zero=0;
        if(a<b)negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_sltu: begin
        temp[31:0]=(a<b)?1:0;
        if(a-b==0)zero=1;
        else zero=0;
        if(a<b)carry=1;
        else carry=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        func_sll:begin
        temp[31:0]=b<<a;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        carry=b[32-a];
        negative=temp[31];
        r=temp[31:0];
        end
        func_srl:begin
        temp[31:0]=b>>a;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        carry=b[a-1];
        negative=temp[31];
        r=temp[31:0];
        end
        func_sra:begin
        temp0=b;
        temp[31:0]=temp0>>>a;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        carry=b[a-1];
        negative=temp[31];
        r=temp[31:0];
        end
        func_sllv:begin
        temp[31:0]=b<<a;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        carry=b[32-a];
        negative=temp[31];
        r=temp[31:0];
        end
        func_srlv:begin
        temp[31:0]=b>>a;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        carry=b[a-1];
        negative=temp[31];
        r=temp[31:0];
        end
        func_srav:begin
        temp0=b;
        temp[31:0]=temp0>>>a;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        carry=b[a-1];
        negative=temp[31];
        r=temp[31:0];
        end
        func_jr:begin
        end
        op_addi:begin
        temp={a[31],a}+{b[31],b};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
        overflow=0;
        else overflow=1;
        //if(~overflow)
        r=temp[31:0];
        end
        op_addiu:begin
        temp={1'b0,a}+{1'b0,b};
            if(temp[31:0]==32'd0)zero=1;
            else zero=0;
            if(temp[32]==1)carry=1;
            else carry=0;
            if(temp[31]==1)negative=1;
            else negative=0;
            r=temp[31:0];
        end
        op_andi:begin
        temp[31:0]=a&b;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        op_ori:begin
        temp[31:0]=a|b;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        op_xori:begin
        temp[31:0]=a^b;
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        op_lui:begin
        temp[31:0]={b[15:0],16'b0};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        op_lw:begin
        temp={a[31],a}+{b[31],b};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
        //overflow=0;
        //else overflow=1;
        r=temp[31:0];
        end
        op_sw:begin
        temp={a[31],a}+{b[31],b};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
        //overflow=0;
        //else overflow=1;
        r=temp[31:0];
        end
        op_beq:begin
        zero=(a==b)?1:0;
        end
        op_bne:begin
        zero=(a==b)?1:0;
        end
        op_slti:begin
        temp[31:0]=(a[31]>b[31])?1:(a[31]==b[31])?((a[30:0]<b[30:0])?1:0):0;
        if(a-b==0)zero=1;
        else zero=0;
        if(a<b)negative=1;
        else negative=0;
        r=temp[31:0];
        end
        op_sltiu:begin
        temp[31:0]=(a<b)?1:0;
        if(a-b==0)zero=1;
        else zero=0;
        if(a<b)carry=1;
        else carry=0;
        if(temp[31])negative=1;
        else negative=0;
        r=temp[31:0];
        end
        op_j:begin
        end
        op_jal:begin
        r=b+32'd4;
        if(r==32'b0)zero=1;
        end
        op_bgez:begin
        if(a[31]==0||a==0)r=32'b1;
        else r=32'b0;
        end
        op_break:begin
        end
        op_div:begin
        end
        op_divu:begin
        end
        op_eret:begin
        end
        op_jalr:begin
        r=a;
        if(r==0)zero=1;
        else zero=0;
        end
        op_lb:begin
                temp={a[31],a}+{b[31],b};
                if(temp[31:0]==0)zero=1;
                else zero=0;
                if(temp[31])negative=1;
                else negative=0;
                //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
                //overflow=0;
                //else overflow=1;
                r=temp[31:0];
                end
        op_lbu:begin
                temp={a[31],a}+{b[31],b};
                if(temp[31:0]==0)zero=1;
                else zero=0;
                if(temp[31])negative=1;
                else negative=0;
                //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
                //overflow=0;
                //else overflow=1;
                r=temp[31:0];
                end
        op_lh:begin
                temp={a[31],a}+{b[31],b};
                if(temp[31:0]==0)zero=1;
                else zero=0;
                if(temp[31])negative=1;
                else negative=0;
                //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
                //overflow=0;
                //else overflow=1;
                r=temp[31:0];
                end
        op_lhu:begin
                temp={a[31],a}+{b[31],b};
                if(temp[31:0]==0)zero=1;
                else zero=0;
                if(temp[31])negative=1;
                else negative=0;
                //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
                //overflow=0;
                //else overflow=1;
                r=temp[31:0];
                end
        op_mfc0:begin
        end
        op_mflo:begin
        end
        op_mtc0:begin
        end
        op_mthi:begin
        end
        op_mtlo:begin
        end
        op_mfhi:begin
        end
        op_mult:begin
        end
        op_multu:begin
        end
        op_sb:begin
        temp={a[31],a}+{b[31],b};
        if(temp[31:0]==0)zero=1;
        else zero=0;
        if(temp[31])negative=1;
        else negative=0;
        //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
        //overflow=0;
        //else overflow=1;
        r=temp[31:0];
        end
       op_sh:begin
         temp={a[31],a}+{b[31],b};
         if(temp[31:0]==0)zero=1;
         else zero=0;
         if(temp[31])negative=1;
         else negative=0;
         //if(((a[31]&b[31])|(~a[31]&~b[31]))&&((a[31]&temp[31])|(~a[31]&~temp[31])))
         //overflow=0;
         //else overflow=1;
         r=temp[31:0];
         end
         op_syscall:begin
         end
         op_clz:begin
          r=a[31]?0:a[30]?1:a[29]?2:a[28]?3:a[27]?4:a[26]?5:a[25]?6:a[24]?7:a[23]?8:a[22]?9:a[21]?10:a[20]?11:a[19]?12:a[18]?
         13:a[17]?14:a[16]?15:a[15]?16:a[14]?17:a[13]?18:a[12]?19:a[11]?20:a[10]?21:a[9]?22:a[8]?23:a[7]?24:a[6]?25:a[5]?26:a[4]?27:a[3]?28:a[2]?29:a[1]?30:a[0]?31:32;
          if(r==0)zero=1;
          else zero=0;
          negative=0;
          carry=0;
         end
         op_teq:begin
         if(a-b==0)r=32'b1;
         else r=32'b0;
         end
    endcase
    end
endmodule
