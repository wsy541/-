`timescale 1ns / 1ps
module alu_tb;
reg [3:0]a;
reg [3:0]b;
reg [2:0]s;
wire[7:0]f;
initial begin
    a=4'b0111;
    b=4'b0011;
    s=3'b000;
    #20s=3'b001;
    #20s=3'b010;
    #20s=3'b011;
    #20s=3'b100;
    #20s=3'b101;
    #20s=3'b110;
    #20s=3'b111;
end
alu alu(s,a,b,f);
endmodule
