module flt_recip_iter
   (
   input	 clk,
   input [7:0]	 X0,
   input [31:0]	 denom,
   output reg [31:0] recip
   );
   reg		 sign;
   reg [30:23]	 exp;
   reg [22:0]	 B;
   wire [24:0]	 round;
   wire [32:0]	 mult1;
   wire [32:8]	 round_mult1;
   wire [34:0]	 mult2;
   wire [41:0]	 mult3;
   wire [25:0]	 round_mult3;
   wire [43:0]	 mult4;
   wire [24:0]	 sub1;
   wire [25:0]	 sub2;
   reg		 sign1,
		 sign2;
   reg [30:23]	 exp1,
		 exp2;
   reg [7:0]	 X0_reg;
   reg [24:0]	 pipe1;
   reg [17:0]	 X1_reg;
   reg [25:0]	 pipe2;
   reg [22:0]	 B1;
   wire [30:23]	 exp_after_norm;
   reg [23:0]	 round_after_norm;
   reg [31:0] recip_1;
   reg [31:0] recip_2;
   always @(posedge clk) begin
   	sign <= denom[31];
   	exp  <= denom[30:23];
   	B    <= denom[22:0];
   end
   assign mult1 = ({1'b1,B} * {1'b1,X0});
   assign round_mult1 = mult1[32:8] + mult1[7];
   assign sub1 =  ~round_mult1 + 1;
   assign mult2 = (pipe1 * {1'b1,X0_reg});
   assign mult3 = ({1'b1,B1} * mult2[33:16]);
   assign round_mult3 = mult3[40:15] + mult3[14];
   assign sub2 = ~pipe2 + 1;
   assign mult4 = (X1_reg * sub2);
   assign round = mult4[41:18] + mult4[17];
   assign exp_after_norm = exp2 - !round[24];
   always @(round) begin
      if (round[24]) begin 
	 round_after_norm <= round[24:1];
      end
      else begin           
	 round_after_norm <= round[23:0];
      end
   end
   always @(posedge clk) begin
	 sign1 <= sign;
	 exp1 <= 9'hFE - exp;
	 pipe1 <= sub1;
	 X0_reg <= X0;
	 B1 <= B;
	 sign2 <= sign1;
	 exp2 <= exp1;
	 pipe2 <= round_mult3;
	 X1_reg <= mult2[33:16];
	 recip_1 <= {sign2,exp_after_norm,round_after_norm[22:0]};
	 recip_2 <= recip_1;
	 recip <= recip_2;
   end
endmodule