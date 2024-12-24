module test_tb;
    parameter CLK_PERIOD = 10; // 假设时钟周期为10个时间单位
    
    // 声明信号
    reg clk;
    reg rst;
    reg [3:0] key;
    wire [7:0] duan;
    wire [7:0] wei;
    wire led;
    wire scl;
    wire [7:0] sda;

    // 实例化被测试模块
    main uut (
        .clk(clk),
        .rst(rst),
        .key(key),
        .duan(duan),
        .wei(wei),
        .led(led),
        .scl(scl),
        .sda(sda)
    );

    // 生成时钟信号
    initial begin
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end

    // 监控state的变化
    initial begin
        $monitor("Time: %0t, State: %b", $time, uut.state);
    end

    // 监控EEPROM写操作
    initial begin
        $monitor("Time: %0t, wr_req: %b, wr_data: %h", $time, uut.wr_req, uut.wr_data);
    end

    // 测试序列
    initial begin
        // 初始化输入
        rst = 1;
        key = 4'b0000;
        
        // 等待一个时钟周期后释放复位
        #CLK_PERIOD rst = 0;
        
        // 按下启动键，启动模式
        key = 4'b0001;  // 假设特定的启动键值
        #CLK_PERIOD;
        
        // 释放启动键，观察一段时间后停止模式
        key = 4'b0000;
        #(CLK_PERIOD * 10);  // 观察10个时钟周期后是否停止
        
        // 更改模式，观察EEPROM的读写操作
        #CLK_PERIOD;
        key = 4'b0001;  // 假设特定的模式切换键值
        #(CLK_PERIOD * 5);  // 观察模式切换后的操作
        
        // 结束仿真
        #(CLK_PERIOD * 10) $finish;
    end
endmodule