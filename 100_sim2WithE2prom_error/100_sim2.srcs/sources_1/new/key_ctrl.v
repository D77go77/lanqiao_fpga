module key_ctrl(
    input clk, rst,
    input [3:0] key,
    output reg [3:0] down,
    output reg [3:0] up
);
    reg [3:0]val;
    reg [3:0]old;

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            val <= 4'b1111;
            old <= 4'b1111;
            down <= 4'b0000;
            up <= 4'b0000;
        end
        else begin
            old <= val;
            val <= key;
            down <= val & (val ^ old);
            up <= ~val & (val ^ old);
        end
    end

endmodule