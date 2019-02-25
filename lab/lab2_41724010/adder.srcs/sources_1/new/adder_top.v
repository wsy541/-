`timescale 1ns / 1ps
module adder_top(
    input wire [7:0]a,
    input wire [7:0]b,
    input wire cin,
    output wire [7:0] s0,s1,s2,
    output wire cout0,cout1,cout2
    );
adder_cla_8 A1(a,b,cin,s0,cout0);//³¬Ç°
adder_ac_8 A2(a,b,cin,s1,cout1);//ÖğÎ»
adder_cs_8 A3(a,b,cin,s2,cout2);//Ñ¡Ôñ
endmodule
