`timescale 1ns / 1ps
module mux_C_tb;
reg a,b,c,d;
reg s1,s2;
wire out;
initial begin
    a=0;b=0;c=0;d=0;s1=0;s2=0;
end
always
fork
    #100a=1;#200a=0;
    #150b=1;#100b=0;
    #50c=1;#100c=0;
    #300d=1;#200d=0;
    #50s1=0;#100s1=1;
    #100s2=1;#200s2=0;
join
mux_C m1(.a(a),.b(b),.c(c),.d(d),.s1(s1),.s2(s2),.out(out));
endmodule
