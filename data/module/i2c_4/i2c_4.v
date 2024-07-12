module i2c_4 (reset, clock4x, data, load, idle, ack, scl, sda);
   input reset;
   input clock4x;
   input [7:0] data;
   input load;
   output ack;
   output idle;
   output scl;
   output sda;
   reg [7:0] ldata;
   reg ack, idle;
   reg scl;
   reg sdai;
   reg [7:0] state;
   assign sda = sdai ? 1'bZ : 1'b0;
   always @(posedge clock4x)
     if (reset)
       begin
	  state <= 0;
	  ack <= 0;
       end
     else
       case (state)
	 8'h00: 
	   begin
	      scl <= 1'b1;
	      sdai <= 1'b1;
	      ack <= 1'b0;
	      idle <= 1'b1;
	      if (load)
		begin
		   ldata <= data;
		   ack <= 1'b1;
		   state <= state+1;
		end
	   end
	 8'h01: 
	   begin
	      ack <= 1'b0;
	      idle <= 1'b0;
	      sdai <= 1'b0;
	      state <= state+1;
	   end
	 8'h02:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h03: 
	   begin
	      ack <= 1'b0;
	      sdai <= ldata[7];
	      state <= state+1;
	   end
	 8'h04:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h05:
	   begin
	      state <= state+1;
	   end
	 8'h06:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h07:
	   begin
	      sdai <= ldata[6];
	      state <= state+1;
	   end
	 8'h08:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h09:
	   begin
	      state <= state+1;
	   end
	 8'h0A:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h0B:
	   begin
	      sdai <= ldata[5];
	      state <= state+1;
	   end
	 8'h0C:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h0D:
	   begin
	      state <= state+1;
	   end
	 8'h0E:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h0F:
	   begin
	      sdai <= ldata[4];
	      state <= state+1;
	   end
	 8'h10:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h11:
	   begin
	      state <= state+1;
	   end
	 8'h12:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h13:
	   begin
	      sdai <= ldata[3];
	      state <= state+1;
	   end
	 8'h14:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h15:
	   begin
	      state <= state+1;
	   end
	 8'h16:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h17:
	   begin
	      sdai <= ldata[2];
	      state <= state+1;
	   end
	 8'h18:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h19:
	   begin
	      state <= state+1;
	   end
	 8'h1A:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h1B:
	   begin
	      sdai <= ldata[1];
	      state <= state+1;
	   end
	 8'h1C:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h1D:
	   begin
	      state <= state+1;
	   end
	 8'h1E:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h1F:
	   begin
	      sdai <= ldata[0];
	      state <= state+1;
	   end
	 8'h20:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h21:
	   begin
	      state <= state+1;
	   end
	 8'h22:
	   begin
	      scl <= 1'b0;
	      state <= state+1;
	   end
	 8'h23: 
	   begin
	      state <= state+1;
	   end
	 8'h24:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h25:
	   begin
	      state <= state+1;
	   end
	 8'h26:
	   begin
	      scl <= 1'b0;
	      if (load)
		begin
		   ldata <= data;
		   ack <= 1'b1;
		   state <= 3;
		end
	      else
		state <= state+1;
	   end
	 8'h27:
	   begin
	      sdai <= 1'b0;
	      state <= state+1;
	   end
	 8'h28:
	   begin
	      scl <= 1'b1;
	      state <= state+1;
	   end
	 8'h29:
	   begin
	      sdai <= 1'b1;
	      state <= 0;
	   end
       endcase
endmodule