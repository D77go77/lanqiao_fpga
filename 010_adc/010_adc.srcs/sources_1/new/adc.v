module adc(
	input	wire					clk		   	,
	input	wire					rst	   	,
	input   wire					wr_req      ,
	input   wire					rd_req      ,
	input   wire	[6:0]			device_id   ,
	input   wire    [7:0]			reg_addr    ,
	input   wire					reg_addr_vld,
	input   wire    [7:0]			wr_data     ,
	input   wire					wr_data_vld ,
	output  wire    [7:0]			rd_data     ,
	output  wire					rd_data_vld ,
	output  wire					ready       ,
	output                        	scl         ,
	inout                         	sda 
);

//para define
`define     	START_BIT   5'b00001
`define     	WRITE_BIT   5'b00010
`define     	READ_BIT    5'b00100
`define     	STOP_BIT    5'b01000
`define     	ACK_BIT     5'b10000
localparam  	IDLE     = 	6'b000001,
				WR_REQ   = 	6'b000010,
				WR_WAIT  = 	6'b000100,
				RD_REQ   = 	6'b001000,
				RD_WAIT  = 	6'b010000,
				DONE     = 	6'b100000;
//wire define				
reg [7:0] 	adc_mdata_r		;
reg [7:0] 	adc_ldata_r		;
wire    	IDLE_WR_REQ     ;
wire    	IDLE_RD_REQ     ;
wire    	WR_REQ_WR_WAIT  ;
wire    	RD_REQ_RD_WAIT  ;
wire    	WR_WAIT_WR_REQ  ;
wire    	WR_WAIT_DONE    ;
wire    	RD_WAIT_RD_REQ  ;
wire    	RD_WAIT_DONE    ;
wire    	DONE_IDLE       ;
wire		done			;
reg [7:0]	op_rd_data  	;
wire		add_cnt_byte	;
wire		end_cnt_byte	;

//reg define
reg	[7:0] 	device_id_r  	; 
reg [7:0] 	device_id_w  	; 
reg	[5:0]	cstate     		;
reg	[5:0]	nstate     		;
reg	[4:0]	cmd				;
reg			cmd_vld			;
reg	[7:0]	op_wr_data  	;
reg	[2:0]	bit_num			;
reg	[7:0]	addr_r   		;
reg			wr_req_r		;
reg			rd_req_r		;
reg	[2:0]	cnt_byte	   	;
reg	[2:0]	num 			;

assign rd_data = {adc_ldata_r[3:0],adc_mdata_r[7:4]};	
assign add_cnt_byte = done;
assign end_cnt_byte = add_cnt_byte && cnt_byte == num - 1;
assign IDLE_WR_REQ    = (cstate == IDLE)    && wr_req_r;
assign IDLE_RD_REQ    = (cstate == IDLE)    && rd_req_r;
assign WR_REQ_WR_WAIT = (cstate == WR_REQ)  && 1;
assign RD_REQ_RD_WAIT = (cstate == RD_REQ)  && 1;
assign WR_WAIT_WR_REQ = (cstate == WR_WAIT) && done;
assign WR_WAIT_DONE   = (cstate == WR_WAIT) && end_cnt_byte;
assign RD_WAIT_RD_REQ = (cstate == RD_WAIT) && done;
assign RD_WAIT_DONE   = (cstate == RD_WAIT) && end_cnt_byte;
assign DONE_IDLE      = (cstate == DONE)    && 1;

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		device_id_w <= 1'b0;
		device_id_r <= 1'b0;
		end
	else begin
		device_id_r <= {device_id,1'b1};
		device_id_w <= {device_id,1'b0};
	end
end

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		wr_req_r <=0;
		rd_req_r <= 0;
	end else begin
		wr_req_r <= wr_req;
		rd_req_r <= rd_req;
	end
end

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin
		addr_r <= 'd0;
	end else if (reg_addr_vld) begin
		addr_r <= reg_addr;
	end
end

//
always @(posedge clk or negedge rst)begin 
	if(!rst)begin
		cnt_byte <= 'd0;
		end 
	else if(add_cnt_byte)begin 
		if(end_cnt_byte)begin 
			cnt_byte <= 'd0;
			end
		else begin 
			cnt_byte <= cnt_byte + 1'd1;
			end 
	end
end 

//
always @(posedge clk or negedge rst) begin
	if (!rst) begin 
		num <= 1;
	end else if (wr_req) begin
		num <= 3;
	end else if (rd_req) begin
		num <= 5;
	end else if (end_cnt_byte) begin
		num <= 1;
	end
end

//
always @(posedge clk or negedge rst) begin 
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
		IDLE    :begin
			if (IDLE_WR_REQ) begin
				nstate = WR_REQ;
				end
			else if (IDLE_RD_REQ) begin
				nstate = RD_REQ;
				end
			else begin
				nstate = cstate;
				end
			end 
		WR_REQ  :begin
			if (WR_REQ_WR_WAIT) begin
				nstate = WR_WAIT;
				end
			else begin
				nstate = cstate;
				end
			end 
		WR_WAIT :begin
			if (WR_WAIT_DONE) begin
				nstate = DONE;
				end
			else if (WR_WAIT_WR_REQ) begin
				nstate = WR_REQ;
				end
			else begin
				nstate = cstate;
				end
			end 
		RD_REQ  :begin
			if (RD_REQ_RD_WAIT) begin
				nstate = RD_WAIT;
				end
			else begin
				nstate = cstate;
				end
			end 
		RD_WAIT :begin
			if (RD_WAIT_DONE) begin
				nstate = DONE;
				end
			else if (RD_WAIT_RD_REQ) begin
				nstate = RD_REQ;
				end
			else begin
				nstate = cstate;
				end
			end 
		DONE    :begin
			if (DONE_IDLE) begin
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
		TX(0,4'h0,8'h00,op_rd_data);
		end
	else begin
		case (cstate)
			RD_REQ:begin
				case (cnt_byte)
					0   :  TX(1,(`START_BIT | `WRITE_BIT),device_id_w,op_rd_data);
					1   :  TX(1,(`WRITE_BIT             ),addr_r[7:0] ,op_rd_data);
					2   :  TX(1,(`START_BIT | `WRITE_BIT),device_id_r,op_rd_data);
					3   :  TX(1,(`READ_BIT  			   ),op_wr_data,adc_mdata_r);
					4   :  TX(1,(`READ_BIT  | `STOP_BIT ),op_wr_data,adc_ldata_r);
					default: TX(0,cmd,op_wr_data,op_rd_data);
				endcase
				end
			WR_REQ:begin
				case (cnt_byte)
					0   :  TX(1,(`START_BIT | `WRITE_BIT),device_id_w,op_rd_data);
					1   :  TX(1,(`WRITE_BIT				   ),op_wr_data,op_rd_data);
					2   :  TX(1,(`WRITE_BIT | `STOP_BIT ),op_wr_data,op_rd_data);
					default: TX(0,cmd,op_wr_data,op_rd_data);
				endcase
				end
			default: TX(0,cmd,op_wr_data,op_rd_data);
		endcase
	end
end


task TX;
	input           task_cmd_vld    ;
	input   [3:0]   task_cmd        ;
	input   [7:0]   task_wr_data    ;
	output	[7:0]   task_rd_data   	;
	begin
		cmd_vld     = task_cmd_vld  ;
		cmd         = task_cmd      ;
		op_wr_data  = task_wr_data  ;
		task_rd_data  = op_rd_data 	;
	end
endtask

wire    [7:0]   rd_adc_data;
assign          rd_adc_data = op_rd_data;

//
i2c inst_i2c(
	.clk		 	(clk)			,
	.rst	    	(rst)			,
	.wr_data     	(op_wr_data)	,
	.cmd         	(cmd)			,
	.cmd_vld     	(cmd_vld)		,
	.rd_data     	(rd_adc_data)	,
	.rd_data_vld 	(rd_data_vld)	,
	.done        	(done)			,
	.scl         	(scl)			,
	.sda         	(sda)
);

endmodule



