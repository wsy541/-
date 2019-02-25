`timescale 1ns / 1ps
//Ñ¡Ôñ
module adder_cs_8(
    input [7:0] a,
    input [7:0] b,
    input cin,
    output reg [7:0] sum,
    output reg cout
    );
reg [6:0]co;
wire s0;
wire co0;
wire[1:0]co1;wire[1:0]s1;
wire[1:0]co2;wire[1:0]s2;
wire[1:0]co3;wire[1:0]s3;
wire[1:0]co4;wire[1:0]s4;
wire[1:0]co5;wire[1:0]s5;
wire[1:0]co6;wire[1:0]s6;
wire[1:0]co7;wire[1:0]s7;
adder_1 ad1(a[0],b[0],cin,s0,co0);
adder_1 ad20(a[1],b[1],0,s1[0],co1[0]);
adder_1 ad30(a[2],b[2],0,s2[0],co2[0]);
adder_1 ad40(a[3],b[3],0,s3[0],co3[0]);
adder_1 ad50(a[4],b[4],0,s4[0],co4[0]);
adder_1 ad60(a[5],b[5],0,s5[0],co5[0]);
adder_1 ad70(a[6],b[6],0,s6[0],co6[0]);
adder_1 ad80(a[7],b[7],0,s7[0],co7[0]);
adder_1 ad21(a[1],b[1],1,s1[1],co1[1]);
adder_1 ad31(a[2],b[2],1,s2[1],co2[1]);
adder_1 ad41(a[3],b[3],1,s3[1],co3[1]);
adder_1 ad51(a[4],b[4],1,s4[1],co4[1]);
adder_1 ad61(a[5],b[5],1,s5[1],co5[1]);
adder_1 ad71(a[6],b[6],1,s6[1],co6[1]);
adder_1 ad81(a[7],b[7],1,s7[1],co7[1]);
always@(*)
begin
sum[0]=s0;
if(co0==0) 
begin
sum[1]=s1[0];co[0]=co1[0];
end
else 
begin
sum[1]=s1[1];co[0]=co1[1];
end
if(co[0]==0) 
begin
sum[2]=s2[0];co[1]=co2[0];
end
else 
begin
sum[2]=s2[1];co[1]=co2[1];
end
if(co[1]==0) 
begin
sum[3]=s3[0];co[2]=co3[0];
end
else 
begin
sum[3]=s3[1];co[2]=co3[1];
end
if(co[2]==0) 
begin
sum[4]=s4[0];co[3]=co4[0];
end
else 
begin
sum[4]=s4[1];co[3]=co4[1];
end
if(co[3]==0) 
begin
sum[5]=s5[0];co[4]=co5[0];
end
else 
begin
sum[5]=s5[1];co[4]=co5[1];
end
if(co[4]==0) 
begin
sum[6]=s6[0];co[5]=co6[0];
end
else 
begin
sum[6]=s6[1];co[5]=co6[1];
end
if(co[5]==0) 
begin
sum[7]=s7[0];co[6]=co7[0];
end
else 
begin
sum[7]=s7[1];co[6]=co7[1];
end
cout=co[6];
end
endmodule
