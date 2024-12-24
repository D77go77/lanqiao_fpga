module  smg_ctrl
(
	input             clk,
	input             rst,
	input             [31:0]num,
    input             [7:0]dp,
    output            [7:0]wei,
    output            [7:0]duan
);
    wire clk_1khz;
    reg [2:0] position;
    reg [3:0] now_num;
    reg now_dp;

    time_proc smg_time
    (
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(1000),
        .clkout(clk_1khz)
    );

    always @(*)begin
        now_num = num[(7-position)*4+:4];
        now_dp = dp[7-position];
    end

    smg_proc smg_display
    (
        .num(now_num),
        .rst(rst),
        .en_dp(now_dp),
        .position(position),
        .wei(wei),
        .duan(duan)
    );

    always @(posedge clk_1khz or posedge rst) begin
        if(rst)
            position <= 3'd0;
        else
            position <= (position == 3'd7) ? 3'd0 : position + 3'd1;  // 切换到下一个显示位
    end

endmodule