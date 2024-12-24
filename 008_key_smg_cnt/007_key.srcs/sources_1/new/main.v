module main
(
    input   clk,
    input   rst,
    input   [3:0]key,
    output  [7:0]led,
    output  [7:0]duan,
    output  [7:0]wei
);
    
    wire [3:0]mode;
    reg [31:0]smg_tmp;
    wire [7:0]dp;

    wire [10:0]date;
    wire [3:0]date_3;
    wire [3:0]date_2;
    wire [3:0]date_1;

    assign date_3 = date/100 %10;
    assign date_2 = date/10 %10;
    assign date_1 = date%10;

    assign dp = 8'b1000_0100;

    key_proc key_init
    (
        .clk(clk),
        .rst(rst),
        .key_in(key),
        .mode(mode),
        .date(date)
    );
    
    led_proc led_init
    (
        .clk(clk),
        .rst(rst),
        .led(led),
        .mode(mode)
     );
     

    always @(posedge clk or posedge rst)begin
        if(rst)begin
            smg_tmp={4'd11,4'd11,4'd11,4'd11,4'd11,4'd11,4'd11,4'd11};
        end
        else begin
            case(mode)
                4'd0: smg_tmp={4'd1,4'd10,4'd9,4'd8,4'd10,date_3,date_2,date_1};
                4'd1: smg_tmp={4'd2,4'd10,4'd9,4'd8,4'd10,date_3,date_2,date_1};
                4'd2: smg_tmp={4'd3,4'd10,4'd9,4'd8,4'd10,date_3,date_2,date_1};
                4'd3: smg_tmp={4'd4,4'd10,4'd9,4'd8,4'd10,date_3,date_2,date_1};
            endcase
        end
    end

    smg_ctrl smg_init
    (
        .clk(clk),
        .rst(rst),
        .num(smg_tmp),
        .dp(dp),
        .wei(wei),
        .duan(duan)
    );

endmodule
