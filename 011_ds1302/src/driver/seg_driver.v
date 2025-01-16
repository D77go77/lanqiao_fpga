module seg_driver (
    input  wire [3:0] digit,        // �����ʮ�������֣�0-9��
    input  wire       rst_n,        // ��λ�źţ��͵�ƽ��Ч��
    input  wire       current_dp,   // С����ʹ���ź�
    input  wire [2:0] position,     // ��ǰ��ʾ��λ
    output reg  [7:0] digit_sel,    // λѡ�ź�
    output reg  [7:0] segment_data  // ��ѡ�ź�
);

    // ���붨�壨ÿ�����ֶ�Ӧ���߶���ʾ���룩
    localparam [7:0] SEG_0 = 8'b1100_0000;  //0
    localparam [7:0] SEG_1 = 8'b1111_1001;  //1
    localparam [7:0] SEG_2 = 8'b1010_0100;  //2
    localparam [7:0] SEG_3 = 8'b1011_0000;  //3
    localparam [7:0] SEG_4 = 8'b1001_1001;  //4
    localparam [7:0] SEG_5 = 8'b1001_0010;  //5
    localparam [7:0] SEG_6 = 8'b1000_0010;  //6
    localparam [7:0] SEG_7 = 8'b1111_1000;  //7
    localparam [7:0] SEG_8 = 8'b1000_0000;  //8
    localparam [7:0] SEG_9 = 8'b1001_0000;  //9
    localparam [7:0] SEG_NULL = 8'b1111_1111;  //��
    localparam [7:0] SEG_GANE = 8'hBF;  //��

    // ������������ֺ�С����״̬���ɶ���
    always @(*) begin
        if (!rst_n) begin
            segment_data <= 8'b1111_1111;  // ��λʱϨ�����ж���
            digit_sel <= 8'b1111_1111;  // ��λʱ�ر�����λѡ
        end else begin
            // �������������ѡ���Ӧ�Ķ���
            case (digit)
                4'd0: segment_data = SEG_0;
                4'd1: segment_data = SEG_1;
                4'd2: segment_data = SEG_2;
                4'd3: segment_data = SEG_3;
                4'd4: segment_data = SEG_4;
                4'd5: segment_data = SEG_5;
                4'd6: segment_data = SEG_6;
                4'd7: segment_data = SEG_7;
                4'd8: segment_data = SEG_8;
                4'd9: segment_data = SEG_9;
                4'd10: segment_data = SEG_NULL;  // ��
                4'd11:  segment_data = SEG_GANE;//-
                default: segment_data = SEG_NULL;  // ��Ч����ʱϨ�����ж���
            endcase

            // ��� decimal_en Ϊ 1���򼤻�С���㣨���λΪС����λ��
            if (current_dp) segment_data[7] = 1'b0;

            // ���ݵ�ǰλλ�� `position` ����λѡ�ź�
            digit_sel = ~(8'b0000_0001 << position);  // ��λ����
        end
    end

endmodule
