module key_proc(
    input clk, rst, // 系统时钟和复位信号
    input [3:0] key, // 按键输入，4位宽度
    output  mode, // 模式输出，指示当前操作模式
    output  led, // LED输出，用于指示计时器状态
    output [5:0] min, // 分钟显示输出，6位宽度
    output [5:0] sec, // 秒显示输出，6位宽度
    output [3:0] ms, // 毫秒显示输出，4位宽度
    input [5:0] old_min,
    input [5:0] old_sec,
    input [3:0] old_ms,
    output e2prom_start
    );

    // 内部信号定义
    wire [3:0]down; // 按键按下信号
    wire [3:0]up; // 按键释放信号
    wire clk_100hz; // 100Hz时钟信号

    // 寄存器变量定义
    reg [3:0]cnt_10; // 100ms计数器，用于产生1s信号
    reg [5:0] min_r,sec_r; // 分钟和秒的寄存器变量
    reg [3:0] ms_r; // 毫秒的寄存器变量
    reg mode_r; // 模式寄存器变量
    reg led_r; // LED状态寄存器变量
    reg  e2prom_start_r;

    // 将内部寄存器变量赋值给输出信号
    assign mode = mode_r;
    assign min = min_r;
    assign sec = sec_r;
    assign ms = ms_r;
    assign led = led_r;
    assign e2prom_start = e2prom_start_r;

    reg begin_ready;//上电成功
    initial begin
        begin_ready = 1'd1;//初次上电
    end
    // tim_proc模块用于产生100Hz时钟信号
    tim_proc tim_key(
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(100),
        .clkout(clk_100hz)
    );

    // key_ctrl模块用于检测按键事件，生成按键按下和释放信号
    key_ctrl key_get(
        .clk(clk_100hz),
        .rst(rst),
        .key(key),
        .down(down),
        .up(up)
    );

    // 主控制逻辑，用于处理按键事件和更新时间显示
    always @(posedge clk_100hz or posedge rst) begin
        if(rst) begin
            // 复位逻辑，初始化所有寄存器变量
            mode_r <= 2'd0;
            cnt_10 <= 4'd0;
            min_r <= 0;
            sec_r <= 0;
            ms_r <= 0;
            led_r<=1;
            e2prom_start_r<=0;
        end else begin
            // 处理按键事件
            if(down[1]) begin
                // 如果在计时模式下按下按键，则重置时间
                if(mode_r)begin
                    min_r <= 0;
                    sec_r <= 0;
                    ms_r <= 0;
                end else begin// 如果在停止模式下按下按键，则写入e2prom
                    e2prom_start_r <= 1'd1;
                end
            end else if(down[0]) begin
                // 如果按下按键，则切换模式
                mode_r <= ~mode_r;
            end else if(begin_ready)begin//// 上电后载入old值
                begin_ready <= 1'd0;// 清除上电标志
                min_r <= old_min;
                sec_r <= old_sec;
                ms_r <= old_ms;
            end

            // 计时器逻辑
            if(mode_r == 1) begin
                led_r <= 2'd0;
                if (cnt_10 == 4'd9) begin
                    cnt_10 <= 4'd0;
                    // 计时进位逻辑
                    if (ms_r < 4'd9) begin
                        ms_r <= ms_r + 4'd1;
                    end else if (sec_r < 6'd59) begin
                        sec_r <= sec_r + 6'd1;
                        ms_r <= 4'd0;
                    end else if (min_r < 6'd59) begin
                        min_r <= min_r + 6'd1;
                        sec_r <= 6'd0;
                        ms_r <= 4'd0;
                    end else begin
                        // 计时达到最大值时重置
                        min_r <= 6'd0;
                        sec_r <= 6'd0;
                        ms_r <= 4'd0;
                    end
                end else begin
                    cnt_10 <= cnt_10 + 4'd1;
                end
            end else begin
                // 如果不在计时模式，熄灭LED
                led_r <= 2'd1;
            end
        end
    end
endmodule