`timescale 1ns / 1ps
module alu(s,a,b,f);
input [2:0]s;
input [3:0]a,b;
output reg [7:0]f;
always@(*)
    case(s)
        0:f=4'b0000;
        1:f=a+b;
        2:f=a-b;
        3:f=b-a;
        4:f=a*b;
        5:f=a/b;
        6:f=a<<b;
        7:f=b<<a;
        default:f=4'b1111;
    endcase
endmodule
