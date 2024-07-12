module iodlyctrl_npre_oserdese1_vlog (iodelay_state, bufo_out, rst_cntr,
			wc, trif,
			rst, bufg_clk, bufo_clk, bufg_clkdiv,
			ddr3_dimm, wl6
		);
input		wc;
input		trif;
input		rst;
input		bufo_clk, bufg_clk, bufg_clkdiv;
input		ddr3_dimm, wl6;
output		iodelay_state, rst_cntr;
output		bufo_out;
reg		qw0cd, qw1cd;
reg		turn, turn_p1;
reg		rst_cntr;
reg		w_to_w;
reg	[2:0]	wtw_cntr;
reg		cmd0, cmd0_n6, cmd0_6, cmd1;
wire		wr_cmd0;
wire		lt0int1, lt0int2, lt0int3;
wire		lt1int1, lt1int2, lt1int3;
wire		latch_in;
reg		qwcd;
assign bufo_out = bufo_clk;
assign iodelay_state = (trif && ~w_to_w) & ((~turn && ~turn_p1) || ~ddr3_dimm);
always @ (posedge bufg_clkdiv)
begin
        if (rst)
        begin
                qwcd <= #10 0;
        end
        else
	begin
		qwcd <= #10 wc;
	end
end
assign #1 wr_cmd0 = !(lt0int1 && lt0int3);
assign #1 lt0int1  = !(qwcd && bufg_clk);
assign #1 lt0int2  = !(lt0int1 && bufg_clk);
assign #1 lt0int3  = !(wr_cmd0 && lt0int2);
always @ (posedge bufg_clk)
	begin
	if (rst)
		begin
			cmd0_n6 <= #10 1'b0;
			cmd0_6 <= #10 1'b0;
		end
	else
		begin
			cmd0_n6 <= #10 wr_cmd0;
			cmd0_6 <= #10 cmd0_n6;
		end
	end
always @ (cmd0_n6 or wl6 or cmd0_6)
	begin
	case (wl6)
	1'b0: cmd0 <= #10 cmd0_n6;
	1'b1: cmd0 <= #10 cmd0_6;
	default: cmd0 <= #10 cmd0_n6;
	endcase
	end
always @ (posedge bufg_clk)
begin
	begin
	if (rst)
		begin
			turn <= #10 1'b0;
		end
	else
		begin
			turn <= #10 (w_to_w || (cmd0 && ~turn) || 
				(~wtw_cntr[2] && turn));
		end
	end
	begin
	if (rst)
		begin
			rst_cntr <= #10 1'b0;
		end
	else
		begin
			rst_cntr <= #10 (~w_to_w && (cmd0 && ~turn));
		end
	end
end
always @ (posedge bufg_clk)
	begin
	if (rst)
		begin
			turn_p1 <= #10 1'b0;
		end
	else
		begin
			turn_p1 <= #10 turn;
		end
	end
always @ (posedge bufg_clk)
begin
	begin
	if (rst)
		begin
			w_to_w <= #10 1'b0;
		end
	else
		begin
			w_to_w <= #10 ((cmd0 && turn_p1) || 
			   (w_to_w && (~wtw_cntr[2] || ~wtw_cntr[1])));
		end
	end
end
always @ (posedge bufg_clk)
	begin
	if (!(w_to_w || turn) || (cmd0 && turn_p1))
		begin
			wtw_cntr <= #10 3'b000;
		end
	else if (w_to_w || turn_p1)
		begin
			wtw_cntr <= #10 wtw_cntr + 1;
		end
	end
endmodule