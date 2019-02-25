`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/02 16:07:57
// Design Name: 
// Module Name: mult4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mult4(
    input [3:0] a,
    input [3:0] b,
    output reg [7:0] p
    );
    reg[7:0]pv;
    reg[7:0]ap;
    always@(*)
        begin
        pv=8'b00000000;
        ap={4'b0000,a};
        if(b[0]==1)
            pv=pv+ap;
        ap={ap[6:0],1'b0};
        if(b[1]==1)
            pv=pv+ap;
        ap={ap[6:0],1'b0};
        if(b[2]==1)
            pv=pv+ap;
        ap={ap[6:0],1'b0};
        if(b[3]==1)
            pv=pv+ap;
        ap={ap[6:0],1'b0};
        p=pv;
        end;
endmodule
