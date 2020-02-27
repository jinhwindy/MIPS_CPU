`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/17 12:49:58
// Design Name: 
// Module Name: ControlUnit
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


module ControlUnit(
input [31:0]aludata,
input [31:0]instruction,
input [5:0]opcode,
input [5:0]func,
output RF_R,
output DM_R,
output RF_W,
output  DM_W,
output M1,M2,M3,M4,M5,M6,M7,
//output [4:0]ALUC,
output [5:0]ALUC,
output DM_CS,
////////////////////
output [1:0]muxfour,
output lor,low,hir,hiw,
output exception,eret,
output [4:0]cause,
output [2:0]mode
    );
    parameter func_add=6'b100000,
                          func_addu=6'b100001,
                          func_sub=6'b100010,
                          func_subu=6'b100011,
                          func_and=6'b100100,
                          func_or=6'b100101,
                          func_xor=6'b100110,
                          func_nor=6'b100111,
                          func_slt=6'b101010,
                          func_sltu=6'b101011,
                          func_sll=6'b000000,
                          func_srl=6'b000010,
                          func_sra=6'b000011,
                          func_sllv=6'b000100,
                          func_srlv=6'b000110,
                          func_srav=6'b000111,
                          func_jr=6'b001000,
                          /////////////////////////////////////////////////////////////////
                          func_clz=6'b100000,
                         func_divu=6'b011011,
                         func_eret=6'b011000,
                         func_jalr=6'b001001,
                         func_mfc0=5'b00000,
                         func_mfhi=6'b010000,
                         func_mflo=6'b010010,
                         func_mtc0=5'b00100,
                         func_mthi=6'b010001,
                         func_mtlo=6'b010011,
                         func_mul=6'b000010,
                         func_multu=6'b011001,
                         func_syscall=6'b001100,
                         func_teq=6'b110100,
                         func_break=6'b001101,
                         func_div=6'b011010;
                         
    parameter op_addi=6'b001000,
                          op_addiu=6'b001001,
                          op_andi=6'b001100,
                          op_ori=6'b001101,
                          op_xori=6'b001110,
                          op_lui=6'b001111,
                          op_lw=6'b100011,
                          op_sw=6'b101011,
                          op_beq=6'b000100,
                          op_bne=6'b000101,
                          op_slti=6'b001010,
                          op_sltiu=6'b001011,
                          op_j=6'b000010,
                          op_jal=6'b000011,
                          //////////////////////////////////////////////////////////////
                           op_bgez = 6'b000001,
                          op_eret = 6'b010000,//**
                          op_lb = 6'b100000,
                          op_lbu = 6'b100100,
                          op_lhu = 6'b100101,
                          op_lh = 6'b100001,
                          op_mfc0 = 6'b010000,//**
                          op_mtc0 = 6'b010000,//**
                          op_mul = 6'b011100,//**
                          op_sb = 6'b101000,
                          op_sh = 6'b101001,
                          op_clz = 6'b011100;//**    
    assign M3=(opcode==6'b000000)?(~(func==func_sll||func==func_sra||func==func_srl)):1;
    assign M4=(opcode==6'b000000)?(~(func==func_add||func==func_addu||func==func_sub||func==func_subu||func==func_and||func==func_or||func==func_xor||func==func_nor||func==func_slt||func==func_sltu||func==func_sll||func==func_srl||func==func_sra||func==func_sllv||func==func_srlv||func==func_srav||func==func_teq)):(~(opcode==op_beq||opcode==op_bne));
    assign M6=(opcode==op_jal)?1:0;
    /////////
    assign M7=(opcode==6'b000000)?(func==func_jr||func==func_jalr)?0:1:1;
    /////////
    assign ALUC[5]=(opcode==6'b000000)?(func == func_add || func == func_addu || func == func_sub || func == func_subu || func == func_and || func == func_or || func == func_xor || func == func_nor || func == func_slt || func == func_sltu || func == func_sll || func == func_srl || func == func_sra || func == func_sllv || func == func_srlv || func == func_srav || func == func_jr) ? 0 : 1 : (opcode == op_addi || opcode == op_addiu || opcode == op_andi || opcode == op_ori || opcode == op_xori || opcode == op_lui || opcode == op_lw || opcode == op_sw || opcode == op_beq || opcode == op_bne || opcode == op_slti || opcode == op_sltiu || opcode == op_j || opcode == op_jal || opcode == op_bgez) ? 0 : 1;
    assign ALUC[4]=(opcode==6'b000000)?(func==func_teq||func==func_jr||func==func_multu||func==func_syscall):(opcode==op_sb||opcode==op_sh||opcode==op_bgez||opcode==op_addi||opcode==op_addiu||opcode==op_andi||opcode==op_ori||opcode==op_xori||opcode==op_lui||opcode==op_lw||opcode==op_sw||opcode==op_beq||opcode==op_bne||opcode==op_slti||opcode==op_sltiu||opcode==op_j||opcode==op_jal)?1:(opcode==op_clz&&func==func_clz)?1:0;
    assign ALUC[3]=(opcode==6'b000000)?(func==func_jr||func==func_slt||func==func_sltu||func==func_sll||func==func_srl||func==func_sra||func==func_sllv||func==func_srlv||func==func_srav||func==func_mflo||func==func_mthi||func==func_mtlo||func==func_mfhi):(opcode==op_lhu||opcode==op_bgez||opcode==op_sw||opcode==op_beq||opcode==op_bne||opcode==op_slti||opcode==op_sltiu||opcode==op_j||opcode==op_jal)?1:((opcode==op_mfc0&&instruction[25:21]==func_mfc0)||(opcode==op_mtc0&&instruction[25:21]==func_mtc0)||(opcode==op_mul&&func==func_mul));
    assign ALUC[2]=(opcode==6'b000000)?(func==func_and||func==func_or||func==func_xor||func==func_nor||func==func_sra||func==func_sllv||func==func_srlv||func==func_srav||func==func_jalr||func==func_mthi||func==func_mtlo||func==func_mfhi||func==func_teq):(opcode==op_lb||opcode==op_lbu||opcode==op_lh||opcode==op_bgez||opcode==op_ori||opcode==op_xori||opcode==op_lui||opcode==op_lw|| opcode==op_sltiu||opcode==op_j||opcode==op_jal)?1:((opcode==op_mul&&func==func_mul)||(opcode==op_clz&&func==func_clz));
    assign ALUC[1]=(opcode==6'b000000)?(func==func_sub||func==func_subu||func==func_xor||func==func_nor||func==func_sll||func==func_srl||func==func_srlv||func==func_srav||func==func_divu||func==func_mflo||func==func_mfhi||func==func_syscall):(opcode==op_sh||opcode==op_lh||opcode==op_lbu||opcode==op_bgez||opcode==op_addiu||opcode==op_andi||opcode==op_lui||opcode==op_lw||opcode==op_bne||opcode==op_slti||opcode==op_jal)?1:((opcode==op_eret&&func==func_eret)||(opcode==op_mtc0&&instruction[25:21]==func_mtc0)||(opcode==op_mul&&func==func_mul));
    assign ALUC[0]=(opcode==6'b000000)?(func==func_addu||func==func_subu||func==func_or||func==func_nor||func==func_sltu||func==func_srl||func==func_sllv||func==func_srav||func==func_div||func==func_mtlo||func==func_syscall||func==func_teq):(opcode==op_sb||opcode==op_lh||opcode==op_lb||opcode==op_bgez||opcode==op_addi||opcode==op_andi||opcode==op_xori||opcode==op_lw||opcode==op_beq||opcode==op_slti||opcode==op_j)?1:((func==func_eret&&opcode==op_eret)||(opcode==op_mfc0&&instruction[25:21]==func_mfc0)||(opcode==op_mtc0&&instruction[25:21]==func_mtc0)||(opcode==op_mul&&func==func_mul));
    assign M2=(opcode==6'b000000)?(func!=func_jr):(opcode==op_lw||opcode==op_lb||opcode==op_lbu||opcode==op_lh||opcode==op_lhu)?0:1;
    assign RF_W=(opcode==6'b000000)?(func==func_jr||func==func_break||func==func_div||func==func_divu||func==func_mthi||func==func_mtlo||func==func_multu||func==func_syscall||func==func_teq)?0:1:(opcode==op_sb||opcode==op_sh||opcode==op_bgez||opcode==op_sw||opcode==op_beq||opcode==op_bne||opcode==op_j)?0:((opcode==op_eret&&func==func_eret)||(instruction[31:21]==11'b01000000100))?0:1;
    assign M5=0;
    assign M1=(opcode==op_j||opcode==op_jal)?0:1;
    assign DM_CS=(opcode==op_lw||opcode==op_sw||opcode==op_lb||opcode==op_lbu||opcode==op_lh||opcode==op_lhu||opcode==op_sb||opcode==op_sh)?1:0;
    assign DM_R=(opcode==op_lw||opcode==op_lb||opcode==op_lbu||opcode==op_lh||opcode==op_lhu)?1:0;
    assign DM_W=(opcode==op_sw||opcode==op_sb||opcode==op_sh)?1:0;
    //////////////////////////////////
    assign muxfour=(opcode==6'b0)?(func==func_div)?2'd2:(func==func_divu)?2'd3:(func==func_multu)?2'd1:0:0;
    assign low=((opcode==6'b0)&&(func==func_mtlo||func==func_multu||func==func_div||func==func_divu))?1:0;
    assign hiw=((opcode==6'b0)&&(func==func_mthi||func==func_multu||func==func_div||func==func_divu))?1:0;
    assign lor=(opcode==6'b0&&func==func_mflo)?1:0;
    assign hir=(opcode==6'b0&&func==func_mfhi)?1:0;
    assign exception=(opcode==6'd0&&(func==func_syscall||(func==func_teq&&aludata[0])||func==func_break))?1:(opcode==op_eret&&func==func_eret)?1:0;
    ///////////////////////////////////
    assign eret=(opcode==op_eret&&func==func_eret)?1:0;
    ///////////////////////////////////
    assign cause=(opcode==6'd0)?(func==func_syscall)?5'b01000:(func==func_break)?5'b01001:(func==func_teq)?5'b01101:0:0;
    assign mode=(opcode==op_lh||opcode==op_sh)?3'b001:(opcode==op_lhu)?3'b010:(opcode==op_lb||opcode==op_sb)?3'b011:(opcode==op_lbu)?3'b100:0;
endmodule
