`timescale 1ns / 1ps
module led_proc(
    input wire clk,
    input wire rst,
    input [1:0]mode,
    output  [7:0]led
    );
    reg [7:0] led_in;
    wire       clk_10;  // 1Hz 分频时钟信号
    time_proc time_led(
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(10),
        .clkout(clk_10)
    );
    
    always @(posedge clk_10 or posedge rst)begin
        if (rst)begin
            led_in <= 8'b0000_0001;
        end else begin
            case(mode)
                2'b00:led_in <= {led_in[6:0],led_in[7]};
                2'b01:led_in <= {led_in[0],led_in[7:1]};
                2'b10:led_in <= ~led_in;
                2'b11:led_in <= 8'b0000_1000;
                default:led_in <= 8'b0000_0001;
            endcase
        end
    end

    led_ctrl led_display(
        .led_in(led_in),
        .led(led)
    );
endmodule
