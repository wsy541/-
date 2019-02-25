`timescale 1ns / 1ps
module top_tb(
    
    );
    reg r3,r2,r1,r0;
    reg a3,a2,a1,a0;
    reg b3,b2,b1,b0;
    reg clk;
    reg rst;
    wire [3:0]pos;
    wire [7:0]seg;
    wire data_en;
     wire [7:0]count;
     wire [3:0]xulie;
     wire [3:0]a;
     wire data_in;
     wire [3:0]ar;
     wire [3:0]br;
    always #5 clk=~clk;
    initial begin
        rst=0;r3=1;r2=0;r1=1;r0=0;b3=0;b2=0;b1=0;b0=1;a3=0;a2=0;a1=0;a0=1;clk=0;
    end
    top top(r3,r2,r1,r0,a3,a2,a1,a0,b3,b2,b1,b0,clk,rst,pos,seg,data_en,count,xulie,a,data_in,ar,br);
endmodule
