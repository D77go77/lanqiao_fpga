module ds1302_ctrl (
    input wire rst,  // 复位信号，高电平有效，复位所有寄存器和状态
    input wire clk,  // 时钟信号，用于同步逻辑操作

    output wire ds1302_ce,    // DS1302 芯片使能信号，高电平有效，用于激活 DS1302
    output wire ds1302_sclk,  // DS1302 串行时钟信号，用于同步串行数据传输
    inout  wire ds1302_io,    // DS1302 双向数据线，用于数据传输

    input wire write_time_req,  // 写入时间请求信号，高电平表示开始写时间操作
    output wire write_time_ack,  // 写入时间完成响应信号，高电平表示写入完成
    input wire [7:0] write_second,  // 要写入的秒值 (0-59)，采用 BCD 编码
    input wire [7:0] write_minute,  // 要写入的分值 (0-59)，采用 BCD 编码
    input wire [7:0] write_hour,  // 要写入的小时值 (0-23)，采用 BCD 编码
    input wire [7:0] write_date,  // 要写入的日期值 (1-31)，采用 BCD 编码
    input wire [7:0] write_month,  // 要写入的月份值 (1-12)，采用 BCD 编码
    input wire [7:0] write_week,  // 要写入的星期值 (1-7)，采用 BCD 编码
    input wire [7:0] write_year,  // 要写入的年份值 (0-99)，采用 BCD 编码

    input wire read_time_req,  // 读取时间请求信号，高电平表示开始读取时间操作
    output wire read_time_ack,  // 读取时间完成响应信号，高电平表示读取完成
    output reg [7:0] read_second,  // 从 DS1302 读取的秒值，采用 BCD 编码
    output reg [7:0] read_minute,  // 从 DS1302 读取的分值，采用 BCD 编码
    output reg [7:0] read_hour,  // 从 DS1302 读取的小时值，采用 BCD 编码
    output reg [7:0] read_date,  // 从 DS1302 读取的日期值，采用 BCD 编码
    output reg [7:0] read_month,  // 从 DS1302 读取的月份值，采用 BCD 编码
    output reg [7:0] read_week,  // 从 DS1302 读取的星期值，采用 BCD 编码
    output reg [7:0] read_year  // 从 DS1302 读取的年份值，采用 BCD 编码
);

    // 状态机定义，用于控制数据传输的各个步骤
    localparam S_IDLE = 0;  // 空闲状态，等待读/写请求
    localparam S_WR_WP = 1;  // 写入写保护寄存器，解锁写操作
    localparam S_WR_SEC = 2;  // 写入秒数据
    localparam S_WR_MIN = 3;  // 写入分钟数据
    localparam S_WR_HOUR = 4;  // 写入小时数据
    localparam S_WR_DATE = 5;  // 写入日期数据
    localparam S_WR_MON = 6;  // 写入月份数据
    localparam S_WR_WEEK = 7;  // 写入星期数据
    localparam S_WR_YEAR = 8;  // 写入年份数据
    localparam S_RD_SEC = 9;  // 读取秒数据
    localparam S_RD_MIN = 10;  // 读取分钟数据
    localparam S_RD_HOUR = 11;  // 读取小时数据
    localparam S_RD_DATE = 12;  // 读取日期数据
    localparam S_RD_MON = 13;  // 读取月份数据
    localparam S_RD_WEEK = 14;  // 读取星期数据
    localparam S_RD_YEAR = 15;  // 读取年份数据
    localparam S_ACK = 16;  // 应答状态，表示操作完成

    // 寄存器和信号定义
    reg [4:0] state, next_state;  // 当前状态和下一个状态
    reg  [7:0] read_addr;  // 读取地址，对应 DS1302 寄存器
    reg  [7:0] write_addr;  // 写入地址，对应 DS1302 寄存器
    reg  [7:0] write_data;  // 写入的数据
    reg        cmd_write;  // 写命令，高电平表示写操作
    reg        cmd_read;  // 读命令，高电平表示读操作
    wire [7:0] read_data;  // 从 DS1302 接口读取的数据
    wire       cmd_read_ack;  // 读命令完成信号
    wire       cmd_write_ack;  // 写命令完成信号

    // 写时间完成信号，高电平表示状态机完成所有写操作
    assign write_time_ack = (state == S_ACK);
    // 读时间完成信号，高电平表示状态机完成所有读操作
    assign read_time_ack  = (state == S_ACK);

    // 写命令控制逻辑，状态机在写操作状态时拉高 cmd_write 信号
    always @(posedge clk or posedge rst) begin
        if (rst) cmd_write <= 1'b0;  // 复位时清零写命令
        else if (cmd_write_ack) cmd_write <= 1'b0;  // 写操作完成后清零写命令
        else
            case (state)
                S_WR_WP, S_WR_SEC, S_WR_MIN, S_WR_HOUR, S_WR_DATE, S_WR_MON, S_WR_WEEK, S_WR_YEAR:
                cmd_write <= 1'b1;  // 在写入相关状态时拉高写命令
            endcase
    end

    // 读命令控制逻辑，状态机在读操作状态时拉高 cmd_read 信号
    always @(posedge clk or posedge rst) begin
        if (rst) cmd_read <= 1'b0;  // 复位时清零读命令
        else if (cmd_read_ack) cmd_read <= 1'b0;  // 读操作完成后清零读命令
        else
            case (state)
                S_RD_SEC, S_RD_MIN, S_RD_HOUR, S_RD_DATE, S_RD_MON, S_RD_WEEK, S_RD_YEAR:
                cmd_read <= 1'b1;  // 在读取相关状态时拉高读命令
            endcase
    end

    // 输出读到的数据，根据状态机的读命令完成信号，更新对应的寄存器
    always @(posedge clk or posedge rst) begin
        if (rst) read_second <= 8'h00;  // 复位时清零秒值
        else if (state == S_RD_SEC && cmd_read_ack)
            read_second <= read_data;  // 在秒读取完成时更新秒值
    end

    always @(posedge clk or posedge rst) begin
        if (rst) read_minute <= 8'h00;  // 复位时清零分钟值
        else if (state == S_RD_MIN && cmd_read_ack)
            read_minute <= read_data;  // 在分钟读取完成时更新分钟值
    end

    // 类似的逻辑应用于其他时间数据 (小时、日期、月份、星期、年份)
    always @(posedge clk or posedge rst) begin
        if (rst) read_hour <= 8'h00;
        else if (state == S_RD_HOUR && cmd_read_ack) read_hour <= read_data;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) read_date <= 8'h00;
        else if (state == S_RD_DATE && cmd_read_ack) read_date <= read_data;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) read_month <= 8'h00;
        else if (state == S_RD_MON && cmd_read_ack) read_month <= read_data;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) read_week <= 8'h00;
        else if (state == S_RD_WEEK && cmd_read_ack) read_week <= read_data;
    end

    always @(posedge clk or posedge rst) begin
        if (rst) read_year <= 8'h00;
        else if (state == S_RD_YEAR && cmd_read_ack) read_year <= read_data;
    end

    // 设置读取地址，根据当前状态分配 DS1302 的读取地址
    always @(posedge clk or posedge rst) begin
        if (rst) read_addr <= 8'h00;
        else
            case (state)
                S_RD_SEC:  read_addr <= 8'h81;  // 秒寄存器地址 (读操作)
                S_RD_MIN:  read_addr <= 8'h83;  // 分寄存器地址 (读操作)
                S_RD_HOUR: read_addr <= 8'h85;  // 小时寄存器地址 (读操作)
                S_RD_DATE: read_addr <= 8'h87;  // 日期寄存器地址 (读操作)
                S_RD_MON:  read_addr <= 8'h89;  // 月份寄存器地址 (读操作)
                S_RD_WEEK: read_addr <= 8'h8b;  // 星期寄存器地址 (读操作)
                S_RD_YEAR: read_addr <= 8'h8d;  // 年份寄存器地址 (读操作)
                default:   read_addr <= read_addr;  // 默认保持不变
            endcase
    end

    // 写操作的地址和数据生成
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_addr <= 8'h00;  // 复位时清零写地址
            write_data <= 8'h00;  // 复位时清零写数据
        end else
            case (state)
                S_WR_WP: begin
                    write_addr <= 8'h8e;  // 写保护寄存器地址
                    write_data <= 8'h00;  // 禁用写保护
                end
                S_WR_SEC: begin
                    write_addr <= 8'h80;  // 秒寄存器地址
                    write_data <= write_second;  // 写入秒值
                end
                S_WR_MIN: begin
                    write_addr <= 8'h82;  // 分寄存器地址
                    write_data <= write_minute;  // 写入分钟值
                end
                S_WR_HOUR: begin
                    write_addr <= 8'h84;  // 小时寄存器地址
                    write_data <= write_hour;  // 写入小时值
                end
                S_WR_DATE: begin
                    write_addr <= 8'h86;  // 日期寄存器地址
                    write_data <= write_date;  // 写入日期值
                end
                S_WR_MON: begin
                    write_addr <= 8'h88;  // 月份寄存器地址
                    write_data <= write_month;  // 写入月份值
                end
                S_WR_WEEK: begin
                    write_addr <= 8'h8a;  // 星期寄存器地址
                    write_data <= write_week;  // 写入星期值
                end
                S_WR_YEAR: begin
                    write_addr <= 8'h8c;  // 年份寄存器地址
                    write_data <= write_year;  // 写入年份值
                end
                default: begin
                    write_addr <= 8'h00;  // 默认清零写地址
                    write_data <= 8'h00;  // 默认清零写数据
                end
            endcase
    end

    // 状态机主控逻辑，根据当前状态和条件跳转到下一个状态
    always @(posedge clk or posedge rst) begin
        if (rst) state <= S_IDLE;  // 复位时进入空闲状态
        else state <= next_state;  // 否则进入下一个状态
    end

    always @(*) begin
        case (state)
            S_IDLE:
            if (write_time_req)
                next_state <= S_WR_WP;  // 如果有写请求，进入写保护状态
            else if (read_time_req)
                next_state <= S_RD_SEC;  // 如果有读请求，进入读取秒状态
            else next_state <= S_IDLE;  // 无请求则保持空闲
            S_WR_WP:
            if (cmd_write_ack) next_state <= S_WR_SEC;  // 写保护完成后，进入写秒状态
            else next_state <= S_WR_WP;
            S_WR_SEC:
            if (cmd_write_ack) next_state <= S_WR_MIN;  // 写秒完成后，进入写分钟状态
            else next_state <= S_WR_SEC;
            S_WR_MIN:
            if (cmd_write_ack)
                next_state <= S_WR_HOUR;  // 写分钟完成后，进入写小时状态
            else next_state <= S_WR_MIN;
            S_WR_HOUR:
            if (cmd_write_ack)
                next_state <= S_WR_DATE;  // 写小时完成后，进入写日期状态
            else next_state <= S_WR_HOUR;
            S_WR_DATE:
            if (cmd_write_ack)
                next_state <= S_WR_MON;  // 写日期完成后，进入写月份状态
            else next_state <= S_WR_DATE;
            S_WR_MON:
            if (cmd_write_ack)
                next_state <= S_WR_WEEK;  // 写月份完成后，进入写星期状态
            else next_state <= S_WR_MON;
            S_WR_WEEK:
            if (cmd_write_ack)
                next_state <= S_WR_YEAR;  // 写星期完成后，进入写年份状态
            else next_state <= S_WR_WEEK;
            S_WR_YEAR:
            if (cmd_write_ack) next_state <= S_ACK;  // 写年份完成后，进入应答状态
            else next_state <= S_WR_YEAR;
            S_RD_SEC:
            if (cmd_read_ack)
                next_state <= S_RD_MIN;  // 读取秒完成后，进入读取分钟状态
            else next_state <= S_RD_SEC;
            S_RD_MIN:
            if (cmd_read_ack)
                next_state <= S_RD_HOUR;  // 读取分钟完成后，进入读取小时状态
            else next_state <= S_RD_MIN;
            S_RD_HOUR:
            if (cmd_read_ack)
                next_state <= S_RD_DATE;  // 读取小时完成后，进入读取日期状态
            else next_state <= S_RD_HOUR;
            S_RD_DATE:
            if (cmd_read_ack)
                next_state <= S_RD_MON;  // 读取日期完成后，进入读取月份状态
            else next_state <= S_RD_DATE;
            S_RD_MON:
            if (cmd_read_ack)
                next_state <= S_RD_WEEK;  // 读取月份完成后，进入读取星期状态
            else next_state <= S_RD_MON;
            S_RD_WEEK:
            if (cmd_read_ack)
                next_state <= S_RD_YEAR;  // 读取星期完成后，进入读取年份状态
            else next_state <= S_RD_WEEK;
            S_RD_YEAR:
            if (cmd_read_ack) next_state <= S_ACK;  // 读取年份完成后，进入应答状态
            else next_state <= S_RD_YEAR;
            S_ACK: next_state <= S_IDLE;  // 应答完成后，返回空闲状态
            default: next_state <= S_IDLE;  // 默认返回空闲状态
        endcase
    end

    // 实例化 DS1302 接口模块，用于与芯片进行通信
    ds1302_io ds1302_io_m0 (
        .clk          (clk),            // 时钟信号
        .rst          (rst),            // 复位信号
        .ds1302_ce    (ds1302_ce),      // DS1302 芯片使能信号
        .ds1302_sclk  (ds1302_sclk),    // DS1302 串行时钟信号
        .ds1302_io    (ds1302_io),      // DS1302 双向数据线
        .cmd_read     (cmd_read),       // 读命令信号
        .cmd_write    (cmd_write),      // 写命令信号
        .cmd_read_ack (cmd_read_ack),   // 读命令完成信号
        .cmd_write_ack(cmd_write_ack),  // 写命令完成信号
        .read_addr    (read_addr),      // 读取地址
        .write_addr   (write_addr),     // 写入地址
        .read_data    (read_data),      // 读取数据
        .write_data   (write_data)      // 写入数据
    );

endmodule
