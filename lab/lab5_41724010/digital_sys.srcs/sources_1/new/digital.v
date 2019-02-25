`timescale 1ns / 1ps
module digital(
    input clk100mhz,
    input rst,
    input data_in,
    output reg[3:0]pos,
    output reg[7:0]seg,
    output reg data_en//result数据有效信号，高电平有效。
    //output reg [3:0]a,
    //output reg [3:0]b
    );
    reg clk4;//clk的4倍
    reg clk;
    reg clk190hz;
    reg [31:0]cnt;
    reg [2:0]state;
    reg finish;
    reg [3:0]b;
    reg [3:0]a;
    reg [6:0]count;
    reg [7:0]p;
    reg [7:0]pv;
    reg [7:0]ap;
    reg [3:0]dataP;
    reg [1:0]posC;
    parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
    initial begin
        cnt=32'd0;
        clk4=0;
        state=3'b000;
        finish=0;
        b=4'b0000;a=4'b0000;
        count=7'd0;posC=2'd0;dataP=4'd0;pv=8'd0;ap=8'd0;p=8'd0;pos=4'd0;
    end
    always@(posedge clk100mhz)begin
        cnt<=cnt+1'b1;
        clk4=cnt[28];
        clk190hz=cnt[17];
        clk=cnt[26];
    end
    always@(posedge clk)begin
        case(state)
            s0:if(data_in)state<=s1;
               else state<=s0;
            s1:if(data_in==0)state<=s2;
               else state<=s1;
            s2:if(data_in)state<=s3;
               else state<=s0;
            s3:if(data_in==0)state<=s4;
               else state<=s1;
            s4:if(finish)state<=s0;
               else state<=s4;
            default:state<=s0;
        endcase
    end
    always@(posedge clk)begin
        if(state==s4)begin
            if(count==8'd0)begin
                
                b[3]<=data_in;
                count<=count+1'b1;
            end
            else if(count==8'd1)begin
                b[2]<=data_in;
                count<=count+1'b1;
            end
            else if(count==8'd2)begin
                b[1]<=data_in;
                count<=count+1'b1;
            end
            else if(count==8'd3)begin
                b[0]<=data_in;
                count<=count+1'b1;
            end
            else if(count%8'd4==0)begin
                a[3]<=data_in;
                count<=count+1'b1;
            end
            else if(count%8'd4==1)begin
                a[2]<=data_in;
                count<=count+1'b1;
            end
            else if(count%8'd4==2)begin
                a[1]<=data_in;
                count<=count+1'b1;
            end
            else if(count%8'd4==3&&count!=8'd71)begin
                a[0]<=data_in;
                count<=count+1'b1;
            end
            else if(count==8'd71)begin
                a[0]<=data_in;
                finish<=1'b1;
                count<=8'd0;
            end
        end
        else begin
            a<=4'd0;b<=4'd0;finish<=1'b0;
            
        end
    end
    always@(posedge clk100mhz)begin
        if(p==a*b)data_en<=1'b1;
        else data_en<=1'b0;
    end
    always@(posedge clk)begin
            pv<=8'b00000000;
            ap<={4'b0000,a};
            //data_en=0;
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
            //if(p==pv)data_en=1'b1;
            //else data_en=1'b0; 
    end
    always@(dataP)
              case(dataP)
                0:seg=8'b0011_1111;
                1:seg=8'b0000_0110;
                2:seg=8'b0101_1011;
                3:seg=8'b0100_1111;
                4:seg=8'b0110_0110;
                5:seg=8'b0110_1101;
                6:seg=8'b0111_1101;
                7:seg=8'b0000_0111;
                8:seg=8'b0111_1111;
                9:seg=8'b0110_1111;
                10:seg=8'b0111_0111;
                11:seg=8'b0111_1100;
                12:seg=8'b0011_1001;
                13:seg=8'b0101_1110;
                14:seg=8'b0111_1001;
                15:seg=8'b0111_0001;
                default:seg = 8'b0000_1000;
              endcase
        always @(posedge clk190hz)
                    begin
                    case(posC)
                     0: begin
                        pos<=4'b0001;
                        dataP<=p[3:0];
                        end
                     1: begin
                        pos<=4'b0010;
                        dataP<=p[7:4];
                        end
                     2: begin
                        pos<=4'b0100;
                        dataP<=b;
                        end
                     3: begin
                        pos<=4'b1000;
                        dataP<=a;
                        end
                      endcase
                      posC = posC+1;
                      end
    endmodule
