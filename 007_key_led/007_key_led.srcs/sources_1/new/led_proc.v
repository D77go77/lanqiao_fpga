module led_proc
(
    input clk,rst,
    input [3:0]mode,
    output [7:0] led
);

    reg [7:0] led_tmp;
    wire clk_10hz;//100ms

    time_proc led_tim
    (
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(10),
        .clkout(clk_10hz)
    );

    always @(posedge clk_10hz or posedge rst) begin
        if(rst) begin
            led_tmp <= 8'hFF;//全灭
        end else begin
            case(mode)
                4'd0: led_tmp <= 8'h01;//1
                4'd1: led_tmp <= 8'h02;//全亮
                4'd2: led_tmp <= 8'h04;//全亮
                4'd3: led_tmp <= 8'h08;//全亮
                default: led_tmp <= 8'hFF;
            endcase
        end
    end
    assign led = ~led_tmp;
    
endmodule
