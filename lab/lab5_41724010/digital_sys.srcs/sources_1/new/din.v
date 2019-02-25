`timescale 1ns / 1ps
module din(
    input r3,
    input r2,
    input r1,
    input r0,
    input a3,
    input a2,
    input a1,
    input a0,
    input b3,
    input b2,
    input b1,
    input b0,
    input clk100mhz,
    input rst,
    output reg data_in
    //output  reg [7:0]count,
    //output   reg [3:0]xulie,
    //output   reg [3:0]a
    );
    reg [7:0]count;
    reg [3:0]xulie;
    reg [3:0]a;
    reg clk;
    reg [31:0]cnt;
    initial begin
        count=8'd0;
        xulie={r3,r2,r1,r0};
        a={a3,a2,a1,a0};
        cnt=32'd0;
    end
    always@(posedge clk100mhz)begin
        cnt<=cnt+1'b1;
        clk<=cnt[26];
    end
    always@(posedge clk)begin
        if(count==8'd0)begin
            xulie<={r3,r2,r1,r0};
            //a<={a3,a2,a1,a0};
        end
        else xulie<=xulie;
    end
    always@(posedge clk)begin
            if(rst)begin
                data_in<=1'b0;
            end
            else if(xulie==4'b1010)begin
                if(count==8'd0)begin
                    data_in<=r3;
                    count<=count+1'b1;
                     a<={a3,a2,a1,a0};
                end
                else if(count==8'd1)begin
                    data_in<=r2;
                    count<=count+1'b1;
                end
                else if(count==8'd2)begin
                    data_in<=r1;
                    count<=count+1'b1;
                end
                else if(count==8'd3)begin
                    data_in<=r0;
                    count<=count+1'b1;
                end
                else if(count==8'd4)begin
                    data_in<=b3;
                    count<=count+1'b1;
                end
                else if(count==8'd5)begin
                    data_in<=b2;
                    count<=count+1'b1;
                end
                else if(count==8'd6)begin
                    data_in<=b1;
                    count<=count+1'b1;
                end
                else if(count==8'd7)begin
                    data_in<=b0;
                    count<=count+1'b1;
                end
                else if(count%8'd4==0)begin
                    data_in<=a[3];
                    count<=count+1'b1;
                end
                else if(count%8'd4==1)begin
                    data_in<=a[2];
                    count<=count+1'b1;
                end
                else if(count%8'd4==2)begin
                    data_in<=a[1];
                    count<=count+1'b1;
                end
                else if(count%8'd4==3&&count!=8'd71)begin
                    data_in<=a[0];
                    a<=a+1'b1;
                    count<=count+1'b1;
                end
                else if(count==8'd71)begin
                    data_in<=a[0];
                    count<=8'd0;
                    a<={a3,a2,a1,a0};
                end
            end
            else begin
                data_in<=r3;
            end
        end
        
        
        
endmodule
