`timescale 1ns / 1ps

module main(
    input wire clk,
    input wire rst,
    input  [3:0] key_in,
    output [7:0] led
    );

    wire [1:0]mode;

    key_proc key_init(
        .clk (clk),
        .rst (rst),
        .key_in (key_in),
        .mode (mode)
    );

    led_proc led_init(
        .clk (clk),
        .rst (rst),
        .mode (mode),
        .led (led)
    );
endmodule
