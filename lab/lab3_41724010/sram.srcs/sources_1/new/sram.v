`timescale 1ns / 1ps
module sram(
    input clk100mhz,clt,rst,//10ns时钟周期
    inout [15:0]dataBus,//16位读写数据总线
    input [31:0]number,
    //output reg  [31:0]data,
    output reg [18:0]addrBus,
    output reg ce,ub,lb,
    output reg w,oe
    );
    reg [15:0]tDataBus;
    reg [15:0]dataRead;
    reg ctl_a;
    reg count;
    reg [19:0]cnt;
    wire [18:0]adderin;
    assign adderin=19'd100_000;
    //assign data={data[15:0],dataRead};
    //always@(posedge clk100mhz )
    //begin
   // if(clt)begin
    //data[31:16]<=data[15:0];
   // data[15:0]<=dataRead;
   // end
   // end
    
    always@(posedge clk100mhz or posedge rst)
            begin
            if(rst) cnt<=20'd0;//异步复位
            else cnt<=cnt+1'b1;
            end
    always@(posedge clk100mhz or posedge rst)
    begin
        if(rst)count<=0;
        else if(cnt==20'hffff)count<=count+1'b1;
    end
    assign dataBus=w?16'hzzzz:tDataBus;//inout输入高阻，控制输入输出
    //assign ce=0;assign ub=0;assign lb=0;
    //always@(posedge clk100mhz or posedge clt)begin
    //if(clt)begin
      //  w<=1'b0;
        //oe<=1'b1;
      //  tDataBus<=number[15:0];
      //  addrBus<=19'd100_000;
    //end
    //else begin
      //  w<=1'b1;
        //oe<=1'b0;
    //end
    //end
    always@(posedge clk100mhz or posedge rst)
    begin
        if(rst)begin
            w<=1'b1;
            oe<=1'b1;
            ce<=1'b1;
            ub<=1'b1;
            lb<=1'b1;
            addrBus<=19'd100_000;
        end
        else if(clt)begin//写状态
            w<=1'b0;
            oe<=1'b1;
            ce<=1'b0;
            ub<=1'b0;
            lb<=1'b0;
            if(!count)begin
                tDataBus<=number[15:0];
                addrBus<=adderin;
                
            end
            else if(count)begin
                tDataBus<=number[31:16];
                addrBus<=adderin;  
                 
            end
        end
        else begin//读状态
            w<=1'b1;
            oe<=1'b0;
            ce<=1'b0;
            ub<=1'b0;
            lb<=1'b0;
            if(!count)addrBus<=adderin;
            else if(count)addrBus<=adderin;
        end
    end
    always@(posedge clk100mhz or posedge rst)
    if(rst) dataRead<=0;
    else if(ctl_a)dataRead<=dataBus;
    always@(posedge clk100mhz or posedge rst)
    if(rst)ctl_a<=0;
    else if(ctl_a)ctl_a<=0;
    else if(!clt)ctl_a<=1;
endmodule
