module smg_ctrl(
    input      [3:0] digit,        // 输入的十进制数字（0-9）
    input            rst,        // 复位信号（低电平有效）
    input            en_dp,   // 小数点使能信号
    input      [2:0] position,     // 当前显示的位
    output reg [7:0] wei,    // 位选信号
    output reg [7:0] duan  // 段选信号
);
    // 段码定义（每个数字对应的七段显示编码）
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
    localparam [7:0] SEG_P = 8'b1000_1100;  //P
    localparam [7:0] SEG_gang = 8'b1011_1111;  //-
    localparam [7:0] SEG_NULL = 8'b1111_1111;  //灭

    always @(*) begin
        if(rst)begin
            wei<=8'b1111_1111;
            duan<=8'b1111_1111;
        end
        else begin
            case(digit)
                4'd0: duan = SEG_0;
                4'd1: duan = SEG_1;
                4'd2: duan = SEG_2;
                4'd3: duan = SEG_3;
                4'd4: duan = SEG_4;
                4'd5: duan = SEG_5;
                4'd6: duan = SEG_6;
                4'd7: duan = SEG_7;
                4'd8: duan = SEG_8;
                4'd9: duan = SEG_9;
                4'd10: duan = SEG_P;
                4'd11: duan = SEG_gang;
                default: duan = 8'b1111_1111;  // 无效输入时熄灭所有段码
            endcase
            // 如果 en_dp 为 1，则激活小数点（最高位为小数点位）
            if (en_dp) duan[7] = 1'b0;

            // 根据当前位位置 `position` 控制位选信号
            wei = ~(8'b0000_0001 << position);  // 按位激活
        end
    end

endmodule