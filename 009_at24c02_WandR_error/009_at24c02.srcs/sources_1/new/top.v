module top( 
	input	wire			sys_clk		,
   	input	wire			rst			,
	input	wire	[3:0]	key_in		,
	output 	wire	[7:0] 	seg	        ,	
	output 	wire 	[7:0]	sel	        ,
   	output         			scl     	,
   	inout          			sda     
);								 

//wire define
reg                 rd_req      ;
wire    [7:0]   	rd_data		;
wire            	rd_data_vld	;
//reg define
reg    	[7:0]   	wr_data		;
reg  				wr_data_vld	;
reg                 wr_req      ;
reg   	[7:0]		reg_addr	;
reg 				reg_addr_vld;

wire ready;

always @(posedge sys_clk or posedge rst) begin
	if(rst) begin
        wr_req <= 0;
        rd_req <= 0;
		reg_addr <= 8'd0;
        reg_addr_vld <= 1;
        wr_data <= 0;
	end else begin
        wr_req <= 0;
        rd_req <= 0;
        reg_addr_vld <= 0;
		wr_data_vld <= 0;

		if(~key_in[0])begin//read data from EEPROM
			if(ready) begin
				reg_addr <= 8'd0;
				reg_addr_vld <= 1;
				rd_req <= 1'd1;
			end
		end 

		if(~key_in[1]) begin//wirte data to EEPROM
			if(ready) begin
				reg_addr <= 8'd0;
				reg_addr_vld<=1;
				wr_data <= 8'b0000_0001;
				wr_data_vld <= 1;
				wr_req <= 1'b1;
			end
		end else if(~key_in[2]) begin
			if(ready) begin
				reg_addr <= 8'd0;
				reg_addr_vld<=1;
				wr_data <= 8'b0000_0010;
				wr_data_vld <= 1;
				wr_req <= 1'b1;
			end
		end else if(~key_in[3]) begin
			if(ready) begin
				reg_addr <= 8'd2;
				reg_addr_vld<=1;
				wr_data <= 8'b0000_0011;
				wr_data_vld <= 1;
				wr_req <= 1'b1;
			end
		end
	end
end


//eeprom module 
e2prom inst_eeprom(
	.clk		 		(sys_clk)		,
	.rst	     		(~rst)			,
	.wr_req      		(wr_req)		,
	.rd_req      		(rd_req)		,	//read data from EEPROM
	.device_id   		()				,
	.reg_addr    		(reg_addr)		,
	.reg_addr_vld		(reg_addr_vld)	,
	.wr_data     		(wr_data)		,
	.wr_data_vld 		(wr_data_vld)	,
	.rd_data     		(rd_data)		,
	.rd_data_vld 		(rd_data_vld)	,
	.ready       		(ready)			,
	.scl         		(scl)			,
	.sda         		(sda)
);

//seg module
smg inst_segdisplay(
	.clk 				(sys_clk)												,
	.rst 				(~rst)													,	
	.seg_number_in 		({4'd14, 4'd14, 4'd10, 4'd10, 4'd10, 4'd10, rd_data})	,	
	.seg_number 		(seg)											        ,
	.seg_choice 		(sel)
);

endmodule
