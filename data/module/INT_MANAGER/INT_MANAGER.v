module INT_MANAGER(
					clk,
					rst_n,
					en,
					int_en,
					rd_int_msk_i,
					wr_int_msk_i,
					rd_req_done_i,
					wr_req_done_i,
					int_cnt_o,
					msi_on,
					cfg_interrupt_assert_n_o,
					cfg_interrupt_rdy_n_i,
					cfg_interrupt_n_o,
					cfg_interrupt_legacyclr
    );
	parameter		INT_RST = 2'b01;
	parameter		INT_PENDING = 2'b10;
	input			clk;
	input			rst_n;
	input			en;
	input			int_en;
	input			rd_int_msk_i , wr_int_msk_i;
	input			rd_req_done_i , wr_req_done_i;
	output [31:0]	int_cnt_o;
	input			msi_on;
	output			cfg_interrupt_assert_n_o;
	input			cfg_interrupt_rdy_n_i;
	output			cfg_interrupt_n_o;
	input			cfg_interrupt_legacyclr;
	reg [31:0]		int_cnt_o;
	reg				cfg_interrupt_n_o;
	reg				rd_int , wr_int;
	reg				rd_req_done_prev , wr_req_done_prev;
	reg				int_clr;
	reg [1:0]		intr_state;
	always @ ( posedge clk ) begin
		if( !rst_n || !en ) begin
			rd_int <= 1'b0;
			wr_int <= 1'b0;
			rd_req_done_prev <= 1'b0;
			wr_req_done_prev <= 1'b0;
		end
		else begin
			rd_req_done_prev <= rd_req_done_i;
			wr_req_done_prev <= wr_req_done_i;
			if( int_clr || !int_en ) begin
				rd_int <= 1'b0;
				wr_int <= 1'b0;
			end
			else begin
				if( !rd_req_done_prev && rd_req_done_i && !rd_int_msk_i)
					rd_int <= 1'b1;
				if( !wr_req_done_prev && wr_req_done_i && !wr_int_msk_i )
					wr_int <= 1'b1;
			end 
		end 
	end
	always @ ( posedge clk ) begin
		if( !rst_n || !en ) begin
			int_clr <= 1'b0;
			cfg_interrupt_n_o <= 1'b1;
			int_cnt_o <= 32'b0;
			intr_state <= INT_RST;
		end
		else begin
			case ( intr_state )
				INT_RST: begin
					if( rd_int | wr_int ) begin
						int_clr <= 1'b1;
						cfg_interrupt_n_o <= 1'b0;
						int_cnt_o <= int_cnt_o + 1'b1;
						intr_state <= INT_PENDING;
					end
				end
				INT_PENDING: begin
					int_clr <= 1'b0;
					if( !cfg_interrupt_rdy_n_i ) begin
						cfg_interrupt_n_o <= 1'b1;
						intr_state <= INT_RST;
					end
				end
				default: intr_state <= INT_RST;
			endcase		
		end 
	end
endmodule