`timescale 1ns / 1ps
module smg_dsp(
    input clk100mhz,
    input clr,//清零,低电平有效
    input key3,//左移
    input key4,//加数
    input key0,//右移
    input key1,//减数
    input key2,//确认最终数
    output reg [3:0]pos,
    output reg [7:0]seg,
    output reg[31:0]number
    );
    reg [2:0]count3;//判断按键key3被按下多少次
    reg [3:0]count4;//判断按键key4被按下多少次
    reg [19:0]cnt;//计数器，用于延时
    reg [4:0]low_sw;//延时前寄存器
    reg [4:0]low_sw_r;//延时后寄存器
    initial begin
    pos=4'b0001;
    seg=8'b0011_1111;
    end
    //initial count3=3'd0;
    //initial count4=4'd0;
   // initial cnt=20'd0;
    //initial low_sw=5'd0;
   // initial low_sw_r=5'd0;
    //reg [3:0]poc=4'b0000;//number中间值
    always@(posedge clk100mhz or negedge clr)
        begin
        if(!clr) cnt<=20'd0;//异步复位
        else cnt<=cnt+1'b1;
        end
    always@(posedge clk100mhz or negedge clr)
        begin
        if(!clr)low_sw<=5'd0;
        else if(cnt==20'hffff)low_sw<={key2,key3,key4,key0,key1};//2^20/100mhz=10ms
        end
    always@(posedge clk100mhz or negedge clr)
        begin
        if(!clr)low_sw_r<=5'd0;
        else low_sw_r<=low_sw;
        end
   wire [4:0]ctrl=low_sw[4:0]&(~low_sw_r[4:0]);
    always@(posedge clk100mhz or negedge clr)
        begin
        if(!clr)begin
            count3<=3'd0;
            count4<=4'd0;
            end
        else begin 
            if(ctrl[3])count3<=count3+1'b1;
            if(ctrl[2])count4<=count4+1'b1;
            if(ctrl[1])count3<=count3-1'b1;
            if(ctrl[0])count4<=count4-1'b1;
            end
        end
    always@(count3)
        case(count3)
            0:begin
                pos<=4'b0001;
                if(ctrl[4])number[3:0]<=count4;
              end
            1:begin
                pos<=4'b0010;
                if(ctrl[4])number[7:4]<=count4;
              end
            2:begin
                pos<=4'b0100;
                if(ctrl[4])number[11:8]<=count4;
              end
            3:begin
                pos<=4'b1000;
                if(ctrl[4])number[15:12]<=count4;
              end
            4:begin
                pos<=4'b0001;
                if(ctrl[4])number[19:16]<=count4;
              end
            5:begin
                pos<=4'b0010;
                if(ctrl[4])number[23:20]<=count4;
              end
            6:begin
                pos<=4'b0100;
                if(ctrl[4])number[27:24]<=count4;
              end
            default:
                begin
                pos<=4'b1000;
                if(ctrl[4])number[31:28]<=count4;
                end
            endcase
      always@(count4)
            case(count4)
            0:begin
            seg<=8'b0011_1111;
           
            end
            1:begin
            seg<=8'b0000_0110;
                         
            end
            2:begin
            seg<=8'b0101_1011;
                        
            end
            3:begin
            seg<=8'b0100_1111;
           
            end
            4:begin
            seg<=8'b0110_0110;
            
            end
            5:begin
            seg<=8'b0110_1101;
            
            end
            6:begin
            seg<=8'b0111_1101;
            
            end
            7:begin
            seg<=8'b0000_0111;
           
            end
            8:begin
            seg<=8'b0111_1111;
           
            end
            9:begin
            seg<=8'b0110_1111;
            
            end
            default:
            begin
            seg<=8'b0110_1111;                
            end
            endcase
endmodule