`timescale 1ns / 1ps
module mul8_tb(

    );
reg[7:0]a;
reg[7:0]b;
wire[15:0]p;
initial
begin
a=0;b=0;
repeat(10)
begin
#10 a={$random}%256;
b={$random}%256;
end 
#10 $stop;
end
mult8 mult8(.a(a),.b(b),.p(p));
endmodule
