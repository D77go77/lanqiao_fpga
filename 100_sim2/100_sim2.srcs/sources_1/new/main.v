`timescale 1ns / 1ps
module main(
    input clk,
    input rst,
    input [3:0] key,
    output [7:0] duan,
    output [7:0] wei,
    output  led
    );
    
    wire [5:0] min,sec;
    wire [3:0] ms;
    wire [3:0] min_ten,min_one;
    wire [3:0] sec_ten,sec_one;
    
    assign min_ten = min/10;
    assign min_one = min%10;
    assign sec_ten = sec/10;
    assign sec_one = sec%10;

    wire [7:0]dp=0;
    wire mode;//0:停止，1启动

    key_proc key_init(
        .clk(clk),
        .rst(rst),
        .key(key),
        .mode(mode),
        .led(led),
        .min(min),
        .sec(sec),
        .ms(ms)
    );

    smg_proc seg_init(
        .clk(clk),
        .rst(rst),
        .num({4'd10,min_ten,min_one,4'd11,sec_ten,sec_one,4'd11,ms}),
        .dp(dp),
        .wei_la(wei),
        .duan_la(duan)
    );

endmodule
