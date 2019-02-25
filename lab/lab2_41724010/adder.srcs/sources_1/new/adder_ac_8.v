`timescale 1ns / 1ps
//ÖğÎ»
module adder_ac_8(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output [7:0] sum,
    output cout
    );
    wire [6:0]co;
adder_1 a1(a[0],b[0],cin,sum[0],co[0]);
adder_1 a2(a[1],b[1],co[0],sum[1],co[1]);
adder_1 a3(a[2],b[2],co[1],sum[2],co[2]);
adder_1 a4(a[3],b[3],co[2],sum[3],co[3]);
adder_1 a5(a[4],b[4],co[3],sum[4],co[4]);
adder_1 a6(a[5],b[5],co[4],sum[5],co[5]);
adder_1 a7(a[6],b[6],co[5],sum[6],co[6]);
adder_1 a8(a[7],b[7],co[6],sum[7],cout);
endmodule
