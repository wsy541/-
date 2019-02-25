`timescale 1ns / 1ps
module GPU_tb(

    );
reg clk;
reg clr;
reg [15:0]number;
wire [15:0]dataBus;
initial begin
clk=0;clr=0;number=16'h4172;
#100clr=1;number=16'h4172;
#100clr=0;number=16'h4010;
#100clr=1;number=16'h4010;
end
always #5 clk=~clk;
GPU tb1(clk,clr,number,dataBus);
endmodule