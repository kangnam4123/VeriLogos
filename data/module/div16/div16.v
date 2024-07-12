module div16 (clk, resetb, start, a, b, q, r, done);
parameter N = 16;	
input		clk;
input		resetb;	
input		start;	
input [N-1:0]	a;	
input [N-1:0]	b;	
output [N-1:0]	q;	
output [N-1:0]	r;	
output		done;	
reg [N-1:0]	q;
reg		done;
reg [N-1:0]	power;
reg [N-1:0]	accum;
reg [(2*N-1):0]	bpower;
assign r = accum;
wire [2*N-1:0] accum_minus_bpower = accum - bpower;
always @(posedge clk or negedge resetb) begin
   if (~resetb) begin
      q <= 0;
      accum <= 0;
      power <= 0;
      bpower <= 0;
      done <= 0;
   end
   else begin
      if (start) begin
         q      <= 0;
         accum  <= a; 
         power[N-1] <= 1'b1; 
         bpower <= b << N-1; 
         done <= 0;
      end
      else begin
         if (power != 0) begin
            if ( ~accum_minus_bpower[2*N-1]) begin
               q     <= q | power;
               accum <= accum_minus_bpower;
            end
            power  <= power >> 1;
            bpower <= bpower >> 1;
         end
         else begin
            done <= 1;
         end
      end
   end
end
endmodule