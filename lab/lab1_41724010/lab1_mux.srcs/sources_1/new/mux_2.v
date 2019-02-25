`timescale 1ns / 1ps
module mux_2(
input a,
input b,
input sel,
output out);
assign out=(a&~sel)|(b&sel);
endmodule
