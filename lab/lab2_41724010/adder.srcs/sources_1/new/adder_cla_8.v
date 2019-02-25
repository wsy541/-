`timescale 1ns / 1ps
//³¬Ç°
module adder_cla_8(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output  [7:0] sum,
    output  cout
    );
    wire co;
adder_4 a1(a[3:0],b[3:0],cin,sum[3:0],co);
adder_4 a2(a[7:4],b[7:4],co,sum[7:4],cout);
endmodule
