`timescale 1ns / 1ps
module mux_case(W,S,f );
input[3:0]W;
input[1:0]S;
output reg f;
always@(W,S)
    case(S)
        0:f=W[0];
        1:f=W[1];
        2:f=W[2];
        default:f=W[3];
    endcase
endmodule
