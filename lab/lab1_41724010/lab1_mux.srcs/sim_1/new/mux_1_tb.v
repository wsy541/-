`timescale 1ns / 1ps
module mux_1_tb;
reg a,b,sel;
mux_1 mux(out,sel,a,b);
initial begin
    a=0;b=1;sel=0;
    #5b=0;#5sel=1;b=1;
    #5a=1;
    #5$finish;
end
initial
$monitor($time,"out=%b ,sel=%b ,a=%b ,b=%b",out,sel,a,b);
endmodule
