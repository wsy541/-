`timescale 1ns / 1ps
module mux_1(out,sel,a,b);
output out;
input sel,a,b;
wire out;
wire _sel,a1,a2;
    not(_sel,sel);
    and(a1,a,_sel);
    and(a2,b,sel);
    or(out,a1,a2);

endmodule
