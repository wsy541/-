`timescale 1ns / 1ps
module mult_tb(

    );
reg [3:0]a;
reg[3:0]b;
wire[7:0]p;
initial begin
a=0;b=0;
repeat(10)
begin
#10 a={$random}%16;
b={$random}%16;
end;
#10 $stop;
end;
mult4 mult4(.a(a),.b(b),.p(p));
endmodule
