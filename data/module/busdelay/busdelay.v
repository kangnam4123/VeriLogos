module	busdelay(i_clk,
		i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, i_wb_data, i_wb_sel,
			o_wb_ack, o_wb_stall, o_wb_data, o_wb_err,
		o_dly_cyc, o_dly_stb, o_dly_we, o_dly_addr,o_dly_data,o_dly_sel,
			i_dly_ack, i_dly_stall, i_dly_data, i_dly_err);
	parameter	AW=32, DW=32, DELAY_STALL = 0;
	input	wire			i_clk;
	input	wire			i_wb_cyc, i_wb_stb, i_wb_we;
	input	wire	[(AW-1):0]	i_wb_addr;
	input	wire	[(DW-1):0]	i_wb_data;
	input	wire	[(DW/8-1):0]	i_wb_sel;
	output	reg			o_wb_ack;
	output	wire			o_wb_stall;
	output	reg	[(DW-1):0]	o_wb_data;
	output	wire			o_wb_err;
	output	reg			o_dly_cyc, o_dly_stb, o_dly_we;
	output	reg	[(AW-1):0]	o_dly_addr;
	output	reg	[(DW-1):0]	o_dly_data;
	output	reg	[(DW/8-1):0]	o_dly_sel;
	input	wire			i_dly_ack;
	input	wire			i_dly_stall;
	input	wire	[(DW-1):0]	i_dly_data;
	input	wire			i_dly_err;
	generate
	if (DELAY_STALL != 0)
	begin
		reg	r_stb, r_we, r_rtn_stall, r_rtn_err;
		reg	[(AW-1):0]	r_addr;
		reg	[(DW-1):0]	r_data;
		reg	[(DW/8-1):0]	r_sel;
		initial	o_dly_cyc  = 1'b0;
		initial	r_rtn_stall= 1'b0;
		initial	r_stb      = 1'b0;
		always @(posedge i_clk)
		begin
			o_dly_cyc <= (i_wb_cyc);
			if (!i_dly_stall)
			begin
				r_we   <= i_wb_we;
				r_addr <= i_wb_addr;
				r_data <= i_wb_data;
				r_sel  <= i_wb_sel;
				if (r_stb)
				begin
					o_dly_we   <= r_we;
					o_dly_addr <= r_addr;
					o_dly_data <= r_data;
					o_dly_sel  <= r_sel;
					o_dly_stb  <= 1'b1;
				end else begin
					o_dly_we   <= i_wb_we;
					o_dly_addr <= i_wb_addr;
					o_dly_data <= i_wb_data;
					o_dly_sel  <= i_wb_sel;
					o_dly_stb  <= i_wb_stb;
				end
				r_stb <= 1'b0;
			end else if (!o_dly_stb)
			begin
				o_dly_we   <= i_wb_we;
				o_dly_addr <= i_wb_addr;
				o_dly_data <= i_wb_data;
				o_dly_sel  <= i_wb_sel;
				o_dly_stb  <= i_wb_stb;
			end else if ((!r_stb)&&(!o_wb_stall))
			begin
				r_we   <= i_wb_we;
				r_addr <= i_wb_addr;
				r_data <= i_wb_data;
				r_sel  <= i_wb_sel;
				r_stb  <= i_wb_stb;
			end
			if (!i_wb_cyc)
			begin
				o_dly_stb <= 1'b0;
				r_stb <= 1'b0;
			end
			o_wb_ack  <= (i_dly_ack)&&(i_wb_cyc)&&(o_dly_cyc);
			o_wb_data <= i_dly_data;
			r_rtn_err <= (i_dly_err)&&(i_wb_cyc)&&(o_dly_cyc);
		end
		assign	o_wb_stall = r_stb;
		assign	o_wb_err   = r_rtn_err;
	end else begin
		initial	o_dly_cyc = 1'b0;
		initial	o_dly_stb = 1'b0;
		always @(posedge i_clk)
			o_dly_cyc <= i_wb_cyc;
		always @(posedge i_clk)
			if (!o_wb_stall)
				o_dly_stb <= ((i_wb_cyc)&&(i_wb_stb));
		always @(posedge i_clk)
			if (!o_wb_stall)
				o_dly_we  <= i_wb_we;
		always @(posedge i_clk)
			if (!o_wb_stall)
				o_dly_addr<= i_wb_addr;
		always @(posedge i_clk)
			if (!o_wb_stall)
				o_dly_data <= i_wb_data;
		always @(posedge i_clk)
			if (!o_wb_stall)
				o_dly_sel <= i_wb_sel;
		always @(posedge i_clk)
			o_wb_ack  <= (i_dly_ack)&&(o_dly_cyc)&&(i_wb_cyc);
		always @(posedge i_clk)
			o_wb_data <= i_dly_data;
		assign	o_wb_stall = ((i_dly_stall)&&(o_dly_stb));
		assign	o_wb_err   = i_dly_err;
	end endgenerate
endmodule