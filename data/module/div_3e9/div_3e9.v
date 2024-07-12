module div_3e9
  (
   input             c,
   input [62:0]      i, 
   input             iv,
   output reg [62:0] o,
   output reg [10:0] oe,
   output reg        ov = 0);
   reg [53:0] 	     sr;
   reg [6:0] 	     state = 0;
   wire [53:0] 	     sub = sr - 54'h165A0BC0000000;
   always @ (posedge c)
     begin
	if(iv)
	  oe <= i[62:52] - (1023+31);
	else if(state == 64)
	  oe <= o[62] ? oe : oe-1'b1;
	if(iv)
	  state <= 1'b1;
	else if(state == 64)
	  state <= 1'b0;
	else
	  state <= state + (state != 0);
	if(iv)
	  sr <= {2'b01,i[51:0]};
	else
	  sr <= sub[53] ? {sr[52:0],1'b0} : {sub[52:0],1'b0};
	if(state == 64)
	  o <= o[62] ? o : {o[61:0],1'b0};
	else if(state != 0)
	  o <= {o[61:0], ~sub[53]};
	ov <= (state == 64);
     end
   initial
     begin
        $dumpfile("dump.vcd");
        $dumpvars(0);
     end
endmodule