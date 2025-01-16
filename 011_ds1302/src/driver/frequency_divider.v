module frequency_divider (
    input  wire        clk,      // ����ʱ��
    input  wire        rst_n,    // �͵�ƽ��λ
    input  wire [31:0] clkbase,  // ��׼ʱ��Ƶ�ʣ���λ��Hz��������50MHz
    input  wire [31:0] clkdiv,   // �������Ƶ�ʣ���λ��Hz������1000����1kHz
    output reg         clkout    // ���ʱ��
);
    reg [31:0] counter;  // ������
    reg [31:0] limit;  // ��������ֵ

    // ����ÿ����Ƶ���ڵļ�������
    always @* begin
        if (clkdiv > 0) begin
            limit = clkbase / (2 * clkdiv);  // �����Ƶ����
        end else begin
            limit = 0;  // ��ֹ������
        end
    end

    // �����߼�
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;  // ��λ������
            clkout  <= 0;  // ��λ���ʱ��
        end else begin
            if (limit > 0) begin
                if (counter >= limit - 1) begin
                    clkout  <= ~clkout;  // ��ת���ʱ��
                    counter <= 0;  // ����������
                end else begin
                    counter <= counter + 1;  // ��������һ
                end
            end
        end
    end
endmodule
