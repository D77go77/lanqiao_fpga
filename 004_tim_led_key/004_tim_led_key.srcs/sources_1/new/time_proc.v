`timescale 1ns / 1ps
module time_proc(
    input wire clk,
    input wire rst,
    input wire [31:0] clkbase,
    input wire [31:0] clkdiv,
    output reg  clkout
    );
    reg [31:0] count;
    reg [31:0] limit;

    always @(*)begin
        if(clkdiv>0)begin
            limit = clkbase / (2*clkdiv);
        end else begin
            limit = 0;
        end
    end
    always @(posedge clk or posedge rst)begin
        if(rst)begin
            count <= 0;
            clkout <= 0;
        end else begin
            if(count >= limit)begin
                count <= 0;
                clkout <= ~clkout;
            end else begin
                count <= count + 1;
            end
        end
    end    
endmodule
