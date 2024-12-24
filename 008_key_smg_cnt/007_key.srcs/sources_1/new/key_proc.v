module key_proc
(
    input clk, rst,
    input [3:0] key_in,
    output reg [3:0]mode, 
    output reg [10:0]date
);

    parameter   key_val_S1 = 4'b0001,
                key_val_S2 = 4'b0010,
                key_val_S3 = 4'b0100,
                key_val_S4 = 4'b1000,
                key_val_no = 4'b1111;

    parameter   IDLE = 2'd0,
                DOWN = 2'd1,
                UP   = 2'd2;

    reg [3:0] key_state;
    reg [3:0] key_val;
    reg [19:0]key_cnt;

    wire clk_1khz;//1ms

    time_proc key_time
    (
        .clk(clk),
        .rst(rst),
        .clkbase(50_000_000),
        .clkdiv(1000),
        .clkout(clk_1khz)
    );

    always @(posedge clk_1khz or posedge rst) begin
        if(rst)begin
            key_cnt<=0;
        end else begin
            if(key_cnt == 20-1)
                key_cnt<=0;
            else
                key_cnt<=key_cnt+1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            key_state<=IDLE;
            key_val<=key_val_no;
        end else begin
            if(key_val == key_val_no)begin//键值有效
                if(key_cnt == 20-1)begin
                    case(key_state)
                        IDLE:begin
                            if(key_in != key_val_no) key_state<=DOWN;
                        end
                        DOWN:begin
                            case(key_in)
                                4'b1110: begin key_val<=key_val_S1;key_state<=UP;end
                                4'b1101: begin key_val<=key_val_S2;key_state<=UP;end
                                4'b1011: begin key_val<=key_val_S3;key_state<=UP;end
                                4'b0111: begin key_val<=key_val_S4;key_state<=UP;end
                                default: begin key_val<=key_val_no;key_state<=IDLE;end
                            endcase
                        end
                        UP:begin
                            if(key_in == 4'b1111)  
                                key_state<=IDLE;
                        end
                    endcase
                end
            end
            else begin//键值无效
                key_val<=key_val_no;//按键清零
            end
        end
    end

    always @(posedge clk or posedge rst) begin//按键切换模式
        if(rst)begin
            mode<= 0;
        end else begin
            case (mode)
                4'd0:begin
                    case(key_val)
                    key_val_S1:mode<=4'd0;
                    key_val_S2:mode<=4'd1;
                    key_val_S3:date <= (date + 11'd50 > 11'd999) ? 11'd999 : date + 11'd50;
                    key_val_S4:date <= (date - 11'd50 > 11'd999) ? 11'd0 : date - 11'd50;
                    endcase
                end
                4'd1:begin
                    case(key_val)
                    key_val_S1:mode<=4'd0;
                    key_val_S2:mode<=4'd1;
                    key_val_S3:date <= (date + 11'd20 > 11'd999) ? 11'd999 : date + 11'd20;
                    key_val_S4:date <= (date - 11'd20 > 11'd999) ? 11'd0 : date - 11'd20;
                    endcase
                end
                4'd2:begin
                    case(key_val)
                    key_val_S1:mode<=4'd0;
                    key_val_S2:mode<=4'd1;
                    key_val_S3:mode<=4'd2;
                    key_val_S4:mode<=4'd3;
                    endcase
                end
                4'd3:begin
                    case(key_val)
                    key_val_S1:mode<=4'd0;
                    key_val_S2:mode<=4'd1;
                    key_val_S3:mode<=4'd2;
                    key_val_S4:mode<=4'd3;
                    endcase
                end
            endcase
        end
    end
    
endmodule