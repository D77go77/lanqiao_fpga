module key_ctrl (
    input  wire       clk_100,  // ����ʱ���ź�(100Hz)
    input  wire       rst_n,    // �͵�ƽ��λ�ź�
    input  wire [3:0] key_in,   // 4 �����������ź�
    output reg  [3:0] down,     // �������¼���źţ��½��ش�����
    output reg  [3:0] up        // �����ͷż���źţ������ش�����
);

    reg [3:0] val;  // ��ǰ����״̬
    reg [3:0] old;  // ��һ��ʱ�����ڵİ���״̬

    // ����״̬����߼�
    always @(posedge clk_100 or negedge rst_n) begin
        if (!rst_n) begin
            // ��λʱ������״̬��Ϊδ����
            val  <= 4'b1111;    // ���谴��Ϊ�͵�ƽ��Ч����ʼ��Ϊ�ߵ�ƽδ����״̬
            old <= 4'b1111;  // ��һ��״̬��ʼ��Ϊ�ߵ�ƽ
            down <= 4'b0000;  // ��ʼʱû�а�������
            up <= 4'b0000;  // ��ʼʱû�а����ͷ�
        end else begin
            old <= val;  // ���浱ǰ״̬�� old �Ա���һ�����ڱȽ�
            val <= key_in;  // ���� val Ϊ��ǰ�İ���״̬

            // ��ⰴ�����£�val �� old �Ƚϣ��½��ؼ��
            down <= ~val & (val ^ old);  // val Ϊ���� val �� old ��ͬ��˵�������ձ�����

            // ��ⰴ���ͷţ�val �� old �Ƚϣ������ؼ��
            up   <= val & (val ^ old); // val Ϊ���� val �� old ��ͬ��˵�������ձ��ͷ�
        end
    end
endmodule
