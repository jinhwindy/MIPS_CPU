`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/18 09:57:41
// Design Name: 
// Module Name: DMEM
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


module DMEM(
input clk,
input [2:0]mode,
input [31:0]address,
input CS,DM_W,DM_R,
input [31:0]idata,
output reg[31:0]odata
    );
    /*
    000     w
    001      lh sh
    010      lhu
    011     lb  sb
    100     lbu
    */
    reg [31:0]memory[0:511];
    wire [31:0]Address;
    assign Address=(address-32'h10010000)>>2;
    always@(negedge clk) begin
        if(CS&&DM_W)begin
        case(mode)
        3'b000:begin
        memory[Address]<=idata;
        end
        3'b001:begin
            case(address[1:0])
            2'b00:begin
            memory[Address][15:0]<=idata[15:0];
            end
            2'b10:begin
            memory[Address][31:16]<=idata[15:0];
            end
            default:begin
            end
            endcase
        end
        3'b011:begin
            case(address[1:0])
            2'b00:begin
            memory[Address][7:0]<=idata[7:0];
            end
            2'b01:begin
            memory[Address][15:8]<=idata[7:0];
            end
            2'b10:begin
            memory[Address][23:16]<=idata[7:0];
            end
            2'b11:begin
            memory[Address][31:24]<=idata[7:0];
            end
            endcase
        end
        endcase
        end
    end
    
      /*
    000     w
    001      lh sh
    010      lhu
    011     lb  sb
    100     lbu
    */
    always@(*)begin
     if(CS&&DM_R)begin
         case(mode)
         3'b000:begin
         odata<=memory[Address];
         end
         3'b001:begin
             case(address[1:0])
             2'b00:begin
             odata<={{16{memory[Address][15]}},memory[Address][15:0]};
             end
             2'b10:begin
             odata<={{16{memory[Address][31]}},memory[Address][31:24]};
             end
             endcase
         end
        3'b010:begin
                  case(address[1:0])
                  2'b00:begin
                  odata<={{16{1'b0}},memory[Address][15:0]};
                  end
                  2'b10:begin
                  odata<={{16{1'b0}},memory[Address][31:24]};
                  end
                  endcase
                  end
         3'b011:begin
             case(address[1:0])
             2'b00:begin
             odata<={{24{memory[Address][7]}},memory[Address][7:0]};
             end
             2'b01:begin
             odata<={{24{memory[Address][15]}},memory[Address][15:8]};
             end
             2'b10:begin
             odata<={{24{memory[Address][23]}},memory[Address][23:16]};
             end
             2'b11:begin
             odata<={{24{memory[Address][31]}},memory[Address][31:24]};
             end
             endcase
          end
          3'b100:begin
                 case(address[1:0])
                 2'b00:begin
                 odata<={{24{1'b0}},memory[Address][7:0]};
                 end
                 2'b01:begin
                 odata<={{24{1'b0}},memory[Address][15:8]};
                 end
                 2'b10:begin
                 odata<={{24{1'b0}},memory[Address][23:16]};
                 end
                 2'b11:begin
                 odata<={{24{1'b0}},memory[Address][31:24]};
                 end
                 endcase
         end
         endcase
     end
    end
    //assign odata=(CS&&DM_R)?memory[taddress]:0;
endmodule
