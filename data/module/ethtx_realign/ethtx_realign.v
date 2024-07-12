module ethtx_realign
   (input clk, input reset, input clear,
    input [35:0] datain, input src_rdy_i, output dst_rdy_o,
    output [35:0] dataout, output src_rdy_o, input dst_rdy_i);
   reg [1:0] 	  state;
   reg [15:0] 	  held;
   reg [1:0] 	  held_occ;
   reg 		  held_sof;
   wire 	  xfer_in = src_rdy_i & dst_rdy_o;
   wire 	  xfer_out = src_rdy_o & dst_rdy_i;
   wire 	  sof_in = datain[32];
   wire 	  eof_in = datain[33];
   wire [1:0] 	  occ_in = datain[35:34];
   wire 	  occ_low = occ_in[1] ^ occ_in[0]; 
   always @(posedge clk)
     if(reset | clear)
       begin
	  held <= 0;
	  held_occ <= 0;
	  held_sof <= 0;
       end
     else if(xfer_in)
       begin
	  held <= datain[15:0];
	  held_occ <= occ_in;
	  held_sof <= sof_in;
       end
   localparam RE_IDLE = 0;
   localparam RE_HELD = 1;
   localparam RE_DONE = 2;
   always @(posedge clk)
     if(reset | clear)
       state <= RE_IDLE;
     else
       case(state)
	 RE_IDLE :
	   if(xfer_in & eof_in)
	     state <= RE_DONE;
	   else if(xfer_in & sof_in)
	     state <= RE_HELD;
	 RE_HELD :
	   if(xfer_in & xfer_out & eof_in)
	     if(occ_low)
	       state <= RE_IDLE;
	     else
	       state <= RE_DONE;
	 RE_DONE :
	   if(xfer_out)
	     state <= RE_IDLE;
       endcase 
   wire sof_out = held_sof;
   wire eof_out = (state == RE_HELD)? (eof_in & occ_low) : (state == RE_DONE);
   wire [1:0] occ_out = ((state == RE_DONE)? held_occ : occ_in) ^ 2'b10; 
   assign dataout = {occ_out,eof_out,sof_out,held,datain[31:16]};
   assign src_rdy_o = (state == RE_HELD)? src_rdy_i : (state == RE_DONE);
   assign dst_rdy_o = (state == RE_HELD)? dst_rdy_i : (state == RE_IDLE);
endmodule