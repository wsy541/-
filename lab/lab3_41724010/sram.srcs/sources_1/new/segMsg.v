`timescale 1ns / 1ps
module segMsg(
input clk190hz,
input [15:0]dataBus,
output reg [3:0]po,
output reg [7:0]se
    );
    reg [1:0]posC;
    reg [3:0]dataP;
    initial posC=2'b00;
always@(posedge clk190hz)
begin
case(posC)
    0:begin
        po<=4'b0001;
        dataP<=dataBus[3:0];
    end
    1:begin
        po<=4'b0010;
        dataP<=dataBus[7:4];
    end
    2:begin
        po<=4'b0100;
        dataP<=dataBus[11:8];
    end
    3:begin
        po<=4'b1000;
        dataP<=dataBus[15:12];
    end
endcase
posC=posC+1;    
end
always@(*)
case(dataP)
0:se=8'b0011_1111;
1:se=8'b0000_0110;
2:se=8'b0101_1011;
3:se=8'b0100_1111;
4:se=8'b0110_0110;
5:se=8'b0110_1101;
6:se=8'b0111_1101;
7:se=8'b0000_0111;
8:se=8'b0111_1111;
9:se=8'b0110_1111;
10:se=8'b0100_0000;
11:se=8'b0000_0000;
default:se=8'b0000_1000;
endcase
endmodule