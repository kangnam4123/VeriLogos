module sampler_1 (
  clock, extClock_mode, 
  wrDivider, config_data, 
  validIn, dataIn, 
  validOut, dataOut, ready50);
input clock; 			
input extClock_mode;		
input wrDivider; 		
input [23:0] config_data; 	
input validIn;			
input [31:0] dataIn; 		
output validOut; 		
output [31:0] dataOut; 		
output ready50;
parameter TRUE = 1'b1;
parameter FALSE = 1'b0;
reg validOut, next_validOut;
reg [31:0] dataOut, next_dataOut;
reg ready50, next_ready50; 
reg [23:0] divider, next_divider; 
reg [23:0] counter, next_counter;	
wire counter_zero = ~|counter;
initial
begin
  divider = 0;
  counter = 0;
  validOut = 0;
  dataOut = 0;
end
always @ (posedge clock) 
begin
  divider = next_divider;
  counter = next_counter;
  validOut = next_validOut;
  dataOut = next_dataOut;
end
always @*
begin
  #1;
  next_divider = divider;
  next_counter = counter;
  next_validOut = FALSE;
  next_dataOut = dataOut;
  if (extClock_mode)
    begin
      next_validOut = validIn;
      next_dataOut = dataIn;
    end
  else if (validIn && counter_zero)
    begin
      next_validOut = TRUE;
      next_dataOut = dataIn;
    end
  if (wrDivider)
    begin
      next_divider = config_data[23:0];
      next_counter = next_divider;
      next_validOut = FALSE; 
    end
  else if (validIn) 
    if (counter_zero)
      next_counter = divider;
    else next_counter = counter-1'b1;
end
always @(posedge clock) 
begin
  ready50 = next_ready50;
end
always @*
begin
  #1;
  next_ready50 = ready50;
  if (wrDivider)
    next_ready50 = FALSE; 
  else if (counter_zero)
    next_ready50 = TRUE;
  else if (counter == divider[23:1])
    next_ready50 = FALSE;
end
endmodule