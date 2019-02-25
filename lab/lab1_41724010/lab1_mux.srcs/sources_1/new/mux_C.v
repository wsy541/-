`timescale 1ns / 1ps
module mux_C(
input wire a,b,c,d,
input wire s1,s2,
output wire out );
wire out1,out2;
mux_1 mux_1(
.a(a),
.b(b),
.sel(s1),
.out(out1));
mux_1 mux_2(
.a(c),
.b(d),
.sel(s1),
.out(out2));
mux_1 mux_3(
.a(out1),
.b(out2),
.sel(s2),
.out(out));
endmodule
