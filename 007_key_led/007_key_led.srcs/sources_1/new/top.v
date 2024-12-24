module top
(
    input   clk,
    input   rst,
    input   [3:0]key,
    output  [7:0]led
);

    wire [3:0]mode;

    key_proc key_init
    (
        .clk(clk),
        .rst(rst),
        .key_in(key),
        .mode(mode)
    );
    
    led_proc led_init
    (
        .clk(clk),
        .rst(rst),
        .led(led),
        .mode(mode)
     );

endmodule