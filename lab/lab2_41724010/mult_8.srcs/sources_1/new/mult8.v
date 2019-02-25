`timescale 1ns / 1ps
module mult8(
    input [7:0] a,
    input [7:0] b,
    output reg [15:0] p
    );
    reg [15:0]pv;
    reg[15:0]ap;
    always@(*)
    begin
    pv=16'b0000000000000000;
    ap={8'b00000000,a};
    if(b[0]==1)
       pv=pv+ap;
    ap={ap[14:0],1'b0};
    if(b[1]==1)
        pv=pv+ap;
    ap={ap[14:0],1'b0};
    if(b[2]==1)
        pv=pv+ap;
    ap={ap[14:0],1'b0};
    if(b[3]==1)
        pv=pv+ap;
    ap={ap[14:0],1'b0};
    if(b[4]==1)
        pv=pv+ap;
    ap={ap[14:0],1'b0};
    if(b[5]==1)
        pv=pv+ap; 
    ap={ap[14:0],1'b0};
    if(b[6]==1)
        pv=pv+ap;
     ap={ap[14:0],1'b0};
    if(b[7]==1)
        pv=pv+ap;
    ap={ap[14:0],1'b0};
    p=pv;
    end
endmodule
