`timescale 1ns / 1ps
module clkDiv(
input clk100mhz,//100Mhz��ʱ��Ƶ����FPGA��ϵͳʱ��
output clk190hz,
output clk3hz
    );
reg [25:0]count=0;
assign clk190hz=count[18];
assign clk3hz=count[25];
always@(posedge clk100mhz)
count<=count+1;
endmodule