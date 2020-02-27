`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/28 17:29:53
// Design Name: 
// Module Name: CP0
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


module CP0(
input clk,
input rst,
input mfc0, // CPU instruction is Mfc0
input mtc0, // CPU instruction is Mtc0
input [31:0]pc,
input [4:0] addr,  // Specifies Cp0 register [15:11]
input [31:0] data, // Data from GP register to replace CP0 register
input exception,   // eret/syscal/teq/break
input eret, 	   // Instruction is ERET (Exception Return)
input [4:0] cause,
output [31:0] rdata,   // Data from CP0 register for GP register
output reg [31:0] exc_addr // Address for PC at the beginning of an exception
);
    reg [31:0]register[0:31];
    parameter reg_status=5'd12,
                          reg_cause=5'd13,
                          reg_epc=5'd14;
    parameter Syscall=5'b01000,
                          Break=5'b01001,
                          Teq=5'b01101;
    always@(negedge clk or posedge rst)begin
    if(rst)begin
        register[reg_status]<=32'h0000000f;
        register[reg_cause]<=32'd0;
        register[reg_epc]<=32'd0;
        exc_addr<=32'd0;
    end
    else if(mtc0)register[addr]<=data;
    else if(exception)begin
                if(eret)begin
                register[reg_status]<=register[reg_status]>>5;
                exc_addr<=register[reg_epc];
                end
                else begin
                case(cause)
                Syscall:begin
                    if(register[reg_status][1]==1'b1)begin
                    exc_addr<=32'h4;
                    register[reg_status]<=register[reg_status]<<5;
                    register[reg_epc]<=pc;
                    register[reg_cause][6:2]<=Syscall;
                    end
                    else
                    exc_addr<=pc+4;
                    end
                Break:begin
                        if(register[reg_status][2]==1'b1)begin
                        exc_addr<=32'h4;
                        register[reg_status]<=register[reg_status]<<5;
                        register[reg_epc]<=pc;
                        register[reg_cause][6:2]<=Break;
                        end
                        else
                        exc_addr<=pc+4;
                        end
                Teq:begin
                                if(register[reg_status][3]==1'b1)begin
                                exc_addr<=32'h4;
                                register[reg_status]<=register[reg_status]<<5;
                                register[reg_epc]<=pc;
                                register[reg_cause][6:2]<=Teq;
                                end
                                else
                                exc_addr<=pc+4;
                        end
                    default:begin
                    end
                    endcase
                    end//58
    end//53
    end//45
assign  rdata=(mfc0)?register[addr]:0;
assign status=register[reg_status];
endmodule
