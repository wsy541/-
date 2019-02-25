`timescale 1ns / 1ps
module clk_tb();
reg clk;
initial
clk<=0;
always
begin
#30 clk<=1;
#10 clk<=0;
end
endmodule

