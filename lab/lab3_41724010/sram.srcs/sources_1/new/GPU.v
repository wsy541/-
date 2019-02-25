`timescale 1ns / 1ps
module GPU(
input clk3hz,
input clr,
//input [31:0]data,
input [15:0]number,
output  [15:0]dataBus
    );
//移位寄存器
reg[31:0]msgArray;
//把移位寄存器的高16位传递给数码管显示模块（四个数码管，每个数码管显示四位数据）
assign dataBus=msgArray[31:16];
always@(posedge clk3hz or posedge clr )
    if(!clr)begin
       msgArray[31:16]<=msgArray[15:0];
       msgArray[15:0]<=number;
    end
   else begin 
        //msgArray<=msg;
        msgArray[3:0]<=msgArray[31:28]; 
        msgArray[31:4]<=msgArray[27:0];
    end
endmodule