`timescale 1ns / 1ps
module counter(
    input clk,
    input rst,
    output clk_bps
    );
    reg [13:0]ent_first,ent_second;
    always @(posedge clk or posedge rst)
        if(rst)
            ent_first<=14'd0;
        else if(ent_first==14'd10)
            ent_first<=14'd0;
        else 
            ent_first<=ent_first+1'b1;
    always@(posedge clk or posedge rst)
        if(rst)
            ent_second<=14'd0;
        else if(ent_second==14'd10)
            ent_second<=14'd0;
        else if(ent_first==14'd10)
            ent_second<=ent_second+1'b1;
    assign clk_bps = ent_second==14'd10 ? 1'b1 : 1'b0;
endmodule
