module i2c( 
	input						clk			,
	input						rst		,
   	input       [7:0]   		wr_data 	,
   	input       [4:0]   		cmd     	,
   	input               		cmd_vld 	,
   	output      [7:0]   		rd_data 	,
   	output              		rd_data_vld	,
   	output  reg         		rev_ack 	,
   	output              		done    	,
   	output  reg         		scl     	,
   	inout               		sda      
);

//para define
localparam  IDLE        = 7'b0000001,
            START       = 7'b0000010,
            WR_DATA     = 7'b0000100,
            RD_DATA     = 7'b0001000,
            R_ACK       = 7'b0010000,
            T_ACK       = 7'b0100000,
            STOP        = 7'b1000000;
parameter   T = 100_000,
            SCL_MAX = 50_000_000 / T;
parameter   SCL_LOW_HALF  = (SCL_MAX * 1 / 4) - 1,
            SCL_HIGH_HALF = (SCL_MAX * 3 / 4) - 1;  
`define     START_BIT   5'b00001
`define     WRITE_BIT   5'b00010
`define     READ_BIT    5'b00100
`define     STOP_BIT    5'b01000
`define     ACK_BIT     5'b10000
`define     ACK         0
`define     NO_ACK      1

//reg define
reg	[6:0]	cstate     	;
reg	[6:0]	nstate     	;
reg	[4:0]	cmd_r       ;
reg	[7:0]	wr_data_r   ;
reg	[7:0]	rd_data_r   ;
reg			sda_out     ;
reg			OE          ;
reg	[8:0]	cnt_bit	   	;
reg	[3:0]   num         ;
reg	[3:0]	cnt_num	   	;

//wire define
wire			sda_in      	;
wire			add_cnt_bit		;
wire			end_cnt_bit		; 
wire			add_cnt_num		;
wire			end_cnt_num		;
wire    		IDLE_START      ;
wire    		START_WR_DATA   ;
wire    		WR_DATA_R_ACK   ;
wire    		R_ACK_IDLE      ;
wire    		IDLE_WR_DATA    ;
wire    		R_ACK_STOP      ;
wire    		STOP_IDLE       ;  

wire    		IDLE_RD_DATA    ;
wire    		RD_DATA_T_ACK   ;
wire    		T_ACK_IDLE      ;
wire    		T_ACK_STOP      ;

assign add_cnt_bit = cstate != IDLE;
assign end_cnt_bit = add_cnt_bit && cnt_bit == SCL_MAX - 1'd1;
assign add_cnt_num = end_cnt_bit;
assign end_cnt_num = add_cnt_num && cnt_num == num - 1;

assign  IDLE_START      = (cstate == IDLE)      && cmd_vld      && (cmd & `START_BIT)   	;
assign  START_WR_DATA   = (cstate == START)     && end_cnt_num  && (cmd_r & `WRITE_BIT) 	;
assign  WR_DATA_R_ACK   = (cstate == WR_DATA)   && end_cnt_num                          	;
assign  R_ACK_IDLE      = (cstate == R_ACK)     && end_cnt_num  && !(cmd_r & `STOP_BIT) 	;
assign  IDLE_WR_DATA    = (cstate == IDLE)      && cmd_vld      && (cmd & `WRITE_BIT) 		;
assign  R_ACK_STOP      = (cstate == R_ACK)     && end_cnt_num  && (cmd_r & `STOP_BIT)  	;
assign  STOP_IDLE       = (cstate == STOP)      && end_cnt_num                          	;
assign  IDLE_RD_DATA    = (cstate == IDLE)      && cmd_vld      && (cmd & `READ_BIT)    	;
assign  RD_DATA_T_ACK   = (cstate == RD_DATA)   && end_cnt_num                          	;
assign  T_ACK_IDLE      = (cstate == T_ACK)     && end_cnt_num  && !(cmd_r & `STOP_BIT) 	;
assign  T_ACK_STOP      = (cstate == T_ACK)     && end_cnt_num  && (cmd_r & `STOP_BIT)  	;

assign sda = OE ? sda_out : 1'bz;
assign sda_in = sda;
assign done = R_ACK_IDLE || T_ACK_IDLE || STOP_IDLE;
assign rd_data = rd_data_r;
assign rd_data_vld = T_ACK_IDLE || T_ACK_STOP;

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		wr_data_r <= 'd0;
		cmd_r <= 'd0;
		end
	else if (cmd_vld) begin
		wr_data_r <= wr_data;
		cmd_r <= cmd;
		end
end

//
always @(posedge clk or negedge rst) begin 
	if(!rst)begin
		cnt_bit <= 'd0;
		end 
	else if(add_cnt_bit)begin 
		if(end_cnt_bit)begin 
			cnt_bit <= 'd0;
			end
		else begin 
			cnt_bit <= cnt_bit + 1'd1;
			end 
		end
end 
    
	 
//IIC_SCL
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		scl <= 'd1;
		end
	else if (cnt_bit == (SCL_MAX - 1 ) >> 1 || STOP_IDLE) begin
		scl <= 'd1;
		end
	else if (end_cnt_bit) begin
		scl <= 'd0;
	end
end

//
always @(posedge clk or negedge rst)begin 
	if(!rst)begin
		cnt_num <= 'd0;
		end 
	else if(add_cnt_num)begin 
		if(end_cnt_num)begin 
			cnt_num <= 'd0;
			end
		else begin 
			cnt_num <= cnt_num + 1'd1;
		end 
	end
end 
    
//
always @(*) begin
	case (cstate)
		IDLE    : num = 1;
		START   : num = 1;
		WR_DATA : num = 8;
		RD_DATA : num = 8;
		R_ACK   : num = 1;
		T_ACK   : num = 1;
		STOP    : num = 1;
		default : num = 1;
	endcase
end

//
always @(posedge clk or negedge rst)begin 
	if(!rst)begin
		cstate <= IDLE;
		end 
	else begin 
		cstate <= nstate;
		end 
end

//
always @(*) begin
	case(cstate)
		IDLE    : begin
			if (IDLE_START) begin
				nstate = START;
				end
			else if (IDLE_WR_DATA) begin
				nstate = WR_DATA;
				end
			else if (IDLE_RD_DATA) begin
				nstate = RD_DATA;
				end
			else begin
				nstate = cstate;
				end
			end 
		START   : begin
			if (START_WR_DATA) begin
				nstate = WR_DATA;
				end
			else begin
				nstate = cstate;
				end
			end 
		WR_DATA : begin
			if (WR_DATA_R_ACK) begin
				nstate = R_ACK;
				end
			else begin
				nstate = cstate;
				end
			end 
		RD_DATA : begin
			if (RD_DATA_T_ACK) begin
				nstate = T_ACK;
				end
			else begin
				nstate = cstate;
				end
			end 
		R_ACK   : begin
			if (R_ACK_STOP) begin
				nstate = STOP;
				end
			else if (R_ACK_IDLE) begin
				nstate = IDLE;
				end
			else begin
				nstate = cstate;
				end
			end 
		T_ACK   : begin
			if (T_ACK_STOP) begin
				nstate = STOP;
				end
			else if (T_ACK_IDLE) begin
				nstate = IDLE;
				end
			else begin
				nstate = cstate;
				end
			end 
		STOP    : begin
			if (STOP_IDLE) begin
				nstate = IDLE;
				end
			else begin
				nstate = cstate;
				end
			end 
		default : nstate = cstate;
	endcase
end

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		OE <= 'b0;
		end else if (IDLE_START || START_WR_DATA || IDLE_WR_DATA || R_ACK_STOP || RD_DATA_T_ACK) begin
		OE <= 'b1;
		end else if (IDLE_RD_DATA || WR_DATA_R_ACK || STOP_IDLE) begin
		OE <= 'b0;
	end
end

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		sda_out <= 1;
		end
	else begin
		case (cstate)
			IDLE    :sda_out <= 1;
			START   :begin
				if (cnt_bit == SCL_LOW_HALF) begin
					sda_out <= 'b1;
					end
				else if (cnt_bit == SCL_HIGH_HALF) begin
					sda_out <= 'b0;
					end
				end
			WR_DATA :begin
				if (cnt_bit == SCL_LOW_HALF) begin
					sda_out <= wr_data_r[7 - cnt_num];
					end
				end
			T_ACK   :begin
				if (cnt_bit == SCL_LOW_HALF) begin
					if (cmd & `ACK_BIT) begin
						sda_out <= `NO_ACK;
						end
					else begin
						sda_out <= `ACK;
						end
					end
				end
			STOP    :begin
				if (cnt_bit == SCL_LOW_HALF) begin
					sda_out <= 'b0;
					end
				else if (cnt_bit == SCL_HIGH_HALF) begin
					sda_out <= 'b1;
					end
				end
			default: sda_out <= 'b1;
		endcase
	end
end

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		rev_ack <= 0;
		rd_data_r <= 8'b0;
		end
	else begin
		case (cstate)
			RD_DATA:begin
				if (cnt_bit == SCL_HIGH_HALF) begin
					rd_data_r[7-cnt_num] <= sda_in;
					end
				end
			R_ACK  :begin
				if (cnt_bit == SCL_HIGH_HALF) begin
					rev_ack <= sda_in;
					end
				end
			default:; 
		endcase
	end
end


endmodule
