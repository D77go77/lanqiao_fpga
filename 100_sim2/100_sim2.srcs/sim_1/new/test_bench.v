`timescale 1ns / 1ps

module test_bench();

    // 参数定义
    parameter CLK_PERIOD = 20; // 50MHz时钟周期
    parameter TIME_OUT = 100_000_000; // 模拟时间限制

    // 信号声明
    reg clk, rst;
    reg [3:0] key;
    wire mode;
    wire led;
    wire [5:0] min;
    wire [5:0] sec;
    wire [3:0] ms;

    // 实例化待测模块
    key_proc uut (
        .clk(clk),
        .rst(rst),
        .key(key),
        .mode(mode),
        .led(led),
        .min(min),
        .sec(sec),
        .ms(ms)
    );

    // 时钟生成
    initial begin
        clk = 0;
        forever begin
            #10;
            clk = ~clk;
        end
    end

    // 测试过程
    initial begin
        // 初始化
        rst = 1;
        key = 4'b0000;
        #40;
        rst = 0;

        // 测试案例1: 切换模式
        #CLK_PERIOD * 10;
        key = 4'b0001; // 假设按键0被按下
        #CLK_PERIOD * 10;
        key = 4'b0000;
        #200;
        // 验证模式是否切换

        // 测试案例2: 计时功能
        key = 4'b0010; // 假设按键1被按下，启动计时
        #(CLK_PERIOD * 6000); // 模拟计时一段时间
        // 验证计时是否正确

        // 测试案例3: 重置功能
        key = 4'b0011; // 假设按键2被按下，重置时间
        #CLK_PERIOD * 10;
        key = 4'b0000;
        #CLK_PERIOD * 10;
        // 验证时间是否重置

        // 测试结束
        #TIME_OUT;
        $finish;
    end

    // 监测输出
    initial begin
        $monitor("At time %t, mode = %b, led = %b, min = %d, sec = %d, ms = %d", $time, mode, led, min, sec, ms);
    end

endmodule