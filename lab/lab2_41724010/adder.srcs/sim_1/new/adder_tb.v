`timescale 1ns / 1ps
module adder_tb(

    );
reg [7:0]a;
reg [7:0]b;
reg cin;
reg clk;
wire [7:0]s0,s1,s2;
wire cout0,cout1,cout2;
initial
begin
a=0;b=0;cin=0;clk=0;
end
always
#10 clk=~clk;
always@(posedge clk)
begin
a={$random}%256;
b={$random}%256;
cin={$random}%2;
end
adder_top A(a,b,cin,s0,s1,s2,cout0,cout1,cout2);
endmodule
