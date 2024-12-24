`timescale 1ns / 1ps
module key_ctrl(
    input wire clk,
    input wire rst,
    input [3:0] key_in,
    output reg [3:0] k_down,
    output reg [3:0] k_up
    );
    
    reg [3:0] key_val;
    reg [3:0] key_old;

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            key_val <= 4'b1111;
            key_old <= 4'b1111;
            k_down <= 4'b0000;
            k_up <= 4'b0000;
        end else begin
            key_old <= key_val;  // 保存当前状态到 old 以便下一个周期比较
            key_val <= key_in;  // 更新 val 为当前的按键状态
            // 检测按键按下：val 和 old 比较，下降沿检测
            k_down <= key_val & (key_val ^ key_old);  // val 为低且 val 与 old 不同，说明按键刚被按下
            // 检测按键释放：val 和 old 比较，上升沿检测
            k_up   <= ~key_val & (key_val ^ key_old); // val 为高且 val 与 old 不同，说明按键刚被释放
        end
    end
endmodule
