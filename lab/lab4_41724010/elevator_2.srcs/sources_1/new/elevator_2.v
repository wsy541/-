`timescale 1ns / 1ps
module elevator_2(
    input clk100mhz,
    input rst,
    input weight,
    input up1,up2,up3,
    input dn2,dn3,dn4,
    input r1,r2,r3,r4,
    output reg [7:0]seg,
    output reg [3:0]pos,
    output reg  [10:0]led
    );
    parameter idle_state = 3'b001;    //无命令状态
    parameter up_state = 3'b010; //上行状态
    parameter down_state=3'b011;//下行状态
    parameter open_state=3'b100;//开门状态
    parameter close_state=3'b101;//关门状态
    parameter f1=4'b0001;//一楼
    parameter f2=4'b0010;//二楼
    parameter f3=4'b0100;//三楼
    parameter f4=4'b1000;//四楼
    parameter up_f=2'b01;//上行
    parameter dn_f=2'b10;//下行
    parameter idle=2'b00;//不动
    reg [2:0]state;
    reg [3:0]next_state;
    reg [3:0]count;
    reg [31:0]cnt;
    reg clk1s;
    //reg clk4s;
    reg clk190hz;
    reg [1:0]direction;//1表示上行
    reg [3:0]floor;//1000=4层
    reg has_up_request;
    reg has_down_request;
    reg liftgoup;
    reg liftgodown;
    reg opendoor;
    reg up1_r,up2_r,up3_r;
    reg dn2_r,dn3_r,dn4_r;
    reg r1_r,r2_r,r3_r,r4_r;
    reg [2:0]f;
    reg [2:0]posC;
    reg [3:0]dataP;
    initial begin
    state=3'b000;
    count=0;cnt=0;direction=0;floor=3'b0001;has_up_request=0;has_down_request=0;liftgoup=1;liftgodown=0;opendoor=0;up1_r=0;up2_r=0;up3_r=0;dn2_r=0;dn3_r=0;dn4_r=0;r1_r=0;
    r2_r=0;r3_r=0;r4_r=0;f=3'b001;posC=3'b000;dataP=4'b0000;
    end
    always@(posedge clk100mhz)
    begin
        cnt<=cnt+1'b1;
        clk1s<=cnt[26];//cnt[3];
        //clk4s<=cnt[28];
        clk190hz<=cnt[17];//cnt[1];
    end
    always@(posedge clk1s)
    begin
        up1_r<=up1;
        up2_r<=up2;
        up3_r<=up3;
        dn2_r<=dn2;
        dn3_r<=dn3;
        dn4_r<=dn4;
        r1_r<=r1;
        r2_r<=r2;
        r3_r<=r3;
        r4_r<=r4;
    end
    //always@(posedge clk4s or posedge rst)
    //begin
    //    if(rst)begin
    //        led<=10'd0;
    //    end
    //    else led[9:0]<={up1_r^up1,up2_r^up2,up3_r^up3,dn2_r^dn2,dn3_r^dn3,dn4_r^dn4,r1_r^r1,r2_r^r2,r3_r^r3,r4_r^r4};
    //end
    always@(posedge clk100mhz)
        begin
            if(floor==f1)begin
                has_up_request<=led[0]|led[1]|led[2]|led[4]|led[5]|led[6]|led[7]|led[8];//r2|r3|r4|up2|up3|dn2|dn3|dn4
                has_down_request<=0;
            end
            if(floor==f2)begin
                has_up_request<=led[0]|led[1]|led[4]|led[5]|led[7];//r3|r4|up3|dn3|dn4;
                has_down_request<=led[3]|led[9];//r1|up1;
            end  
            if(floor==f3)begin
                has_up_request<=led[0]|led[4];//r4|dn4
                has_down_request<=led[3]|led[2]|led[9]|led[8]|led[6];//r1|r2|up1|up2|dn2
            end     
            if(floor==f4)begin
                has_up_request<=0;
                has_down_request<=led[3]|led[2]|led[1]|led[9]|led[8]|led[7]|led[6]|led[5];//r1|r2|r3|up1|up2|up3|dn2|dn3
            end
        end
        always@(posedge clk100mhz)
        begin
            liftgoup<=(((direction==up_f)|(direction==idle)) & has_up_request) |((direction==dn_f) & !has_down_request & has_up_request);
            liftgodown<=((direction==up_f) & !has_up_request & has_down_request)|(((direction==dn_f)|(direction==idle)) & has_down_request);
        end
        always@(posedge clk100mhz )
        begin
            if(floor==f1)begin
                opendoor<=led[3]|((direction==up_f) & (led[9]))|((direction==dn_f) &((!has_down_request&led[9])))|((direction==idle)&(led[9]));
            end
            if(floor==f2)begin
                opendoor<=led[2]|((direction==up_f) & (led[8]|(!has_up_request & led[6])))|((direction==dn_f) &(led[6]|(!has_down_request&led[8])))|((direction==idle)&(led[8]|led[6]));
            end
            if(floor==f3)begin
                opendoor<=led[1]|((direction==up_f) & (led[7]|(!has_up_request & led[5])))|((direction==dn_f) &(led[5]|(!has_down_request&led[7])))|((direction==idle)&(led[7]|led[5]));
            end
            if(floor==f4)begin
                opendoor<=led[0]|((direction==up_f) & ((!has_up_request & led[4])))|((direction==dn_f) &(led[4]))|((direction==idle)&led[4]);
            end
        end
    always@(posedge clk1s or posedge rst)
    begin
        if(rst)begin
            state<=idle_state;
        end
        else begin
            state<=next_state;
        end
    end
    always@(*)
    begin
        if(weight)begin
            led[10]=1'b1;
        end
        else begin
            led[10]=1'b0;
        end
        if((led[9])&&(floor==f1)&&(state==open_state))begin
            led[9]<=1'b0;
        end
        else if(led[9])begin
            led[9]<=led[9];
        end
        else begin
            led[9]<=up1_r^up1;
        end
        if((led[8])&&(floor==f2)&&(state==open_state))begin
            led[8]<=1'b0;
        end
        else if(led[8])begin
            led[8]<=led[8];
        end
        else begin
            led[8]<=up2_r^up2;
        end
        if((led[7])&&(floor==f3)&&(state==open_state))begin
            led[7]<=1'b0;
        end
        else if(led[7])begin
            led[7]<=led[7];
        end
        else begin
            led[7]<=up3_r^up3;
        end
        if((led[6])&&(floor==f2)&&(state==open_state))begin
             led[6]<=1'b0;
        end
        else if(led[6])begin
             led[6]<=led[6];
        end
        else begin
                    led[6]<=dn2_r^dn2;
                end
         if((led[5])&&(floor==f3)&&(state==open_state))begin
                           led[5]<=1'b0;
                       end
                       else if(led[5])begin
                           led[5]<=led[5];
                       end
                       else begin
                           led[5]<=dn3_r^dn3;
                       end
          if((led[4])&&(floor==f4)&&(state==open_state))begin
                                  led[4]<=1'b0;
                              end
                              else if(led[4])begin
                                  led[4]<=led[4];
                              end
                              else begin
                                  led[4]<=dn4_r^dn4;
                              end
         if((led[3])&&(floor==f1)&&(state==open_state))begin
                                         led[3]<=1'b0;
                                     end
                                     else if(led[3])begin
                                         led[3]<=led[3];
                                     end
                                     else begin
                                         led[3]<=r1_r^r1;
                                     end
        if((led[2])&&(floor==f2)&&(state==open_state))begin
                                                led[2]<=1'b0;
                                            end
                                            else if(led[2])begin
                                                led[2]<=led[2];
                                            end
                                            else begin
                                                led[2]<=r2_r^r2;
                                            end
         if((led[1])&&(floor==f3)&&(state==open_state))begin
                                                       led[1]<=1'b0;
                                                   end
                                                   else if(led[1])begin
                                                       led[1]<=led[1];
                                                   end
                                                   else begin
                                                       led[1]<=r3_r^r3;
                                                   end
          if((led[0])&&(floor==f4)&&(state==open_state))begin
                                                              led[0]<=1'b0;
                                                          end
                                                          else if(led[0])begin
                                                              led[0]<=led[0];
                                                          end
                                                          else begin
                                                              led[0]<=r4_r^r4;
                                                          end
    end
    always@(*)
    begin
        case(state)
            open_state:begin
                       if(weight)begin
                           next_state=open_state;
                       end
                       else if(count<10)begin
                           next_state=open_state;
                       end
                       else begin
                           next_state=close_state;
                       end
                       end
            idle_state:begin 
                       
                       if(opendoor)begin
                            next_state=open_state;
                       end
                       else if(liftgoup)begin
                           next_state=up_state;
                       end
                       else if(liftgodown)begin
                           next_state=down_state;
                       end
                       else begin
                           next_state=idle_state;
                       end
                       end
            up_state:begin
                     
                     if(opendoor)begin
                        next_state<=open_state;
                     end
                     else if(liftgoup)begin
                        next_state=up_state;
                     end
                     else if(liftgodown)begin
                        next_state=down_state;
                     end
                     else begin
                        next_state=idle_state;
                     end
                     end
           down_state:begin
                      
                      if(opendoor)begin
                           next_state<=open_state;
                      end
                      else if(liftgoup)begin
                          next_state=up_state;
                      end
                      else if(liftgodown)begin
                          next_state=down_state;
                      end
                      else begin
                          next_state=idle_state;
                      end
                      end
           close_state:begin
                       
                       if(liftgoup)begin
                           next_state=up_state;
                       end
                       else if(liftgodown)begin
                           next_state=down_state;
                       end
                       else if(opendoor)begin
                           next_state=open_state;
                       end
                       else begin
                           next_state=idle_state;
                       end
                       end
          default:begin
            next_state=idle_state;
            
          end
        endcase
    end
    always@(posedge clk1s or posedge rst)
    begin
        if(rst)begin
            floor<=f1;
            direction<=idle;
            f<=2'b01;
            //led<=10'd0;
        end
        else begin
            floor<=floor;
            case(next_state)
            idle_state:begin
                floor<=floor;
                direction<=idle;
                f<=f;
                //led[9:0]<={up1_r^up1,up2_r^up2,up3_r^up3,dn2_r^dn2,dn3_r^dn3,dn4_r^dn4,r1_r^r1,r2_r^r2,r3_r^r3,r4_r^r4};
            end
            up_state:begin
                floor<=floor<<1;
                direction<=up_f;
                f<=f+1'b1;
               // led<=led;
            end
            down_state:begin
                floor<=floor>>1;
                direction<=dn_f;
                f<=f-1'b1;
                //led<=led;
            end
            open_state:begin
                floor<=floor;
                direction<=direction;
                f<=f;
                //led[9:0]<={up1_r^up1,up2_r^up2,up3_r^up3,dn2_r^dn2,dn3_r^dn3,dn4_r^dn4,r1_r^r1,r2_r^r2,r3_r^r3,r4_r^r4};
            end
            close_state:begin
                floor<=floor;
                direction<=direction;
                f<=f;
                //led<=led;
            end
            default:begin
                floor<=f1;
                direction<=idle;
                f<=f;
               // led[9:0]<={up1_r^up1,up2_r^up2,up3_r^up3,dn2_r^dn2,dn3_r^dn3,dn4_r^dn4,r1_r^r1,r2_r^r2,r3_r^r3,r4_r^r4};
            end
            endcase
        end
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
            10:seg=8'b0100_0000;
            11:seg=8'b0000_0000;
            default:seg = 8'b0000_1000;
          endcase
    always @(posedge clk190hz)
                begin
                case(posC)
                 0: begin
                    pos<=4'b0001;
                    dataP<=count;
                    end
                 1: begin
                    pos<=4'b0010;
                    dataP<=f;//louceng
                    end
                 2: begin
                    pos<=4'b0100;
                    dataP<=direction;//fangxiang
                    end
                 3: begin
                    pos<=4'b1000;
                    dataP<=state;//zhuangtaiji
                    end
                  endcase
                  posC = posC+1;
                  end
always@(posedge clk1s or posedge rst)
begin
    if(rst)begin
        count<=0;
    end
    else if((next_state==open_state)&&(count<10))begin
        count<=count+1'b1;
    end
    else begin
        count<=0;
    end
end
endmodule
