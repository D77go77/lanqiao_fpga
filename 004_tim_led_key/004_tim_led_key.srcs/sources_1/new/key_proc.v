`timescale 1ns / 1ps
module key_proc(
    input wire clk,
    input wire rst,
    input wire [3:0]key_in,
    output reg[1:0]mode
);
    wire [3:0]k_down;
    wire [3:0]k_up;
    wire clk_100;//100hz
    
    time_proc time_key(
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(100),
        .clkout(clk_100)
    );
    // key
    key_ctrl key_get(
        .clk(clk_100),
        .rst(rst),
        .key_in(key_in),
        .k_down(k_down),
        .k_up(k_up)
    );
    always @(posedge clk_100 or posedge rst) begin
        if(rst)begin
            mode <= 2'b00;
        end else begin
            if(k_down[0])      mode <= 2'b00;
            else if(k_down[1]) mode <= 2'b01;
            else if(k_down[2]) mode <= 2'b10;
            else if(k_down[3]) mode <= 2'b11;
        end
    end
endmodule
