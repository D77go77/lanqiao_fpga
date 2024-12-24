
module time_proc
(
    input clk,
    input rst,
    input [31:0]clkbase,
    input [31:0]clkdiv,
    output reg clkout
);

    reg [31:0] cnt;
    reg [31:0] cnt_max;

    always @(*) begin
        if(clkdiv > 0)begin
            cnt_max = clkbase / (2*clkdiv);
        end
        else cnt_max = 0;
    end

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            cnt <= 0;
            clkout <= 0;
        end
        else begin
            if(cnt >= cnt_max)begin
                cnt <= 0;
                clkout = ~clkout;
            end
            else begin
                cnt <= cnt + 1;
            end
        end
    end
endmodule