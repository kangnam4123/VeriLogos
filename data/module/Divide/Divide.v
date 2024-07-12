module Divide(
   input  clock,
   input  reset,
   input  OP_div,     		
   input  OP_divu,    		
   input  [31:0] Dividend,
   input  [31:0] Divisor,
   output [31:0] Quotient,
   output [31:0] Remainder,
   output Stall,       		
	input  active,     		
   input  neg,        		
   input  [31:0] result,  
   input  [31:0] denom,   
   input  [31:0] work,
	output reg  vote_active,     		
   output reg  vote_neg,        		
   output reg  [31:0] vote_result,  
   output reg  [31:0] vote_denom,   
   output reg  [31:0] vote_work
	);
   reg [4:0] cycle;      
   wire [32:0]     sub = { work[30:0], result[31] } - denom;
   assign Quotient = !neg ? result : -result;
   assign Remainder = work;
   assign Stall = active;
   always @(posedge clock) begin
      if (reset) begin
         vote_active <= 0;
         vote_neg <= 0;
         cycle <= 0;
         vote_result <= 0;
         vote_denom <= 0;
         vote_work <= 0;
      end
      else begin
         if (OP_div) begin
            cycle <= 5'd31;
            vote_result <= (Dividend[31] == 0) ? Dividend : -Dividend;
            vote_denom <= (Divisor[31] == 0) ? Divisor : -Divisor;
            vote_work <= 32'b0;
            vote_neg <= Dividend[31] ^ Divisor[31];
            vote_active <= 1;
         end
         else if (OP_divu) begin
            cycle <= 5'd31;
            vote_result <= Dividend;
            vote_denom <= Divisor;
            vote_work <= 32'b0;
            vote_neg <= 0;
            vote_active <= 1;
         end
         else if (active) begin
            if (sub[32] == 0) begin
               vote_work <= sub[31:0];
               vote_result <= {result[30:0], 1'b1};
            end
            else begin
               vote_work <= {work[30:0], result[31]};
               vote_result <= {result[30:0], 1'b0};
            end
            if (cycle == 0) begin
               vote_active <= 0;
            end
            cycle <= cycle - 5'd1;
         end
      end
   end
endmodule