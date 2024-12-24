`timescale 1ns / 1ps

module freq_tim(
    input wire clk,
    input wire rst_n,
    input wire [31:0] clkbase,
    input wire [31:0] clkdiv,
    output reg  clkout
 );
    reg [31:0] counter;  // 计数器
    reg [31:0] limit;  // 计数限制值

    // 计算每个分频周期的计数限制
    always @(*) begin
        if(clkdiv > 0)begin
            limit = clkbase / (2*clkdiv);// 计算分频周期
        end else begin
            limit = 0;
        end
    end
    // 分频计数器
    always @(posedge clk or posedge rst_n)begin
        if(rst_n)begin
            counter <= 0;
            clkout <= 0;
        end else begin
            if(counter >= limit)begin
                counter <= 0;
                clkout <= ~clkout;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
