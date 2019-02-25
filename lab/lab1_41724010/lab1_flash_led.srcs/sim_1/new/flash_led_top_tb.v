`timescale 1ns / 1ps
module flash_led_top_tb;
    reg clk,rst,sw0;
    wire [15:0]led;
    initial begin
        clk=1'b0;
        rst=1'b1;
        sw0=1'b0;
        #10 rst=1'b0;
        #10 rst=1'b1;
        #1000000000
        #1000000000
        #1000000000
        #1000000000
        #1000000000
        #1000000000
        sw0=1'b1;
    end
    always#5 clk<=~clk;
    flash_led_top flash_led_top(
        .clk(clk),
        .rst_n(rst),
        .sw0(sw0),
        .led(led)
    );
endmodule

