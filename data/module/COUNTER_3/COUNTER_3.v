module COUNTER_3(CLOCK_I, nARST_I, COUNT_O);
parameter CBITS = 3;
input	CLOCK_I;
input	nARST_I;
output[CBITS-1:0]	COUNT_O;
reg[CBITS-1:0]	COUNT_O;
always @(posedge CLOCK_I or negedge nARST_I)
  if(nARST_I==1'b0)
    COUNT_O	<= {CBITS{1'b0}};
  else
    COUNT_O	<= COUNT_O + 1;
endmodule