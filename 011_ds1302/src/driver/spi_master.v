module spi_master (
    input  wire        clk,       // ����ʱ���źţ��������� SPI ������ʱ���߼�
    input  wire        rst,       // ��λ�źţ��ߵ�ƽ��Ч
    output wire        nCS,       // SPI ���豸ѡ���ź� (�͵�ƽ��Ч)
    output wire        DCLK,      // SPI ʱ���ź�
    output wire        MOSI,      // SPI ������������ź� (��������)
    input  wire        MISO,      // SPI �����������ź� (��������)
    input  wire        CPOL,      // SPI ʱ�Ӽ��� (Clock Polarity)
    input  wire        CPHA,      // SPI ʱ����λ (Clock Phase)
    input  wire        nCS_ctrl,  // ���豸ѡ���źſ����ź�
    input  wire [15:0] clk_div,   // ʱ�ӷ�Ƶֵ�����ڿ��� SPI ʱ��Ƶ��
    input  wire        wr_req,    // д�����źţ��ߵ�ƽ��Ч
    output wire        wr_ack,    // д����źţ��ߵ�ƽ��ʾд�������
    input  wire [ 7:0] data_in,   // ��������ݣ���Ҫͨ�� SPI ����
    output wire [ 7:0] data_out   // ��������ݣ��� SPI ����
);

    // �Ĵ�������
    reg        DCLK_reg;  // ʱ�ӼĴ��������� SPI ʱ���ź�
    reg [ 7:0] MOSI_shift;  // MOSI ������λ�Ĵ��������ڷ�������
    reg [ 7:0] MISO_shift;  // MISO ������λ�Ĵ��������ڽ�������
    reg [ 2:0] state;  // ��ǰ״̬
    reg [ 2:0] next_state;  // ��һ״̬
    reg [15:0] clk_cnt;  // SPI ʱ�ӷ�Ƶ������
    reg [ 4:0] clk_edge_cnt;  // SPI ʱ�ӱ��ؼ���������������λ����

    // ״̬����
    localparam IDLE = 0;  // ����״̬
    localparam DCLK_EDGE = 1;  // SPI ʱ������/�½����ش���״̬
    localparam DCLK_IDLE = 2;  // SPI ʱ�Ӵ��ڿ�������
    localparam ACK = 3;  // ȷ�����״̬
    localparam LAST_HALF_CYCLE = 4;  // �����ʱ������״̬
    localparam ACK_WAIT = 5;  // �ȴ�ȷ��״̬

    // ����źŷ���
    assign MOSI = MOSI_shift[7];  // ������������λ�Ĵ��������λ��Ϊ MOSI ���
    assign data_out  = MISO_shift;     // �����յ���������λ�Ĵ�������������� data_out
    assign nCS = nCS_ctrl;  // �� nCS_ctrl ���� nCS �ź�
    assign DCLK = DCLK_reg;  // SPI ʱ���ź�
    assign wr_ack = (state == ACK);  // ��״̬Ϊ ACK ʱ������ wr_ack �źű�ʾд���

    // ״̬���߼������µ�ǰ״̬
    always @(posedge clk or posedge rst) begin
        if (rst) state <= IDLE;  // ��λʱ�������״̬
        else state <= next_state;  // ���������һ״̬
    end

    // ״̬���߼���ȷ����һ״̬
    always @(*) begin
        case (state)
            IDLE:
            if (wr_req == 1'b1)
                next_state <= DCLK_IDLE;  // �����д���󣬽���ʱ�ӿ�������
            else next_state <= IDLE;  // ���򱣳ֿ���״̬
            DCLK_IDLE:
            if (clk_cnt == clk_div)
                next_state <= DCLK_EDGE;  // ʱ�ӷ�Ƶ��ɺ����ʱ�ӱ���״̬
            else next_state <= DCLK_IDLE;
            DCLK_EDGE:
            if (clk_edge_cnt == 5'd15)
                next_state <= LAST_HALF_CYCLE; // ���ͻ������ɺ���������ʱ������
            else next_state <= DCLK_IDLE;
            LAST_HALF_CYCLE:
            if (clk_cnt == clk_div)
                next_state <= ACK;  // �����ʱ��������ɺ����ȷ��״̬
            else next_state <= LAST_HALF_CYCLE;
            ACK: next_state <= ACK_WAIT;  // ����ȴ�ȷ��״̬
            ACK_WAIT: next_state <= IDLE;  // �ȴ���ɺ󷵻ؿ���״̬
            default: next_state <= IDLE;  // Ĭ�Ϸ��ؿ���״̬
        endcase
    end

    // ʱ���źſ����߼�
    always @(posedge clk or posedge rst) begin
        if (rst) DCLK_reg <= 1'b0;  // ��λʱ����ΪĬ�ϼ���
        else if (state == IDLE) DCLK_reg <= CPOL;  // ����ʱ����Ϊ CPOL ����ļ���
        else if (state == DCLK_EDGE) DCLK_reg <= ~DCLK_reg;  // ʱ�ӱ���ʱ��תʱ���ź�
    end

    // ʱ�ӷ�Ƶ������
    always @(posedge clk or posedge rst) begin
        if (rst) clk_cnt <= 16'd0;  // ��λʱ����
        else if (state == DCLK_IDLE || state == LAST_HALF_CYCLE)
            clk_cnt <= clk_cnt + 16'd1;  // ��ʱ�ӿ��л��������ڵ���������
        else clk_cnt <= 16'd0;  // ����״̬���������
    end

    // ʱ�ӱ��ؼ�����
    always @(posedge clk or posedge rst) begin
        if (rst) clk_edge_cnt <= 5'd0;  // ��λʱ����
        else if (state == DCLK_EDGE)
            clk_edge_cnt <= clk_edge_cnt + 5'd1;  // ��ʱ�ӱ���״̬����������
        else if (state == IDLE) clk_edge_cnt <= 5'd0;  // ����״̬���������
    end

    // MOSI ������λ�Ĵ���
    always @(posedge clk or posedge rst) begin
        if (rst) MOSI_shift <= 8'd0;  // ��λʱ����
        else if (state == IDLE && wr_req)
            MOSI_shift <= data_in;  // �ڿ���״̬���յ�д����ʱ��������
        else if (state == DCLK_EDGE)
            if (CPHA == 1'b0 && clk_edge_cnt[0] == 1'b1)
                MOSI_shift <= {
                    MOSI_shift[6:0], MOSI_shift[7]
                };  // CPHA = 0����ʱ����Ч������λ
            else if (CPHA == 1'b1 && clk_edge_cnt != 5'd0 && clk_edge_cnt[0] == 1'b0)
                MOSI_shift <= {
                    MOSI_shift[6:0], MOSI_shift[7]
                };  // CPHA = 1����ʱ��ʧЧ������λ
    end

    // MISO ������λ�Ĵ���
    always @(posedge clk or posedge rst) begin
        if (rst) MISO_shift <= 8'd0;  // ��λʱ����
        else if (state == IDLE && wr_req)
            MISO_shift <= 8'h00;  // �ڿ���״̬���յ�д����ʱ��������
        else if (state == DCLK_EDGE)
            if (CPHA == 1'b0 && clk_edge_cnt[0] == 1'b0)
                MISO_shift <= {MISO_shift[6:0], MISO};  // CPHA = 0����ʱ��ʧЧ���ز���
            else if (CPHA == 1'b1 && clk_edge_cnt[0] == 1'b1)
                MISO_shift <= {MISO_shift[6:0], MISO};  // CPHA = 1����ʱ����Ч���ز���
    end

endmodule
