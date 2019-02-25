`timescale 1ns / 1ps
module adder_1(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );
assign {cout,sum}=a+b+cin;
endmodule
