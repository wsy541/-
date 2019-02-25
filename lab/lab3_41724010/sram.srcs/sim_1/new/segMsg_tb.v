`timescale 1ns / 1ps
module segMsg_tb(

    );
reg clk190hz;
reg [15:0]dataBus;
wire [3:0]po;
wire [7:0]se;
initial begin
clk190hz=0;
dataBus=16'h4172;
end
always@(posedge clk190hz)
begin
    dataBus[15:12]<=dataBus[3:0];
    dataBus[11:0]<=dataBus[15:4];
end
always #5 clk190hz=~clk190hz;
segMsg segMsg(clk190hz,dataBus,po,se);
endmodule