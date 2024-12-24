`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/23 20:10:56
// Design Name: 
// Module Name: main_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module main_tb;
    // 仿真时钟周期
    parameter CLK_PERIOD = 20; // 50 MHz clock

    // 信号声明
    reg clk;
    reg rst;
    reg [1:0] key;
    wire [7:0] duan;
    wire [7:0] wei;
    wire led;

    // 被测模块实例化
    main uut (
        .clk(clk),
        .rst(rst),
        .key(key),
        .duan(duan),
        .wei(wei),
        .led(led)
    );

    // 时钟生成
    always #(CLK_PERIOD/2) clk = ~clk;

    // 初始块
    initial begin
        // 初始化信号
        clk = 0;
        rst = 1;
        key = 2'b00;

        // 复位
        #20 rst = 0;

        // 测试按键输入
        #100 key = 2'b01; // 按键1
        #100 key = 2'b00; // 释放按键1
        #100 key = 2'b10; // 按键2
        #100 key = 2'b00; // 释放按键2

        // 等待一段时间
        #10000 $stop;
    end
        // 监控输出
    initial begin
        $monitor("Time = %0t, clk = %b, rst = %b, key = %b, duan = %b, wei = %b, led = %b, min = %0d, sec = %0d, ms = %0d", 
                 $time, clk, rst, key, duan, wei, led, uut.min, uut.sec, uut.ms);
    end
endmodule
