module smg_proc
(
    input [3:0]num,
    input rst,
    input en_dp,
    input [2:0]position,
    output reg [7:0]wei,
    output reg [7:0]duan
);

    localparam [7:0] SEG_0=8'b1100_0000 ;
    localparam [7:0] SEG_1=8'b1111_1001 ;
    localparam [7:0] SEG_2=8'b1010_0100 ;
    localparam [7:0] SEG_3=8'b1011_0000 ;
    localparam [7:0] SEG_4=8'b1001_1001 ;
    localparam [7:0] SEG_5=8'b1001_0010 ;
    localparam [7:0] SEG_6=8'b1000_0010 ;
    localparam [7:0] SEG_7=8'b1111_1000 ;
    localparam [7:0] SEG_8=8'b1000_0000 ;
    localparam [7:0] SEG_9=8'b1001_0000 ;
    localparam [7:0] SEG_GANG=8'b1011_1111 ;
    localparam [7:0] SEG_MIE = 8'b1111_1111;  //灭

    always @(*) begin
        if(rst)begin
            wei <= 8'hFF;
            duan <= 8'hFF;
        end
        else begin
            case (num)
                4'd0: duan <= SEG_0;
                4'd1: duan <= SEG_1;
                4'd2: duan <= SEG_2;
                4'd3: duan <= SEG_3;
                4'd4: duan <= SEG_4;
                4'd5: duan <= SEG_5;
                4'd6: duan <= SEG_6;
                4'd7: duan <= SEG_7;
                4'd8: duan <= SEG_8;
                4'd9: duan <= SEG_9;
                4'd10: duan <= SEG_GANG;
                default:duan<= SEG_MIE;
            endcase
            if(en_dp)
				duan[7]<=1'b0;
				
            wei <= ~(1 << position);
        end
    end
endmodule