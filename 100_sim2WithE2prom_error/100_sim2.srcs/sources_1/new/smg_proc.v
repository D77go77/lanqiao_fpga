module smg_proc(
    input            clk,        // 输入的十进制数字（0-9）
    input            rst,        // 复位信号（低电平有效）
    input      [31:0] num,
    input      [7:0] dp,   // 小数点使能信号
    output  [7:0] wei_la,    // 位选信号
    output  [7:0] duan_la  // 段选信号
);
    wire clk_1khz;
    reg [2:0]bits;
    reg [3:0]now_num;
    reg now_dp;

    tim_proc tim_smg(
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(1000),
        .clkout(clk_1khz)
    );
    
    // 根据当前的位选择信号 `bits`，选择对应的数码管输入数据和小数点状态??
    always @(*) begin
        now_num = num[(7-bits)*4+:4];  // 选择相应的数字
        now_dp  = dp[7-bits];  // 获取小数点状态
    end

    smg_ctrl smg_display(
        .digit       (now_num),
        .rst         (rst),
        .en_dp       (now_dp),
        .position    (bits),
        .wei         (wei_la),
        .duan        (duan_la)
    );

    // 动态扫描逻辑，每 1ms 切换一个显示位
    always @(posedge clk_1khz or posedge rst) begin
        if (rst) bits <= 3'd0;  // 复位时从第 0 位开始显示
        else bits <= (bits == 3'd7) ? 3'd0 : bits + 3'd1;  // 切换到下一个显示位
    end

endmodule