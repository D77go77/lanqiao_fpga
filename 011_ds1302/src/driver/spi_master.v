module spi_master (
    input  wire        clk,       // 输入时钟信号，用于驱动 SPI 主机的时序逻辑
    input  wire        rst,       // 复位信号，高电平有效
    output wire        nCS,       // SPI 从设备选择信号 (低电平有效)
    output wire        DCLK,      // SPI 时钟信号
    output wire        MOSI,      // SPI 主输出从输入信号 (发送数据)
    input  wire        MISO,      // SPI 主输入从输出信号 (接收数据)
    input  wire        CPOL,      // SPI 时钟极性 (Clock Polarity)
    input  wire        CPHA,      // SPI 时钟相位 (Clock Phase)
    input  wire        nCS_ctrl,  // 从设备选择信号控制信号
    input  wire [15:0] clk_div,   // 时钟分频值，用于控制 SPI 时钟频率
    input  wire        wr_req,    // 写请求信号，高电平有效
    output wire        wr_ack,    // 写完成信号，高电平表示写操作完成
    input  wire [ 7:0] data_in,   // 输入的数据，需要通过 SPI 发送
    output wire [ 7:0] data_out   // 输出的数据，从 SPI 接收
);

    // 寄存器定义
    reg        DCLK_reg;  // 时钟寄存器，控制 SPI 时钟信号
    reg [ 7:0] MOSI_shift;  // MOSI 数据移位寄存器，用于发送数据
    reg [ 7:0] MISO_shift;  // MISO 数据移位寄存器，用于接收数据
    reg [ 2:0] state;  // 当前状态
    reg [ 2:0] next_state;  // 下一状态
    reg [15:0] clk_cnt;  // SPI 时钟分频计数器
    reg [ 4:0] clk_edge_cnt;  // SPI 时钟边沿计数器，用于数据位计数

    // 状态定义
    localparam IDLE = 0;  // 空闲状态
    localparam DCLK_EDGE = 1;  // SPI 时钟上升/下降边沿处理状态
    localparam DCLK_IDLE = 2;  // SPI 时钟处于空闲周期
    localparam ACK = 3;  // 确认完成状态
    localparam LAST_HALF_CYCLE = 4;  // 最后半个时钟周期状态
    localparam ACK_WAIT = 5;  // 等待确认状态

    // 输出信号分配
    assign MOSI = MOSI_shift[7];  // 将发送数据移位寄存器的最高位作为 MOSI 输出
    assign data_out  = MISO_shift;     // 将接收到的数据移位寄存器的内容输出到 data_out
    assign nCS = nCS_ctrl;  // 由 nCS_ctrl 控制 nCS 信号
    assign DCLK = DCLK_reg;  // SPI 时钟信号
    assign wr_ack = (state == ACK);  // 当状态为 ACK 时，拉高 wr_ack 信号表示写完成

    // 状态机逻辑：更新当前状态
    always @(posedge clk or posedge rst) begin
        if (rst) state <= IDLE;  // 复位时进入空闲状态
        else state <= next_state;  // 否则进入下一状态
    end

    // 状态机逻辑：确定下一状态
    always @(*) begin
        case (state)
            IDLE:
            if (wr_req == 1'b1)
                next_state <= DCLK_IDLE;  // 如果有写请求，进入时钟空闲周期
            else next_state <= IDLE;  // 否则保持空闲状态
            DCLK_IDLE:
            if (clk_cnt == clk_div)
                next_state <= DCLK_EDGE;  // 时钟分频完成后进入时钟边沿状态
            else next_state <= DCLK_IDLE;
            DCLK_EDGE:
            if (clk_edge_cnt == 5'd15)
                next_state <= LAST_HALF_CYCLE; // 发送或接收完成后进入最后半个时钟周期
            else next_state <= DCLK_IDLE;
            LAST_HALF_CYCLE:
            if (clk_cnt == clk_div)
                next_state <= ACK;  // 最后半个时钟周期完成后进入确认状态
            else next_state <= LAST_HALF_CYCLE;
            ACK: next_state <= ACK_WAIT;  // 进入等待确认状态
            ACK_WAIT: next_state <= IDLE;  // 等待完成后返回空闲状态
            default: next_state <= IDLE;  // 默认返回空闲状态
        endcase
    end

    // 时钟信号控制逻辑
    always @(posedge clk or posedge rst) begin
        if (rst) DCLK_reg <= 1'b0;  // 复位时设置为默认极性
        else if (state == IDLE) DCLK_reg <= CPOL;  // 空闲时设置为 CPOL 定义的极性
        else if (state == DCLK_EDGE) DCLK_reg <= ~DCLK_reg;  // 时钟边沿时反转时钟信号
    end

    // 时钟分频计数器
    always @(posedge clk or posedge rst) begin
        if (rst) clk_cnt <= 16'd0;  // 复位时清零
        else if (state == DCLK_IDLE || state == LAST_HALF_CYCLE)
            clk_cnt <= clk_cnt + 16'd1;  // 在时钟空闲或最后半周期递增计数器
        else clk_cnt <= 16'd0;  // 其他状态清零计数器
    end

    // 时钟边沿计数器
    always @(posedge clk or posedge rst) begin
        if (rst) clk_edge_cnt <= 5'd0;  // 复位时清零
        else if (state == DCLK_EDGE)
            clk_edge_cnt <= clk_edge_cnt + 5'd1;  // 在时钟边沿状态递增计数器
        else if (state == IDLE) clk_edge_cnt <= 5'd0;  // 空闲状态清零计数器
    end

    // MOSI 数据移位寄存器
    always @(posedge clk or posedge rst) begin
        if (rst) MOSI_shift <= 8'd0;  // 复位时清零
        else if (state == IDLE && wr_req)
            MOSI_shift <= data_in;  // 在空闲状态接收到写请求时加载数据
        else if (state == DCLK_EDGE)
            if (CPHA == 1'b0 && clk_edge_cnt[0] == 1'b1)
                MOSI_shift <= {
                    MOSI_shift[6:0], MOSI_shift[7]
                };  // CPHA = 0，在时钟有效边沿移位
            else if (CPHA == 1'b1 && clk_edge_cnt != 5'd0 && clk_edge_cnt[0] == 1'b0)
                MOSI_shift <= {
                    MOSI_shift[6:0], MOSI_shift[7]
                };  // CPHA = 1，在时钟失效边沿移位
    end

    // MISO 数据移位寄存器
    always @(posedge clk or posedge rst) begin
        if (rst) MISO_shift <= 8'd0;  // 复位时清零
        else if (state == IDLE && wr_req)
            MISO_shift <= 8'h00;  // 在空闲状态接收到写请求时清零数据
        else if (state == DCLK_EDGE)
            if (CPHA == 1'b0 && clk_edge_cnt[0] == 1'b0)
                MISO_shift <= {MISO_shift[6:0], MISO};  // CPHA = 0，在时钟失效边沿采样
            else if (CPHA == 1'b1 && clk_edge_cnt[0] == 1'b1)
                MISO_shift <= {MISO_shift[6:0], MISO};  // CPHA = 1，在时钟有效边沿采样
    end

endmodule
