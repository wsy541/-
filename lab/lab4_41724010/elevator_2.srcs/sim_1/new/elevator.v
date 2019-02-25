`timescale 1ns / 1ps
module elevator(
    
    );
    reg clk;
    reg rst;
    reg weight;
    reg up1,up2,up3;
    reg down2,down3,down4;
    reg r1,r2,r3,r4;
    wire [7:0]seg;
    wire [3:0]pos;
    wire [10:0]led;
    //parameter period=2;
   initial begin
       clk=0;
       forever begin
           #0.001 clk=1;
           #0.001 clk=0;
       end
   end
    initial begin
        rst=1;
        forever begin
            #5 rst=0;
        end
    end
    initial begin
        up1=1;up2=1;up3=1;down2=1;down3=1;down4=1;r1=1;r2=1;r3=1;r4=1;weight=0;
        #540 up1=1;up2=1;up3=0;down2=1;down3=0;down4=0;r1=1;r2=1;r3=0;r4=0;weight=1;
    end
    elevator_2 elevator_2(clk,rst,weight,up1,up2,up3,down2,down3,down4,r1,r2,r3,r4,seg[7:0],pos[3:0],led[10:0]);
endmodule
