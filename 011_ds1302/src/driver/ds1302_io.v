module ds1302_io (
    input  wire       clk,            // 时钟信号，用于同步逻辑
    input  wire       rst,            // 复位信号，高电平有效
    output wire       ds1302_ce,      // DS1302 芯片使能信号，高电平有效
    output wire       ds1302_sclk,    // DS1302 串行时钟信号
    inout  wire       ds1302_io,      // DS1302 数据线（双向）
    input  wire       cmd_read,       // 读命令信号，高电平表示触发读取操作
    input  wire       cmd_write,      // 写命令信号，高电平表示触发写入操作
    output wire       cmd_read_ack,   // 读命令完成信号，高电平表示读取完成
    output wire       cmd_write_ack,  // 写命令完成信号，高电平表示写入完成
    input  wire [7:0] read_addr,      // 读取地址，对应 DS1302 内部寄存器
    input  wire [7:0] write_addr,     // 写入地址，对应 DS1302 内部寄存器
    input  wire [7:0] write_data,     // 写入数据
    output reg  [7:0] read_data       // 读取到的数据
);

    // 寄存器和变量定义
    reg [3:0] state, next_state;  // 当前状态和下一个状态
    reg  [19:0] delay_cnt;  // 延时计数器，用于控制时间间隔
    reg         wr_req;  // 写请求信号，用于 SPI 模块
    reg  [ 7:0] send_data;  // 要通过 SPI 发送的数据
    reg         CS_reg;  // 芯片使能寄存器，用于控制 nCS 信号
    reg         ds1302_io_dir;  // 数据线方向控制信号
    wire        DCLK;  // SPI 时钟信号
    wire        MOSI;  // SPI 主输出从输入信号
    wire        MISO;  // SPI 主输入从输出信号
    wire [ 7:0] data_rec;  // 从 SPI 接收的数据
    wire        wr_ack;  // SPI 写完成信号

    // 状态机状态定义
    localparam S_IDLE = 0;  // 空闲状态
    localparam S_CE_HIGH = 1;  // 拉高 CE 信号，启动 DS1302
    localparam S_READ = 2;  // 读操作
    localparam S_READ_ADDR = 3;  // 发送读取地址
    localparam S_READ_DATA = 4;  // 接收读取数据
    localparam S_WRITE = 5;  // 写操作
    localparam S_WRITE_ADDR = 6;  // 发送写入地址
    localparam S_WRITE_DATA = 7;  // 发送写入数据
    localparam S_CE_LOW = 8;  // 拉低 CE 信号，结束 DS1302 操作
    localparam S_ACK = 9;  // 应答状态，表示操作完成

    // 双向数据线的分配
    assign ds1302_io = ~ds1302_io_dir ? MOSI : 1'bz;  // 数据方向为输出时，赋值为 MOSI
    assign MISO = ds1302_io;  // 数据方向为输入时，从 ds1302_io 读取
    assign ds1302_sclk = DCLK;  // SPI 时钟连接到 DS1302 的时钟
    assign cmd_read_ack = (state == S_ACK);  // 读完成信号，当状态为 S_ACK 时有效
    assign cmd_write_ack = (state == S_ACK);  // 写完成信号，当状态为 S_ACK 时有效

    // 状态机逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) state <= S_IDLE;  // 复位时进入空闲状态
        else state <= next_state;  // 否则进入下一个状态
    end

    always @(*) begin
        case (state)
            S_IDLE:
            if (cmd_read || cmd_write)
                next_state <= S_CE_HIGH;  // 有读写命令时，进入 CE 拉高状态
            else next_state <= S_IDLE;  // 否则保持空闲
            S_CE_HIGH:
            if (delay_cnt == 20'd255)
                next_state <= cmd_read ? S_READ : S_WRITE; // 延时结束后，根据命令进入读或写状态
            else next_state <= S_CE_HIGH;
            S_READ: next_state <= S_READ_ADDR;  // 进入读取地址状态
            S_READ_ADDR:
            if (wr_ack)
                next_state <= S_READ_DATA;  // 地址发送完成后，进入读取数据状态
            else next_state <= S_READ_ADDR;
            S_READ_DATA:
            if (wr_ack) next_state <= S_ACK;  // 数据读取完成后，进入应答状态
            else next_state <= S_READ_DATA;
            S_WRITE: next_state <= S_WRITE_ADDR;  // 写操作时，进入写地址状态
            S_WRITE_ADDR:
            if (wr_ack)
                next_state <= S_WRITE_DATA;  // 地址发送完成后，进入写数据状态
            else next_state <= S_WRITE_ADDR;
            S_WRITE_DATA:
            if (wr_ack) next_state <= S_ACK;  // 数据写入完成后，进入应答状态
            else next_state <= S_WRITE_DATA;
            S_ACK: next_state <= S_CE_LOW;  // 应答完成后，进入 CE 拉低状态
            S_CE_LOW:
            if (delay_cnt == 20'd255) next_state <= S_IDLE;  // 延时结束后，返回空闲状态
            else next_state <= S_CE_LOW;
            default: next_state <= S_IDLE;  // 默认返回空闲状态
        endcase
    end

    // CE 信号控制
    always @(posedge clk or posedge rst) begin
        if (rst) CS_reg <= 1'b0;  // 复位时清零
        else if (state == S_CE_HIGH) CS_reg <= 1'b1;  // 在 CE 拉高状态时激活 CE 信号
        else if (state == S_CE_LOW) CS_reg <= 1'b0;  // 在 CE 拉低状态时取消 CE 信号
    end

    // 延时计数器，用于控制 CE 信号的拉高和拉低时间
    always @(posedge clk or posedge rst) begin
        if (rst) delay_cnt <= 20'd0;  // 复位时清零计数器
        else if (state == S_CE_HIGH || state == S_CE_LOW)
            delay_cnt <= delay_cnt + 20'd1;  // 在 CE 高或低状态时递增
        else delay_cnt <= 20'd0;  // 其他状态清零计数器
    end

    // 写请求信号，用于 SPI 模块
    always @(posedge clk or posedge rst) begin
        if (rst) wr_req <= 1'b0;  // 复位时清零
        else if (wr_ack) wr_req <= 1'b0;  // 写完成后清零
        else if (state == S_READ_ADDR || state == S_READ_DATA || 
                 state == S_WRITE_ADDR || state == S_WRITE_DATA)
            wr_req <= 1'b1;  // 在读写相关状态时拉高写请求
    end

    // 数据方向控制
    always @(posedge clk or posedge rst) begin
        if (rst) ds1302_io_dir <= 1'b0;  // 复位时设置为输出方向
        else
            ds1302_io_dir <= (state == S_READ_DATA); // 在读取数据状态时切换为输入方向
    end

    // 数据读取
    always @(posedge clk or posedge rst) begin
        if (rst) read_data <= 8'h00;  // 复位时清零读取数据
        else if (state == S_READ_DATA && wr_ack)
            read_data <= {
                data_rec[0],
                data_rec[1],
                data_rec[2],
                data_rec[3],
                data_rec[4],
                data_rec[5],
                data_rec[6],
                data_rec[7]
            };  // 反转读取数据的高低位，符合 DS1302 的数据格式
    end

    // SPI 发送数据逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) send_data <= 8'h00;  // 复位时清零发送数据
        else begin
            if (state == S_READ_ADDR)  // 读地址时，设置读地址格式
                send_data <= {
                    1'b1,  // 读命令标志
                    read_addr[1],  // 地址位
                    read_addr[2],
                    read_addr[3],
                    read_addr[4],
                    read_addr[5],
                    read_addr[6],
                    1'b1  // 地址结束位
                };
            else if (state == S_WRITE_ADDR)  // 写地址时，设置写地址格式
                send_data <= {
                    1'b0,  // 写命令标志
                    write_addr[1],  // 地址位
                    write_addr[2],
                    write_addr[3],
                    write_addr[4],
                    write_addr[5],
                    write_addr[6],
                    1'b1  // 地址结束位
                };
            else if (state == S_WRITE_DATA)  // 写数据时，直接传递写入数据
                send_data <= {
                    write_data[0],  // 数据位
                    write_data[1],
                    write_data[2],
                    write_data[3],
                    write_data[4],
                    write_data[5],
                    write_data[6],
                    write_data[7]
                };
        end
    end

    // SPI 子模块实例化
    spi_master spi_master_m0 (
        .clk     (clk),        // 时钟信号
        .rst     (rst),        // 复位信号
        .nCS     (ds1302_ce),  // SPI 芯片使能信号
        .DCLK    (DCLK),       // SPI 时钟信号
        .MOSI    (MOSI),       // SPI 主输出从输入信号
        .MISO    (MISO),       // SPI 主输入从输出信号
        .CPOL    (1'b0),       // SPI 时钟极性
        .CPHA    (1'b0),       // SPI 时钟相位
        .nCS_ctrl(CS_reg),     // CE 控制信号
        .clk_div (16'd50),     // 时钟分频系数
        .wr_req  (wr_req),     // 写请求信号
        .wr_ack  (wr_ack),     // 写完成信号
        .data_in (send_data),  // 要发送的数据
        .data_out(data_rec)    // 接收到的数据
    );
endmodule
