`timescale 1ns / 1ps
module main(
    input clk,
    input rst,
    input wire S1,

    output reg  buzz
    );

    parameter  COUNT_MAX = 16'd40000 ;
    reg[15:0] count;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            count <= 0;
        end
        else begin
            if(count == COUNT_MAX - 1) begin
                count <= 0;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            buzz <= 0;
        end
        else begin
            if(!S1) begin
                if(count >= 20000 -1)begin
                    buzz <= 1;
                end
                else begin
                    buzz <= 0;
                end
            end
        end
    end
endmodule
