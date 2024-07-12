module fourDeepRollingAverage_tc (
	input clk,
	input signed [12:0] in,
    output reg signed [12:0] out = 13'd0);
   reg [1:0] 	  mstr_ctr = 2'b00;
reg [1:0] ctr1 = 2'b00, ctr2 = 2'b00, ctr3 = 2'b00, ctr4 = 2'b00;
   reg signed [14:0] acc1 = 15'd0, acc2 = 15'd0, acc3 = 15'd0, acc4 = 15'd0;
   always @(posedge clk) begin
      if(mstr_ctr == 2'b11) mstr_ctr <= 2'b00;
      else mstr_ctr <= mstr_ctr + 1'b1;
      case (mstr_ctr)
	2'b00: begin
	   ctr2 <= ctr2 + 1'b1;
	   ctr1 <= 2'b00;
	   ctr3 <= ctr3 + 1'b1;
	   ctr4 <= ctr4 + 1'b1;
	end
	2'b01: begin
	   ctr1 <= ctr1 + 1'b1;
	   ctr3 <= ctr3 + 1'b1;
	   ctr2 <= 2'b00;
	   ctr4 <= ctr4 + 1'b1;
	end
	2'b10: begin
	   ctr1 <= ctr1 + 1'b1;
	   ctr2 <= ctr2 + 1'b1;
	   ctr4 <= ctr4 + 1'b1;
	   ctr3 <= 2'b00;
	end
	2'b11: begin
	   ctr4 <= 2'b00;
	   ctr2 <= ctr2 + 1'b1;
	   ctr3 <= ctr3 + 1'b1;
	   ctr1 <= ctr1 + 1'b1;
	end
      endcase
      if (ctr1==2'b11) begin
	 out <= (acc1 + in) >> 2;
	 acc1 <= 15'd0;
	 acc2 <= acc2 + in;
	 acc3 <= acc3 + in;
	 acc4 <= acc4 + in;
      end else if (ctr2==2'b11) begin
	 out <= (acc2 + in) >> 2;
	 acc1 <= acc1 + in;
	 acc2 <= 15'd0;
	 acc3 <= acc3 + in;
	 acc4 <= acc4 + in;
      end else if (ctr3==2'b11) begin
	 out <= (acc3 + in) >> 2;
	 acc1 <= acc1 + in;
	 acc2 <= acc2 + in;
	 acc3 <= 15'd0;
	 acc4 <= acc4 + in;
      end else if (ctr4==2'b11) begin
	 out <= (acc4 + in) >> 2;
	 acc1 <= acc1 + in;
	 acc2 <= acc2 + in;
	 acc3 <= acc3 + in;
	 acc4 <= 15'd0;
      end else begin
	 out <= 15'd0;
	 acc1 <= acc1 + in;
	 acc2 <= acc2 + in;
	 acc3 <= acc3 + in;
	 acc4 <= acc4 + in;
      end
end
endmodule