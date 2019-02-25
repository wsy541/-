`timescale 1ns / 1ps
//4Î»³¬Ç°
module adder_4(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output  [3:0] sum,
    output  cout
    );
   wire [2:0]co;
   assign co[0]=(a[0]&b[0])|((a[0]^b[0])&cin);
    assign co[1]=(a[1]&b[1])|((a[1]^b[1])&co[0]);
   assign  co[2]=(a[2]&b[2])|((a[2]^b[2])&co[1]);
    assign cout=(a[3]&b[3])|((a[3]^b[3])&co[2]);
    assign sum[0]=(a[0]^b[0])^cin;
    assign sum[1]=(a[1]^b[1])^co[0];
    assign sum[2]=(a[2]^b[2])^co[1];
    assign sum[3]=(a[3]^b[3])^co[2];
    
endmodule
