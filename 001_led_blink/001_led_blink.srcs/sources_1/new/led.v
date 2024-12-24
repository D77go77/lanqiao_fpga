`timescale 1ns / 1ps


module led(
    input wire clk,
    input wire rst,

    output reg  led    
    );
//50Mhz 系统时钟-> 1/50M-> 0.00000002s -> 20ns ->0.1s/20ns ->5_000_000次数
parameter COUNTER_MAX = 24'd5_000_000;//24位宽数值
reg [23:0] counter  ;

always @(posedge clk or posedge rst) begin
    if(rst) begin
        counter <= 0;
        led<=1;
    end else begin
        if(counter == COUNTER_MAX - 1)begin
            counter <= 0;
            led <= ~led;
        end else begin
            counter <= counter + 1;
        end
    end
end



endmodule
