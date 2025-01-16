module top (
    input  wire       clk,       // 时钟信号
    input  wire       rst,     // 复位信号（高电平有效）
    input  wire [3:0] key_in,    // 按键输入
    output wire [7:0] led,       // LED 输出
    output wire [7:0] dula,      // 数码管段选信号
    output wire [7:0] wela,      // 数码管位选信号
    output wire       rtc_sclk,  // RTC 时钟信号
    output wire       rtc_ce,    // RTC 芯片使能信号
    inout  wire       rtc_data   // RTC 数据线
);

    // ==================== 内部信号定义 ====================
    wire rst_n=~rst;

    // 从 DS1302 读取的时间数据
    wire [7:0] read_second;  // 读取的秒
    wire [7:0] read_minute;  // 读取的分
    wire [7:0] read_hour;  // 读取的小时
    wire [7:0] read_date;  // 读取的日期
    wire [7:0] read_month;  // 读取的月份
    wire [7:0] read_week;  // 读取的星期
    wire [7:0] read_year;  // 读取的年份

    wire       write_pulse;  // 写入脉冲信号

    // 要写入 DS1302 的时间数据
    wire [7:0] write_second;  // 写入的秒
    wire [7:0] write_minute;  // 写入的分
    wire [7:0] write_hour;  // 写入的小时
    wire [7:0] write_date;  // 写入的日期
    wire [7:0] write_month;  // 写入的月份
    wire [7:0] write_week;  // 写入的星期
    wire [7:0] write_year;  // 写入的年份

    // 写入时间常量定义
    assign write_second = 8'h50;  // 秒：50
    assign write_minute = 8'h02;  // 分：00
    assign write_hour   = 8'h18;  // 小时：16
    assign write_date   = 8'h05;  // 日期：05
    assign write_month  = 8'h01;  // 月份：01
    assign write_week   = 8'h07;  // 星期：07（周日）
    assign write_year   = 8'h25;  // 年份：25（2025）


    // ==================== 模块实例化 ====================
    wire [3:0] mode;
    // 按键处理模块
    key_proc key_proc_inst (
        .clk        (clk),         // 时钟信号
        .rst_n      (rst_n),       // 复位信号
        .key_in     (key_in),      // 按键输入
        .mode       (mode),        // 模式选择输出
        .write_pulse(write_pulse)  // 写入脉冲信号
    );

    // LED 控制模块
    led_proc led_proc_inst (
        .clk  (clk),    // 时钟信号
        .rst_n(rst_n),  // 复位信号
        .mode (mode),   // 模式选择
        .led  (led)     // LED 输出
    );
    
    // 数码管显示模块
    seg_proc seg_proc_init (
        .clk(clk),  // 时钟信号
        .rst_n(rst_n),  // 复位信号
        .seg_number_in({
            mode,
            4'd11,  // 显示小时
            read_minute,
            4'd11,  // 显示分钟
            read_second
        }),  // 显示秒
        .dp(dp),  // 小数点
        .dula(dula),  // 数码管段选信号
        .wela(wela)  // 数码管位选信号
    );

    // DS1302 实时时钟模块
    rtc_proc rtc_proc_init (
        .rst           (~rst_n),        // 复位信号（高电平有效）
        .clk           (clk),           // 时钟信号
        .ds1302_ce     (rtc_ce),        // RTC 芯片使能信号
        .ds1302_sclk   (rtc_sclk),      // RTC 时钟信号
        .ds1302_io     (rtc_data),      // RTC 数据线
        .write_second  (write_second),  // 写入秒
        .write_minute  (write_minute),  // 写入分
        .write_hour    (write_hour),    // 写入小时
        .write_date    (write_date),    // 写入日期
        .write_month   (write_month),   // 写入月份
        .write_week    (write_week),    // 写入星期
        .write_year    (write_year),    // 写入年份
        .write_time_req(write_pulse),   // 写入触发信号
        .read_second   (read_second),   // 读取秒
        .read_minute   (read_minute),   // 读取分
        .read_hour     (read_hour),     // 读取小时
        .read_date     (read_date),     // 读取日期
        .read_month    (read_month),    // 读取月份
        .read_week     (read_week),     // 读取星期
        .read_year     (read_year)      // 读取年份
    );

endmodule
