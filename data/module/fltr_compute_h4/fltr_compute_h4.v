module fltr_compute_h4 (clk, din, dout);
   input clk; 
   input[55:0] din; 
   output[15:0] dout; 
   reg[15:0] dout;
   reg[16:0] q1; 
   reg[16:0] q2; 
   reg[16:0] q3; 
   reg[16:0] q4; 
   reg[16:0] q5; 
   reg[16:0] q6; 
   reg[16:0] q7; 
   reg[19:0] d_out_tmp; 
   always @(posedge clk)
   begin
			q1 <= din[55:48] * 4'b1110;
			q2 <= din[47:40] * 6'b101011;
			q3 <= din[39:32] * 7'b1010000;
			q4 <= din[31:24] * 9'b101000100;
			q5 <= din[23:16] * 7'b1010000;
			q6 <= din[15:8] * 6'b101011;
			q7 <= din[7:0] * 4'b1110;
          d_out_tmp <= ({q1[16], q1[16], q1[16], q1}) + ({q2[16], q2[16], q2[16], q2}) + ({q3[16], q3[16], q3[16], q3}) + ({q4[16], q4[16], q4[16], q4}) + ({q5[16], q5[16], q5[16], q5}) + ({q6[16], q6[16], q6[16], q6}) + ({q7[16], q7[16], q7[16], q7});
         dout <= d_out_tmp[18:3] ; 
   end 
endmodule