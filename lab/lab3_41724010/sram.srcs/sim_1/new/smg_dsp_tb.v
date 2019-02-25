`timescale 1ns / 1ps
module smg_dsp_tb(

    );
reg clk100mhz;
reg  clr;//清零,低电平有效
reg key3;//左移
reg  key4;//加数
reg key0;//右移
reg  key1;//减数
reg key2;//确认最终数
wire [3:0]pos;
wire  [7:0]seg;
reg [31:0]number;
reg [19:0]cnt;
initial begin
clk100mhz=0;clr=1;key3=0;key4=0;key0=0;key1=0;key2=0;cnt=20'd0;
end

always@(posedge clk100mhz )
        begin
        
        cnt<=cnt+1'b1;
        end
always@(posedge clk100mhz )

       if(cnt==20'hffff)begin
       key2=~key2;
       //key2=1;;//2^20/100mhz=10ms
        end

always #5 clk100mhz=~clk100mhz;
smg_dsp smg_dsp(clk100mhz,clr,key3,key4,key0,key1,key2,pos,seg,number);
endmodule