`timescale 1ns / 1ps
module smg(
    input clk,
    input rst,

    output reg [7:0] seg,//duan
    output reg [7:0] sel//wei
    );

    parameter [7:0] DIGIT0 = 8'hC0;
    parameter [7:0] DIGIT1 = 8'hF9;
    parameter [7:0] DIGIT2 = 8'hA4;
    parameter [7:0] DIGIT3 = 8'hB0;
    parameter [7:0] DIGIT4 = 8'h99;
    parameter [7:0] DIGIT5 = 8'h92;
    parameter [7:0] DIGIT6 = 8'h82;
    parameter [7:0] DIGIT7 = 8'hF8;
    parameter [7:0] DIGIT8 = 8'h80;
    parameter [7:0] DIGIT9 = 8'h90;
    
    parameter [15:0] COUNT_MAX = 16'd50000;//1000hz
    reg [15:0] count;//计数++
    reg [3:0] bits;

    always @(posedge clk or posedge rst) begin
        if(rst) 
            count <= 0;
        else begin
            if(count == COUNT_MAX -1)
                count <= 0;
            else
                count <= count + 1;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst)begin
            seg <= 8'b1111_1111;
            sel <= 8'b1111_1111;
        end else begin
            if(count == COUNT_MAX -1)begin
                if(bits == 4'd8)
                    bits <= 0;
                else 
                    bits <= bits + 1;
                case (bits)
                    4'd0:begin sel <= 8'b1111_1110;seg <=DIGIT0; end
                    4'd1:begin sel <= 8'b1111_1101;seg <=DIGIT1; end
                    4'd2:begin sel <= 8'b1111_1011;seg <=DIGIT2; end
                    4'd3:begin sel <= 8'b1111_0111;seg <=DIGIT3; end
                    4'd4:begin sel <= 8'b1110_1111;seg <=DIGIT4; end
                    4'd5:begin sel <= 8'b1101_1111;seg <=DIGIT5; end
                    4'd6:begin sel <= 8'b1011_1111;seg <=DIGIT6; end
                    4'd7:begin sel <= 8'b0111_1111;seg <=DIGIT7; end
                    default:begin sel <= 8'b1111_1111;seg <=8'b1111_1111; end
                endcase
            end
        end
    end
endmodule
