`timescale 1ns / 1ps
module clkdiv_tb(

    );
    reg clk;
    wire clk190;
    wire clk3hz;
    initial begin
    clk=0;
    end
    always#5 clk=~clk;
    clkDiv clkDiv(clk,clk190,clk3hz);
endmodule
