`timescale 1ns / 1ps
module main(
    input wire clk,
    input wire rst_n,
    output reg [7:0] led
);
    wire       clk_led;  // 1Hz 分频时钟信号
    reg [7:0]  status;

    // 实例化 time 模块，将 50MHz 时钟分频到 1Hz
    freq_tim time_inst (
        .clk    (clk),         // 原始时钟信号 50MHz
        .rst_n  (rst_n),       // 低电平复位信号
        .clkbase(50_000_000),  // 基准时钟频率为 50MHz
        .clkdiv (1),           // 期望输出频率为 1Hz
        .clkout (clk_led)        // 输出分频后的 1Hz 时钟信号
    );
    
    // 根据  1Hz 慢时钟信号 clk_1 控制 LED 模式
    always @(posedge clk_led or posedge rst_n) begin
        if (rst_n) begin
            led <= 8'b0000_0001; // 初始化 led1 灭
        end else begin
            led <= ~(1 << status);
            status <= status + 1;
            if(status == 8)begin
                status <= 0;
            end
        end
    end
endmodule
