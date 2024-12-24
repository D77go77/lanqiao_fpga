module main(
    input clk,
    input rst,
    input [3:0] key,
    output [7:0] duan,
    output [7:0] wei,
    output   led,
    output   scl,
   	inout    sda   
);
    
wire [5:0] min,sec;
wire [3:0] ms;
wire [3:0] min_ten,min_one;
wire [3:0] sec_ten,sec_one;
reg [5:0] old_minute, old_second;
reg [3:0] old_minute_second;

assign min_ten = min/10;
assign min_one = min%10;
assign sec_ten = sec/10;
assign sec_one = sec%10;

wire mode;//0:停止 1启动
wire [7:0]dp;
reg old_mode;//上一模式
wire e2prom_start;//按键写入
reg e2prom_key_start_r;
assign e2prom_start =  e2prom_key_start_r;

// EEPROM控制信号
reg        wr_req;//写请求
reg        rd_req;//读请求
reg  [7:0] reg_addr;//操作寄存器 地址
reg        reg_addr_vld;//地址有效性
reg  [7:0] wr_data;//写数据
wire [7:0] rd_data;//读数据
wire       rd_data_vld;//读数据有效性 
wire       ready;

// EEPROM地址定义
localparam ADDR_MINUTE = 8'd0;  // minute存储地址
localparam ADDR_SECOND = 8'd1;  // second存储地址
localparam ADDR_MINUTE_SECOND = 8'd2;  // minute_second存储地址

// 状态机定义
reg [2:0] state;
localparam IDLE = 3'd0;
localparam WRITE_MINUTE = 3'd1;
localparam WRITE_SECOND = 3'd2;
localparam WRITE_MS = 3'd3;
localparam READ_MINUTE = 3'd4;
localparam READ_SECOND = 3'd5;
localparam READ_MS = 3'd6;

assign dp = 8'b0000_0000;

wire mode_negedge;//模式切换的下降沿检测
assign mode_negedge = ~mode & old_mode;
always @(posedge clk or posedge rst) begin
    if (rst) old_mode <= 0;
    else old_mode <= mode;
end

// EEPROM状态机
always @(posedge clk or posedge rst) begin
    if (rst) begin
        state <= READ_MINUTE;  // 上电后首先读取数据
        wr_req <= 0;
        rd_req <= 0;
        reg_addr_vld <= 0;
        wr_data <= 0;
    end else begin
        // 默认将控制信号置零
        wr_req <= 0;
        rd_req <= 0;
        reg_addr_vld <= 0;
        case (state)
            IDLE: begin
                if (mode_negedge) begin
                    state <= WRITE_MINUTE;  // mode从1变0时开始写入
                end
            end
            WRITE_MINUTE: begin
                if (ready) begin
                    reg_addr <= ADDR_MINUTE;
                    reg_addr_vld <= 1;
                    wr_data <= {2'b0, min};
                    wr_req <= 1;
                    state <= WRITE_SECOND;
                end
            end
            WRITE_SECOND: begin
                if (ready) begin
                    reg_addr <= ADDR_SECOND;
                    reg_addr_vld <= 1;
                    wr_data <= {2'b0, sec};
                    wr_req <= 1;
                    state <= WRITE_MS;
                end
            end
            WRITE_MS: begin
                if (ready) begin
                    reg_addr <= ADDR_MINUTE_SECOND;
                    reg_addr_vld <= 1;
                    wr_data <= {4'b0, ms};
                    wr_req <= 1;
                    state <= IDLE;
                end
            end
            READ_MINUTE: begin
                if (ready) begin
                    reg_addr <= ADDR_MINUTE;
                    reg_addr_vld <= 1;
                    rd_req <= 1;
                    state <= READ_SECOND;
                end
            end
            READ_SECOND: begin
                if (ready) begin
                    reg_addr <= ADDR_SECOND;
                    reg_addr_vld <= 1;
                    rd_req <= 1;
                    state <= READ_MS;
                end
            end
            READ_MS: begin
                if (ready) begin
                    reg_addr <= ADDR_MINUTE_SECOND;
                    reg_addr_vld <= 1;
                    rd_req <= 1;
                    state <= IDLE;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

// 处理读取的数据
always @(posedge clk or posedge rst) begin
    if (rst) begin
        old_minute <= 0;
        old_second <= 0;
        old_minute_second <= 0;
    end else if (rd_data_vld) begin
        case (state)
            READ_SECOND: old_minute <= rd_data[5:0];
            READ_MS: old_second <= rd_data[5:0];
            IDLE: old_minute_second <= rd_data[3:0];
        endcase
    end
end

key_proc key_init(
    .clk(clk),
    .rst(rst),
    .key(key),
    .mode(mode),
    .led(led),
    .min(min),
    .sec(sec),
    .ms(ms),
    .old_min(old_minute),
    .old_sec(old_second),
    .old_ms(old_minute_second),
    .e2prom_start(e2prom_start)
);

smg_proc seg_init(
    .clk(clk),
    .rst(rst),
    .num({4'd10,min_ten,min_one,4'd11,sec_ten,sec_one,4'd11,ms}),
    .dp(dp),
    .wei_la(wei),
    .duan_la(duan)
);

//eeprom module 
e2prom inst_eeprom(
	.clk		 		(sys_clk)		,
	.rst	     		(~rst)			,
	.wr_req      		(wr_req)		,
	.rd_req      		(rd_req)		,	//read data from EEPROM
	.device_id   		()				,
	.reg_addr    		(reg_addr)		,
	.reg_addr_vld		(reg_addr_vld)  ,
	.wr_data     		(wr_data)		,
	.wr_data_vld 		(1'd1)	        ,
	.rd_data     		(rd_data)		,
	.rd_data_vld 		(rd_data_vld)	,
	.ready       		(ready)			,
	.scl         		(scl)			,
	.sda         		(sda)
);
endmodule
