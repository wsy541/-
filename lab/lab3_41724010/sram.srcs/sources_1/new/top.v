`timescale 1ns / 1ps
module top(
input clk100mhz,
input clr,
input rst,
inout [15:0]dataBus,
input key0,
input key1,
input key3,
input key2,
input key4,
output [3:0]po,
output [7:0]se,
output [3:0]pos,//前面
output [7:0]seg,//前面
output [18:0]addrBus,
output  ce,ub,lb,
output  w,oe
    );
wire clk190hz,clk3hz,clk5hz;
wire [15:0]dataBus1;
wire [31:0]number;
clkDiv U1(clk100mhz,clk190hz,clk3hz);
smg_dsp U2(clk100mhz,clr,key3,key4,key0,key1,key2,pos,seg,number);
sram U5(clk100mhz,clr,rst,dataBus,number,addrBus,ce,ub,lb, w,oe);
GPU U3(clk3hz,clr,dataBus,dataBus1);
segMsg U4(clk190hz,dataBus1,po,se);
endmodule