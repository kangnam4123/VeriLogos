module wr_mux
  (
   input 	     clock,
   input 	     reset,
   input [3:0] 	     wri_valid,
   output [3:0]      wri_ready,
   input [3:0] 	     wri_last,
   input [63:0]      wri_addr_0,
   input [63:0]      wri_addr_1,
   input [63:0]      wri_addr_2,
   input [63:0]      wri_addr_3,
   input [63:0]      wri_data_0,
   input [63:0]      wri_data_1,
   input [63:0]      wri_data_2,
   input [63:0]      wri_data_3,
   output 	     wro_valid,
   input 	     wro_ready,
   output [63:0]     wro_addr,
   output reg [63:0] wro_data,
   output reg 	     wro_last
   );
   reg [3:0] 	     state = 0;
   reg [60:0] 	     wro_addr_s = 0;
   assign wro_addr = {wro_addr_s, 3'd0};
   assign wri_ready[0] = (state == 1) && wro_ready;
   assign wri_ready[1] = (state == 5) && wro_ready;
   assign wri_ready[2] = (state == 9) && wro_ready;
   assign wri_ready[3] = (state == 13) && wro_ready;
   assign wro_valid = (state[1:0] == 1);
   always @ (posedge clock)
     begin
	if(reset)
	  state <= 4'h0;
	else
	  begin
	     casex(state)
	       default: state <= wri_valid[0] ? 4'h1 :
				 wri_valid[1] ? 4'h5 :
				 wri_valid[2] ? 4'h9 :
				 wri_valid[3] ? 4'hD : 4'h0;
	       4'bxx01: state <= state + wro_ready;
	       4'h2: state <= ~wri_last[0] ? state :
			      wri_valid[1] ? 4'h5 :
			      wri_valid[2] ? 4'h9 :
			      wri_valid[3] ? 4'hD :
			      wri_valid[0] ? 4'h1 : 4'h0;
	       4'h6: state <= ~wri_last[1] ? state :
			      wri_valid[0] ? 4'h1 :
			      wri_valid[2] ? 4'h9 :
			      wri_valid[3] ? 4'hD :
			      wri_valid[1] ? 4'h5 : 4'h0;
	       4'hA: state <= ~wri_last[2] ? state :
			      wri_valid[3] ? 4'hD :
			      wri_valid[0] ? 4'h1 :
			      wri_valid[1] ? 4'h5 :
			      wri_valid[2] ? 4'h9 : 4'h0;
	       4'hE: state <= ~wri_last[3] ? state :
			      wri_valid[0] ? 4'h1 :
			      wri_valid[1] ? 4'h5 :
			      wri_valid[2] ? 4'h9 :
			      wri_valid[3] ? 4'hD : 4'h0;
	     endcase
	  end
	case(state[3:2])
	  0: wro_addr_s <= wri_addr_0[63:3];
	  1: wro_addr_s <= wri_addr_1[63:3];
	  2: wro_addr_s <= wri_addr_2[63:3];
	  3: wro_addr_s <= wri_addr_3[63:3];
	endcase
	case(state[3:2])
	  0: wro_data <= wri_data_0;
	  1: wro_data <= wri_data_1;
	  2: wro_data <= wri_data_2;
	  3: wro_data <= wri_data_3;
	endcase
	case(state[3:2])
	  0: wro_last <= wri_last[0];
	  1: wro_last <= wri_last[1];
	  2: wro_last <= wri_last[2];
	  3: wro_last <= wri_last[3];
	endcase
     end
endmodule