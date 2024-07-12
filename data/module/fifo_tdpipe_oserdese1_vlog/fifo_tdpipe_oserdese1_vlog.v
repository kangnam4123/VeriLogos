module fifo_tdpipe_oserdese1_vlog (muxout, din, qwc, qrd, 
		rd_gap1,
		bufg_clk, bufo_clk, rst_bufo_p, rst_bufg_p,
		DDR3_DATA, extra, ODV, DDR3_MODE
		);
input		din;
input	[1:0]	qwc, qrd;
input		rd_gap1;
input		rst_bufo_p, rst_bufg_p;
input		bufg_clk, bufo_clk;
input		DDR3_DATA, ODV;
input		extra;
input		DDR3_MODE;
output		muxout;
reg		muxout;
reg		qout1, qout2;
reg		qout_int, qout_int2;
reg	[4:1]	fifo;
reg		cin1;
reg		omux;
wire	[2:0]	sel;
reg		pipe1, pipe2;
wire		selqoi, selqoi2;
wire	[2:0]	selmuxout;
always @ (posedge bufg_clk or posedge rst_bufg_p)
	begin
	if (rst_bufg_p)
		begin
			fifo <= #10 4'b0000;
		end
	else if (!qwc[1] & !qwc[0])
		begin
			fifo <= #10 {fifo[4:2],din};
		end
	else if (!qwc[1] & qwc[0])
		begin
			fifo <= #10 {fifo[4:3],din,fifo[1]};
		end
	else if (qwc[1] & qwc[0])
		begin
			fifo <= #10 {fifo[4],din,fifo[2:1]};
		end
	else if (qwc[1] & !qwc[0])
		begin
			fifo <= #10 {din,fifo[3:1]};
		end
	end
always @ (qrd or fifo)
	begin
	case (qrd)
	2'b00: omux <= #10 fifo[1];
	2'b01: omux <= #10 fifo[2];
	2'b10: omux <= #10 fifo[4];
	2'b11: omux <= #10 fifo[3];
	default: omux <= #10 fifo[1];
	endcase
	end
always @ (posedge bufo_clk or posedge rst_bufo_p)
	begin
	if (rst_bufo_p)
		begin
			qout_int <= #10 1'b0;
			qout_int2 <= #10 1'b0;
		end
	else
		begin
			qout_int <= #10 omux;
			qout_int2 <= #10 qout_int;
		end
	end
assign #10 selqoi = ODV | rd_gap1;
always @ (selqoi or qout_int or omux)
	begin
	case(selqoi)
	1'b0: qout1 <= #10 omux;
	1'b1: qout1 <= #10 qout_int;
	default: qout1 <= #10 omux;
	endcase
	end
assign #10 selqoi2 = ODV & rd_gap1;
always @ (selqoi2 or qout_int2 or qout_int)
	begin
	case(selqoi2)
	1'b0: qout2 <= #10 qout_int;
	1'b1: qout2 <= #10 qout_int2;
	default qout2 <= #10 qout_int;
	endcase
	end
assign #14 selmuxout = {DDR3_MODE,DDR3_DATA,extra};
always @ (selmuxout or din or omux or qout1 or qout2)
	begin
	case (selmuxout)
	3'b000: muxout = #1 din;
	3'b001: muxout = #1 din;
	3'b010: muxout = #1 din;
	3'b011: muxout = #1 din;
	3'b100: muxout = #1 omux;
	3'b101: muxout = #1 omux;
	3'b110: muxout = #1 qout1;
	3'b111: muxout = #1 qout2;
	default: muxout = #10 din;
	endcase
	end
endmodule