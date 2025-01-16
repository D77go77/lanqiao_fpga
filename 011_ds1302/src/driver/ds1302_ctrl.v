module ds1302_ctrl (
    input wire rst,  // ��λ�źţ��ߵ�ƽ��Ч����λ���мĴ�����״̬
    input wire clk,  // ʱ���źţ�����ͬ���߼�����

    output wire ds1302_ce,    // DS1302 оƬʹ���źţ��ߵ�ƽ��Ч�����ڼ��� DS1302
    output wire ds1302_sclk,  // DS1302 ����ʱ���źţ�����ͬ���������ݴ���
    inout  wire ds1302_io,    // DS1302 ˫�������ߣ��������ݴ���

    input wire write_time_req,  // д��ʱ�������źţ��ߵ�ƽ��ʾ��ʼдʱ�����
    output wire write_time_ack,  // д��ʱ�������Ӧ�źţ��ߵ�ƽ��ʾд�����
    input wire [7:0] write_second,  // Ҫд�����ֵ (0-59)������ BCD ����
    input wire [7:0] write_minute,  // Ҫд��ķ�ֵ (0-59)������ BCD ����
    input wire [7:0] write_hour,  // Ҫд���Сʱֵ (0-23)������ BCD ����
    input wire [7:0] write_date,  // Ҫд�������ֵ (1-31)������ BCD ����
    input wire [7:0] write_month,  // Ҫд����·�ֵ (1-12)������ BCD ����
    input wire [7:0] write_week,  // Ҫд�������ֵ (1-7)������ BCD ����
    input wire [7:0] write_year,  // Ҫд������ֵ (0-99)������ BCD ����

    input wire read_time_req,  // ��ȡʱ�������źţ��ߵ�ƽ��ʾ��ʼ��ȡʱ�����
    output wire read_time_ack,  // ��ȡʱ�������Ӧ�źţ��ߵ�ƽ��ʾ��ȡ���
    output reg [7:0] read_second,  // �� DS1302 ��ȡ����ֵ������ BCD ����
    output reg [7:0] read_minute,  // �� DS1302 ��ȡ�ķ�ֵ������ BCD ����
    output reg [7:0] read_hour,  // �� DS1302 ��ȡ��Сʱֵ������ BCD ����
    output reg [7:0] read_date,  // �� DS1302 ��ȡ������ֵ������ BCD ����
    output reg [7:0] read_month,  // �� DS1302 ��ȡ���·�ֵ������ BCD ����
    output reg [7:0] read_week,  // �� DS1302 ��ȡ������ֵ������ BCD ����
    output reg [7:0] read_year  // �� DS1302 ��ȡ�����ֵ������ BCD ����
);

    // ״̬�����壬���ڿ������ݴ���ĸ�������
    localparam S_IDLE = 0;  // ����״̬���ȴ���/д����
    localparam S_WR_WP = 1;  // д��д�����Ĵ���������д����
    localparam S_WR_SEC = 2;  // д��������
    localparam S_WR_MIN = 3;  // д���������
    localparam S_WR_HOUR = 4;  // д��Сʱ����
    localparam S_WR_DATE = 5;  // д����������
    localparam S_WR_MON = 6;  // д���·�����
    localparam S_WR_WEEK = 7;  // д����������
    localparam S_WR_YEAR = 8;  // д���������
    localparam S_RD_SEC = 9;  // ��ȡ������
    localparam S_RD_MIN = 10;  // ��ȡ��������
    localparam S_RD_HOUR = 11;  // ��ȡСʱ����
    localparam S_RD_DATE = 12;  // ��ȡ��������
    localparam S_RD_MON = 13;  // ��ȡ�·�����
    localparam S_RD_WEEK = 14;  // ��ȡ��������
    localparam S_RD_YEAR = 15;  // ��ȡ�������
    localparam S_ACK = 16;  // Ӧ��״̬����ʾ�������

    // �Ĵ������źŶ���
    reg [4:0] state, next_state;  // ��ǰ״̬����һ��״̬
    reg  [7:0] read_addr;  // ��ȡ��ַ����Ӧ DS1302 �Ĵ���
    reg  [7:0] write_addr;  // д���ַ����Ӧ DS1302 �Ĵ���
    reg  [7:0] write_data;  // д�������
    reg        cmd_write;  // д����ߵ�ƽ��ʾд����
    reg        cmd_read;  // ������ߵ�ƽ��ʾ������
    wire [7:0] read_data;  // �� DS1302 �ӿڶ�ȡ������
    wire       cmd_read_ack;  // ����������ź�
    wire       cmd_write_ack;  // д��������ź�

    // дʱ������źţ��ߵ�ƽ��ʾ״̬���������д����
    assign write_time_ack = (state == S_ACK);
    // ��ʱ������źţ��ߵ�ƽ��ʾ״̬��������ж�����
    assign read_time_ack  = (state == S_ACK);

    // д��������߼���״̬����д����״̬ʱ���� cmd_write �ź�
    always @(posedge clk or posedge rst) begin
        if (rst) cmd_write <= 1'b0;  // ��λʱ����д����
        else if (cmd_write_ack) cmd_write <= 1'b0;  // д������ɺ�����д����
        else
            case (state)
                S_WR_WP, S_WR_SEC, S_WR_MIN, S_WR_HOUR, S_WR_DATE, S_WR_MON, S_WR_WEEK, S_WR_YEAR:
                cmd_write <= 1'b1;  // ��д�����״̬ʱ����д����
            endcase
    end

    // ����������߼���״̬���ڶ�����״̬ʱ���� cmd_read �ź�
    always @(posedge clk or posedge rst) begin
        if (rst) cmd_read <= 1'b0;  // ��λʱ���������
        else if (cmd_read_ack) cmd_read <= 1'b0;  // ��������ɺ����������
        else
            case (state)
                S_RD_SEC, S_RD_MIN, S_RD_HOUR, S_RD_DATE, S_RD_MON, S_RD_WEEK, S_RD_YEAR:
                cmd_read <= 1'b1;  // �ڶ�ȡ���״̬ʱ���߶�����
            endcase
    end

    // ������������ݣ�����״̬���Ķ���������źţ����¶�Ӧ�ļĴ���
    always @(posedge clk or posedge rst) begin
        if (rst) read_second <= 8'h00;  // ��λʱ������ֵ
        else if (state == S_RD_SEC && cmd_read_ack)
            read_second <= read_data;  // �����ȡ���ʱ������ֵ
    end

    always @(posedge clk or posedge rst) begin
        if (rst) read_minute <= 8'h00;  // ��λʱ�������ֵ
        else if (state == S_RD_MIN && cmd_read_ack)
            read_minute <= read_data;  // �ڷ��Ӷ�ȡ���ʱ���·���ֵ
    end

    // ���Ƶ��߼�Ӧ��������ʱ������ (Сʱ�����ڡ��·ݡ����ڡ����)
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

    // ���ö�ȡ��ַ�����ݵ�ǰ״̬���� DS1302 �Ķ�ȡ��ַ
    always @(posedge clk or posedge rst) begin
        if (rst) read_addr <= 8'h00;
        else
            case (state)
                S_RD_SEC:  read_addr <= 8'h81;  // ��Ĵ�����ַ (������)
                S_RD_MIN:  read_addr <= 8'h83;  // �ּĴ�����ַ (������)
                S_RD_HOUR: read_addr <= 8'h85;  // Сʱ�Ĵ�����ַ (������)
                S_RD_DATE: read_addr <= 8'h87;  // ���ڼĴ�����ַ (������)
                S_RD_MON:  read_addr <= 8'h89;  // �·ݼĴ�����ַ (������)
                S_RD_WEEK: read_addr <= 8'h8b;  // ���ڼĴ�����ַ (������)
                S_RD_YEAR: read_addr <= 8'h8d;  // ��ݼĴ�����ַ (������)
                default:   read_addr <= read_addr;  // Ĭ�ϱ��ֲ���
            endcase
    end

    // д�����ĵ�ַ����������
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_addr <= 8'h00;  // ��λʱ����д��ַ
            write_data <= 8'h00;  // ��λʱ����д����
        end else
            case (state)
                S_WR_WP: begin
                    write_addr <= 8'h8e;  // д�����Ĵ�����ַ
                    write_data <= 8'h00;  // ����д����
                end
                S_WR_SEC: begin
                    write_addr <= 8'h80;  // ��Ĵ�����ַ
                    write_data <= write_second;  // д����ֵ
                end
                S_WR_MIN: begin
                    write_addr <= 8'h82;  // �ּĴ�����ַ
                    write_data <= write_minute;  // д�����ֵ
                end
                S_WR_HOUR: begin
                    write_addr <= 8'h84;  // Сʱ�Ĵ�����ַ
                    write_data <= write_hour;  // д��Сʱֵ
                end
                S_WR_DATE: begin
                    write_addr <= 8'h86;  // ���ڼĴ�����ַ
                    write_data <= write_date;  // д������ֵ
                end
                S_WR_MON: begin
                    write_addr <= 8'h88;  // �·ݼĴ�����ַ
                    write_data <= write_month;  // д���·�ֵ
                end
                S_WR_WEEK: begin
                    write_addr <= 8'h8a;  // ���ڼĴ�����ַ
                    write_data <= write_week;  // д������ֵ
                end
                S_WR_YEAR: begin
                    write_addr <= 8'h8c;  // ��ݼĴ�����ַ
                    write_data <= write_year;  // д�����ֵ
                end
                default: begin
                    write_addr <= 8'h00;  // Ĭ������д��ַ
                    write_data <= 8'h00;  // Ĭ������д����
                end
            endcase
    end

    // ״̬�������߼������ݵ�ǰ״̬��������ת����һ��״̬
    always @(posedge clk or posedge rst) begin
        if (rst) state <= S_IDLE;  // ��λʱ�������״̬
        else state <= next_state;  // ���������һ��״̬
    end

    always @(*) begin
        case (state)
            S_IDLE:
            if (write_time_req)
                next_state <= S_WR_WP;  // �����д���󣬽���д����״̬
            else if (read_time_req)
                next_state <= S_RD_SEC;  // ����ж����󣬽����ȡ��״̬
            else next_state <= S_IDLE;  // �������򱣳ֿ���
            S_WR_WP:
            if (cmd_write_ack) next_state <= S_WR_SEC;  // д������ɺ󣬽���д��״̬
            else next_state <= S_WR_WP;
            S_WR_SEC:
            if (cmd_write_ack) next_state <= S_WR_MIN;  // д����ɺ󣬽���д����״̬
            else next_state <= S_WR_SEC;
            S_WR_MIN:
            if (cmd_write_ack)
                next_state <= S_WR_HOUR;  // д������ɺ󣬽���дСʱ״̬
            else next_state <= S_WR_MIN;
            S_WR_HOUR:
            if (cmd_write_ack)
                next_state <= S_WR_DATE;  // дСʱ��ɺ󣬽���д����״̬
            else next_state <= S_WR_HOUR;
            S_WR_DATE:
            if (cmd_write_ack)
                next_state <= S_WR_MON;  // д������ɺ󣬽���д�·�״̬
            else next_state <= S_WR_DATE;
            S_WR_MON:
            if (cmd_write_ack)
                next_state <= S_WR_WEEK;  // д�·���ɺ󣬽���д����״̬
            else next_state <= S_WR_MON;
            S_WR_WEEK:
            if (cmd_write_ack)
                next_state <= S_WR_YEAR;  // д������ɺ󣬽���д���״̬
            else next_state <= S_WR_WEEK;
            S_WR_YEAR:
            if (cmd_write_ack) next_state <= S_ACK;  // д�����ɺ󣬽���Ӧ��״̬
            else next_state <= S_WR_YEAR;
            S_RD_SEC:
            if (cmd_read_ack)
                next_state <= S_RD_MIN;  // ��ȡ����ɺ󣬽����ȡ����״̬
            else next_state <= S_RD_SEC;
            S_RD_MIN:
            if (cmd_read_ack)
                next_state <= S_RD_HOUR;  // ��ȡ������ɺ󣬽����ȡСʱ״̬
            else next_state <= S_RD_MIN;
            S_RD_HOUR:
            if (cmd_read_ack)
                next_state <= S_RD_DATE;  // ��ȡСʱ��ɺ󣬽����ȡ����״̬
            else next_state <= S_RD_HOUR;
            S_RD_DATE:
            if (cmd_read_ack)
                next_state <= S_RD_MON;  // ��ȡ������ɺ󣬽����ȡ�·�״̬
            else next_state <= S_RD_DATE;
            S_RD_MON:
            if (cmd_read_ack)
                next_state <= S_RD_WEEK;  // ��ȡ�·���ɺ󣬽����ȡ����״̬
            else next_state <= S_RD_MON;
            S_RD_WEEK:
            if (cmd_read_ack)
                next_state <= S_RD_YEAR;  // ��ȡ������ɺ󣬽����ȡ���״̬
            else next_state <= S_RD_WEEK;
            S_RD_YEAR:
            if (cmd_read_ack) next_state <= S_ACK;  // ��ȡ�����ɺ󣬽���Ӧ��״̬
            else next_state <= S_RD_YEAR;
            S_ACK: next_state <= S_IDLE;  // Ӧ����ɺ󣬷��ؿ���״̬
            default: next_state <= S_IDLE;  // Ĭ�Ϸ��ؿ���״̬
        endcase
    end

    // ʵ���� DS1302 �ӿ�ģ�飬������оƬ����ͨ��
    ds1302_io ds1302_io_m0 (
        .clk          (clk),            // ʱ���ź�
        .rst          (rst),            // ��λ�ź�
        .ds1302_ce    (ds1302_ce),      // DS1302 оƬʹ���ź�
        .ds1302_sclk  (ds1302_sclk),    // DS1302 ����ʱ���ź�
        .ds1302_io    (ds1302_io),      // DS1302 ˫��������
        .cmd_read     (cmd_read),       // �������ź�
        .cmd_write    (cmd_write),      // д�����ź�
        .cmd_read_ack (cmd_read_ack),   // ����������ź�
        .cmd_write_ack(cmd_write_ack),  // д��������ź�
        .read_addr    (read_addr),      // ��ȡ��ַ
        .write_addr   (write_addr),     // д���ַ
        .read_data    (read_data),      // ��ȡ����
        .write_data   (write_data)      // д������
    );

endmodule
