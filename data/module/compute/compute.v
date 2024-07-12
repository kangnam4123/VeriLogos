module compute(
	rst_i,     
	clk_i,
	dat_i,     
	shift_en,     
	prev_row_load,    
	curr_row_load,		
	next_row_load,		
	result_row     
    );
input clk_i;
input rst_i;
input[31:0] dat_i;
input  shift_en;       
input  prev_row_load; 
input  curr_row_load;  
input  next_row_load; 
output[31:0] result_row; 
reg [31:0] prev_row=0, curr_row=0, next_row=0;
reg [7:0] O[-1:1][-1:1]; 
reg signed 	[10:0] Dx=0, Dy=0;
reg [7:0] abs_D = 0 ;  
reg [31:0] result_row =0 ; 
always@(posedge clk_i)
	if(prev_row_load)	  
	   prev_row	<= dat_i;
	else 
	  if(shift_en)		
	    prev_row[31:8] <= prev_row[23:0];
always@(posedge clk_i)
	if(curr_row_load)	 
	   curr_row<= dat_i;
	else 
	  if(shift_en )   
	    curr_row [31:8]<=curr_row[23:0];
always@(posedge clk_i)
	if(next_row_load)	  
	   next_row<=dat_i;
	else
	  if(shift_en )	
	     next_row [31:8]<=next_row[23:0];
function [10:0]	abs ( input signed [10:0] x);
	abs = x >=0 ? x : -x ;
endfunction
always @(posedge clk_i) 
   if(rst_i)
      begin
            O[-1][-1]<=0;
	          O[-1][ 0]<=0;
	          O[-1][+1]<=0;
	          O[ 0][-1]<=0;
	          O[ 0][ 0]<=0;
	          O[ 0][+1]<=0;
	          O[+1][-1]<=0;
	          O[+1][ 0]<=0;
	          O[+1][+1]<=0;
	   end
	else
	if ( shift_en )	 
	begin
		abs_D <= (abs(Dx) + abs(Dy))>>3;
		Dx	<= -$signed({3'b000, O[-1][-1]})	        
				  +$signed({3'b000, O[-1][+1]})	        
				  -($signed({3'b000, O[ 0][-1]})<<1)    
				  +($signed({3'b000, O[ 0][+1]})<<1)	   
				  -$signed({3'b000, O[+1][-1]})	        
				  +$signed({3'b000, O[+1][+1]});	       
		Dy	<= $signed({3'b000, O[-1][-1]})	         
				  +($signed({3'b000, O[-1][ 0]})<<1)    
				  +$signed({3'b000, O[-1][+1]})	        
				  -$signed({3'b000, O[+1][-1]})         
				  -($signed({3'b000, O[+1][ 0]})<<1)    
				  -$signed({3'b000, O[+1][+1]});	       
	  O[-1][-1]	<=	O[-1][0];
	  O[-1][ 0]	<=	O[-1][+1];
    O[-1][+1]	<=	prev_row[31:24];
    O[ 0][-1]	<=	O[0][0];
    O[ 0][ 0]	<=	O[0][+1];
    O[ 0][+1]	<=	curr_row[31:24];
    O[+1][-1]	<=	O[+1][0];
    O[+1][ 0]	<=	O[+1][+1];
    O[+1][+1]	<=	next_row[31:24];
  end
always	@(posedge clk_i)
	if(shift_en)	
	   result_row	<= { result_row[23:0], abs_D};
endmodule