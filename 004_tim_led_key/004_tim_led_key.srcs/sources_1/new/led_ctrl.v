
module led_ctrl (
    input      [7:0] led_in,
    output reg [7:0] led
);
    always @(*) begin
        led = ~led_in;
    end
endmodule
