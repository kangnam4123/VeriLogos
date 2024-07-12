module decode_in (
   m_src_getn, stream_data, stream_valid, stream_done,
   clk, rst, ce, m_last, fo_full, src_empty, fi,
   stream_width, stream_ack
   );
   input clk,
	 rst,
	 ce,
	 m_last,
	 fo_full;
   input src_empty;
   input [63:0] fi;
   output 	m_src_getn;
   input [3:0] 	stream_width;
   input 	stream_ack;
   output [12:0] stream_data;
   output 	 stream_valid;
   output 	 stream_done;
   reg 		 pull_n;
   reg [1:0] 	 cnt;
   always @(posedge clk or posedge rst)
     begin
	if (rst)
	  cnt <= #1 2'b10;
	else if (pull_n)
	  cnt <= #1 cnt + 1'b1;
     end
   assign m_src_getn = ce ? ~((&cnt) & pull_n) : 1'bz;
   reg [15:0] data;
   always @(cnt or fi)
     begin
	data = 16'h0;
	case (cnt)
	  2'b00: data = {fi[07:00], fi[15:08]};
	  2'b01: data = {fi[23:16], fi[31:24]};
	  2'b10: data = {fi[39:32], fi[47:40]};
	  2'b11: data = {fi[55:48], fi[63:56]};
	endcase
     end
   reg [31:0] sreg,  sreg_n;
   reg [5:0]  left,  left_n;
   reg [1:0]  state, state_n;
   always @(posedge clk or posedge rst)
     begin
	if (rst) begin
	   sreg <= #1 0;
	   left <= #1 0;
	   state<= #1 0;
	end else begin
	   sreg <= #1 sreg_n;
	   left <= #1 left_n;
	   state<= #1 state_n;
	end
     end
   always @(ce or data or fi or left or src_empty
	    or sreg or state or stream_ack or stream_width)
     begin
	pull_n  = 1'b0;
	state_n = state;
	sreg_n  = sreg;
	left_n  = left;
	case (state)
	  2'b00: if (~src_empty && ce) begin
	     sreg_n  = {fi[07:00], fi[15:08], fi[23:16], fi[31:24]};
	     left_n  = 32;
	     state_n = 2'b01;
	  end
	  2'b01: begin
	     if (stream_ack) begin
		if ((left - stream_width) < 5'h10) begin
		   sreg_n = (sreg << stream_width) |
			    (data << (5'h10 - left + stream_width));
		   left_n = left - stream_width + 5'h10;
		   pull_n = 1'b1;
		end else begin
		   sreg_n = sreg << stream_width;
		   left_n = left - stream_width;
		end
	     end 
	  end 
	endcase 
     end 
   reg stream_done;
   always @(posedge clk)
     stream_done <= #1 m_last && (&cnt);
   assign stream_data = sreg[31:19];
   assign stream_valid= |{left[5:4]} && ~src_empty && ~stream_done && ~fo_full;
endmodule