`timescale 1ns / 1ps
module top_tb();

reg clk100mhz;
reg clr;
reg rst;
wire [15:0]dataBus;
reg key0;
reg key1;
reg key3;
reg key2;
reg key4;
wire [3:0]po;
wire [7:0]se;
wire [3:0]pos;//前面
wire [7:0]seg;//前面
wire [18:0]addrBus;
wire ce,ub,lb,w,oe;
initial begin
clk100mhz=0;clr=1;rst=1;key3=0;key4=0;key0=0;key1=0;key2=0;
#8000;
#1000key3=0;
#3000 key3=1;
#1000 key3=0;
#8000;
#1000 key2=0;
#3000 key2=1;
#1000 key2=0;clr=0;
#8000 clr=1;
end
always#5clk100mhz=~clk100mhz;
top top(clk100mhz,clr,rst,dataBus,key0,key1,key3,key2,key4,po,se,pos,seg,addrBus,ce,ub,lb,w,oe);
//wire clk190hz,clk3hz,clk5hz;
//wire [15:0]dataBus1;
//wire [31:0]number;
//clkdiv_tb U1(clk100mhz,clk190hz,clk3hz);
//smg_dsp_tb U2(clk100mhz,clr,key3,key4,key0,key1,key2,pos,seg,number);
//sram_tb U5(clk100mhz,clr,rst,dataBus,number,addrBus,ce,ub,lb, w,oe);
//GPU_tb U3(clk3hz,clr,dataBus,dataBus1);
//segMsg_tb U4(clk190hz,dataBus1,po,se);
endmodule