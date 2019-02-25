`timescale 1ns / 1ps
module top(
    input r3,
    input r2,
    input r1,
    input r0,
    input a3,
    input a2,
    input a1,
    input a0,
    input b3,
    input b2,
    input b1,
    input b0,
    input clk,
    input rst,
    output [3:0]pos,
    output [7:0]seg,
    output  data_en
     //output [7:0]count,
     //output [3:0]xulie,
     //output [3:0]a,
     //output data_in,
     //output [3:0]ar,
     //output [3:0]br
    );
    wire data_in;
     
    din din(r3,r2,r1,r0,a3,a2,a1,a0,b3,b2,b1,b0,clk,rst,data_in);
    digital digital(clk,rst,data_in,pos,seg,data_en);
endmodule
