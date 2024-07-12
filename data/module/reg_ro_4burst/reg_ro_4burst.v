module reg_ro_4burst(
		     input wire clk,
		     input wire [15:0] bus_ad, 
		     input wire [18:0] my_a,
		     input wire [2:0] bus_a, 
		     input wire adv, 
		     input wire rw,  
		     input wire cs,  
		     input wire [63:0] reg_d,
		     output reg [15:0] rbk_d, 
		     output wire strobe
	      );
   reg [2:0] 			 bcount;
   reg 				 activated;
   reg [15:0] 			 bus_ad_r;
   reg 				 cs_r;
   reg [2:0] 			 bus_a_r;
   reg 				 rw_r;
   reg 				 adv_r;
   reg [2:0] 			 activated_d;
   always @(posedge clk) begin
      activated_d[2:0] <= {activated_d[1:0],activated};
   end
   assign strobe = activated_d[2] & !activated_d[1]; 
   always @(posedge clk) begin
      bus_ad_r <= bus_ad;
      bus_a_r <= bus_a;
      cs_r <= cs;
      rw_r <= rw;
      adv_r <= adv;
      if( cs_r && adv_r && ({bus_a_r, bus_ad_r} == my_a) ) begin
	 activated <= 1'b1;
	 bcount <= 3'b0;
      end else if( !cs_r ) begin
	 activated <= 1'b0;
	 bcount <= 3'b0;
      end else begin
	 activated <= activated;
	 if( bcount <= 3'b111 ) begin
	    bcount <= bcount + 3'b01;
	 end else begin
	    bcount <= bcount;
	 end
      end 
   end 
   always @(*) begin
      if( activated && rw_r ) begin
	 case (bcount) 
	   3'b0001: begin
	      rbk_d = reg_d[15:0];
	   end
	   3'b010: begin
	      rbk_d = reg_d[31:16];
	   end
	   3'b011: begin
	      rbk_d = reg_d[47:32];
	   end
	   3'b100: begin
	      rbk_d = reg_d[63:48];
	   end
	   default: begin
	      rbk_d = 16'hZZZZ;
	   end
	 endcase 
      end else begin 
	 rbk_d = 16'hZZZZ;
      end 
   end
endmodule