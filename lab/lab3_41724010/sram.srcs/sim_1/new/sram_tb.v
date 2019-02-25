`timescale 1ns / 1ps
module sram_tb(

    );
reg clk100mhz,clt,rst;//10ns时钟周期
wire[15:0]dataBus;//16位读写数据总线
reg [31:0]number;
       //output reg  [31:0]data,
wire [18:0]addrBus;
wire ce,ub,lb;
wire  w,oe;
initial begin
clk100mhz=0;clt=1;rst=1;number=32'h41724010;
#100rst=0;clt=0;
#100rst=0;clt=1;
end
always #5 clk100mhz=~clk100mhz;
sram sram(clk100mhz,clt,rst,dataBus,number,addrBus,ce,ub,lb,w,oe);
endmodule
