`timescale 1ns / 1ps
module mux_if(W,S,f );
input[3:0]W;
input[1:0]S;
output reg f;
always@(W,S)
    if(S==2'b00)
        f=W[0];
    else if(S==2'b01)
        f=W[1];
    else if(S==2'b10)
        f=W[2];
    else if(S==2'b11)
        f=W[3];
endmodule