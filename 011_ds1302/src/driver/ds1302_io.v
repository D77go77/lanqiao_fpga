module ds1302_io (
    input  wire       clk,            // ʱ���źţ�����ͬ���߼�
    input  wire       rst,            // ��λ�źţ��ߵ�ƽ��Ч
    output wire       ds1302_ce,      // DS1302 оƬʹ���źţ��ߵ�ƽ��Ч
    output wire       ds1302_sclk,    // DS1302 ����ʱ���ź�
    inout  wire       ds1302_io,      // DS1302 �����ߣ�˫��
    input  wire       cmd_read,       // �������źţ��ߵ�ƽ��ʾ������ȡ����
    input  wire       cmd_write,      // д�����źţ��ߵ�ƽ��ʾ����д�����
    output wire       cmd_read_ack,   // ����������źţ��ߵ�ƽ��ʾ��ȡ���
    output wire       cmd_write_ack,  // д��������źţ��ߵ�ƽ��ʾд�����
    input  wire [7:0] read_addr,      // ��ȡ��ַ����Ӧ DS1302 �ڲ��Ĵ���
    input  wire [7:0] write_addr,     // д���ַ����Ӧ DS1302 �ڲ��Ĵ���
    input  wire [7:0] write_data,     // д������
    output reg  [7:0] read_data       // ��ȡ��������
);

    // �Ĵ����ͱ�������
    reg [3:0] state, next_state;  // ��ǰ״̬����һ��״̬
    reg  [19:0] delay_cnt;  // ��ʱ�����������ڿ���ʱ����
    reg         wr_req;  // д�����źţ����� SPI ģ��
    reg  [ 7:0] send_data;  // Ҫͨ�� SPI ���͵�����
    reg         CS_reg;  // оƬʹ�ܼĴ��������ڿ��� nCS �ź�
    reg         ds1302_io_dir;  // �����߷�������ź�
    wire        DCLK;  // SPI ʱ���ź�
    wire        MOSI;  // SPI ������������ź�
    wire        MISO;  // SPI �����������ź�
    wire [ 7:0] data_rec;  // �� SPI ���յ�����
    wire        wr_ack;  // SPI д����ź�

    // ״̬��״̬����
    localparam S_IDLE = 0;  // ����״̬
    localparam S_CE_HIGH = 1;  // ���� CE �źţ����� DS1302
    localparam S_READ = 2;  // ������
    localparam S_READ_ADDR = 3;  // ���Ͷ�ȡ��ַ
    localparam S_READ_DATA = 4;  // ���ն�ȡ����
    localparam S_WRITE = 5;  // д����
    localparam S_WRITE_ADDR = 6;  // ����д���ַ
    localparam S_WRITE_DATA = 7;  // ����д������
    localparam S_CE_LOW = 8;  // ���� CE �źţ����� DS1302 ����
    localparam S_ACK = 9;  // Ӧ��״̬����ʾ�������

    // ˫�������ߵķ���
    assign ds1302_io = ~ds1302_io_dir ? MOSI : 1'bz;  // ���ݷ���Ϊ���ʱ����ֵΪ MOSI
    assign MISO = ds1302_io;  // ���ݷ���Ϊ����ʱ���� ds1302_io ��ȡ
    assign ds1302_sclk = DCLK;  // SPI ʱ�����ӵ� DS1302 ��ʱ��
    assign cmd_read_ack = (state == S_ACK);  // ������źţ���״̬Ϊ S_ACK ʱ��Ч
    assign cmd_write_ack = (state == S_ACK);  // д����źţ���״̬Ϊ S_ACK ʱ��Ч

    // ״̬���߼�
    always @(posedge clk or posedge rst) begin
        if (rst) state <= S_IDLE;  // ��λʱ�������״̬
        else state <= next_state;  // ���������һ��״̬
    end

    always @(*) begin
        case (state)
            S_IDLE:
            if (cmd_read || cmd_write)
                next_state <= S_CE_HIGH;  // �ж�д����ʱ������ CE ����״̬
            else next_state <= S_IDLE;  // ���򱣳ֿ���
            S_CE_HIGH:
            if (delay_cnt == 20'd255)
                next_state <= cmd_read ? S_READ : S_WRITE; // ��ʱ�����󣬸�������������д״̬
            else next_state <= S_CE_HIGH;
            S_READ: next_state <= S_READ_ADDR;  // �����ȡ��ַ״̬
            S_READ_ADDR:
            if (wr_ack)
                next_state <= S_READ_DATA;  // ��ַ������ɺ󣬽����ȡ����״̬
            else next_state <= S_READ_ADDR;
            S_READ_DATA:
            if (wr_ack) next_state <= S_ACK;  // ���ݶ�ȡ��ɺ󣬽���Ӧ��״̬
            else next_state <= S_READ_DATA;
            S_WRITE: next_state <= S_WRITE_ADDR;  // д����ʱ������д��ַ״̬
            S_WRITE_ADDR:
            if (wr_ack)
                next_state <= S_WRITE_DATA;  // ��ַ������ɺ󣬽���д����״̬
            else next_state <= S_WRITE_ADDR;
            S_WRITE_DATA:
            if (wr_ack) next_state <= S_ACK;  // ����д����ɺ󣬽���Ӧ��״̬
            else next_state <= S_WRITE_DATA;
            S_ACK: next_state <= S_CE_LOW;  // Ӧ����ɺ󣬽��� CE ����״̬
            S_CE_LOW:
            if (delay_cnt == 20'd255) next_state <= S_IDLE;  // ��ʱ�����󣬷��ؿ���״̬
            else next_state <= S_CE_LOW;
            default: next_state <= S_IDLE;  // Ĭ�Ϸ��ؿ���״̬
        endcase
    end

    // CE �źſ���
    always @(posedge clk or posedge rst) begin
        if (rst) CS_reg <= 1'b0;  // ��λʱ����
        else if (state == S_CE_HIGH) CS_reg <= 1'b1;  // �� CE ����״̬ʱ���� CE �ź�
        else if (state == S_CE_LOW) CS_reg <= 1'b0;  // �� CE ����״̬ʱȡ�� CE �ź�
    end

    // ��ʱ�����������ڿ��� CE �źŵ����ߺ�����ʱ��
    always @(posedge clk or posedge rst) begin
        if (rst) delay_cnt <= 20'd0;  // ��λʱ���������
        else if (state == S_CE_HIGH || state == S_CE_LOW)
            delay_cnt <= delay_cnt + 20'd1;  // �� CE �߻��״̬ʱ����
        else delay_cnt <= 20'd0;  // ����״̬���������
    end

    // д�����źţ����� SPI ģ��
    always @(posedge clk or posedge rst) begin
        if (rst) wr_req <= 1'b0;  // ��λʱ����
        else if (wr_ack) wr_req <= 1'b0;  // д��ɺ�����
        else if (state == S_READ_ADDR || state == S_READ_DATA || 
                 state == S_WRITE_ADDR || state == S_WRITE_DATA)
            wr_req <= 1'b1;  // �ڶ�д���״̬ʱ����д����
    end

    // ���ݷ������
    always @(posedge clk or posedge rst) begin
        if (rst) ds1302_io_dir <= 1'b0;  // ��λʱ����Ϊ�������
        else
            ds1302_io_dir <= (state == S_READ_DATA); // �ڶ�ȡ����״̬ʱ�л�Ϊ���뷽��
    end

    // ���ݶ�ȡ
    always @(posedge clk or posedge rst) begin
        if (rst) read_data <= 8'h00;  // ��λʱ�����ȡ����
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
            };  // ��ת��ȡ���ݵĸߵ�λ������ DS1302 �����ݸ�ʽ
    end

    // SPI ���������߼�
    always @(posedge clk or posedge rst) begin
        if (rst) send_data <= 8'h00;  // ��λʱ���㷢������
        else begin
            if (state == S_READ_ADDR)  // ����ַʱ�����ö���ַ��ʽ
                send_data <= {
                    1'b1,  // �������־
                    read_addr[1],  // ��ַλ
                    read_addr[2],
                    read_addr[3],
                    read_addr[4],
                    read_addr[5],
                    read_addr[6],
                    1'b1  // ��ַ����λ
                };
            else if (state == S_WRITE_ADDR)  // д��ַʱ������д��ַ��ʽ
                send_data <= {
                    1'b0,  // д�����־
                    write_addr[1],  // ��ַλ
                    write_addr[2],
                    write_addr[3],
                    write_addr[4],
                    write_addr[5],
                    write_addr[6],
                    1'b1  // ��ַ����λ
                };
            else if (state == S_WRITE_DATA)  // д����ʱ��ֱ�Ӵ���д������
                send_data <= {
                    write_data[0],  // ����λ
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

    // SPI ��ģ��ʵ����
    spi_master spi_master_m0 (
        .clk     (clk),        // ʱ���ź�
        .rst     (rst),        // ��λ�ź�
        .nCS     (ds1302_ce),  // SPI оƬʹ���ź�
        .DCLK    (DCLK),       // SPI ʱ���ź�
        .MOSI    (MOSI),       // SPI ������������ź�
        .MISO    (MISO),       // SPI �����������ź�
        .CPOL    (1'b0),       // SPI ʱ�Ӽ���
        .CPHA    (1'b0),       // SPI ʱ����λ
        .nCS_ctrl(CS_reg),     // CE �����ź�
        .clk_div (16'd50),     // ʱ�ӷ�Ƶϵ��
        .wr_req  (wr_req),     // д�����ź�
        .wr_ack  (wr_ack),     // д����ź�
        .data_in (send_data),  // Ҫ���͵�����
        .data_out(data_rec)    // ���յ�������
    );
endmodule
