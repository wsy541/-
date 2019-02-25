`timescale 1ns / 1ps
module mux_if_tb;
reg [3:0]W;
reg[1:0]S;
wire f;
initial begin
W=4'b0011;
S=2'b00;
#20S=2'b01;
#20S=2'b10;
#20S=2'b11;
#20W=4'b1010;S=2'b00;
#20S=2'b01;
#20S=2'b10;
#20S=2'b11;
end;
mux_if mux_if(.W(W),.S(S),.f(f));
endmodule
