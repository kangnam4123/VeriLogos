module bank_mapper
(
	input	chip0,				
	input	chip1,				
	input	chip2,				
	input	chip3,				
	input	slow0,				
	input	slow1,				
	input	slow2,				
	input	kick,				
	input	cart,				
	input	aron,				
  input ecs,        
	input	[3:0] memory_config,
	output	reg [7:0] bank		
);
always @(*)
begin
  case ({aron,memory_config})
    5'b0_0000 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick,  1'b0,  1'b0, chip0 | chip1 | chip2 | chip3 }; 
    5'b0_0001 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick,  1'b0, chip1 | chip3, chip0 | chip2 }; 
    5'b0_0010 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick, chip2, chip1, chip0 }; 
    5'b0_0011 : bank = {  1'b0,  1'b0, chip3,  1'b0,     kick, chip2, chip1, chip0 }; 
    5'b0_0100 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick, slow0,  1'b0, chip0 | (chip1 & !ecs) | chip2 | (chip3 & !ecs) }; 
    5'b0_0101 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick, slow0, chip1 | chip3, chip0 | chip2 }; 
    5'b0_0110 : bank = {  1'b0,  1'b0,  1'b0, slow0,     kick, chip2, chip1, chip0 }; 
    5'b0_0111 : bank = {  1'b0,  1'b0, chip3, slow0,     kick, chip2, chip1, chip0 }; 
    5'b0_1000 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick, slow0, slow1, chip0 | chip1 | chip2 | chip3 }; 
    5'b0_1001 : bank = {  1'b0,  1'b0, slow1,  1'b0,     kick, slow0, chip1 | chip3, chip0 | chip2 }; 
    5'b0_1010 : bank = {  1'b0,  1'b0, slow1, slow0,     kick, chip2, chip1, chip0 }; 
    5'b0_1011 : bank = { slow1,  1'b0, chip3, slow0,     kick, chip2, chip1, chip0 }; 
    5'b0_1100 : bank = {  1'b0,  1'b0,  1'b0, slow2,     kick, slow0, slow1, chip0 | chip1 | chip2 | chip3 }; 
    5'b0_1101 : bank = {  1'b0,  1'b0, slow1, slow2,     kick, slow0, chip1 | chip3, chip0 | chip2 }; 
    5'b0_1110 : bank = {  1'b0, slow2, slow1, slow0,     kick, chip2, chip1, chip0 }; 
    5'b0_1111 : bank = { slow1, slow2, chip3, slow0,     kick, chip2, chip1, chip0 }; 
    5'b1_0000 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick,  cart,  1'b0, chip0 | chip1 | chip2 | chip3 }; 
    5'b1_0001 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick,  cart, chip1 | chip3, chip0 | chip2 }; 
    5'b1_0010 : bank = {  1'b0,  1'b0,  1'b0, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_0011 : bank = {  1'b0,  1'b0, chip3, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_0100 : bank = {  1'b0,  1'b0,  1'b0,  1'b0,     kick,  cart, slow0, chip0 | (chip1 & !ecs) | chip2 | (chip3 & !ecs) }; 
    5'b1_0101 : bank = {  1'b0,  1'b0,  1'b0, slow0,     kick,  cart, chip1 | chip3, chip0 | chip2 }; 
    5'b1_0110 : bank = {  1'b0,  1'b0, slow0, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_0111 : bank = {  1'b0, slow0, chip3, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_1000 : bank = {  1'b0,  1'b0, slow1,  1'b0,     kick,  cart, slow0, chip0 | chip1 | chip2 | chip3 }; 
    5'b1_1001 : bank = {  1'b0,  1'b0, slow1, slow0,     kick,  cart, chip1 | chip3, chip0 | chip2 }; 
    5'b1_1010 : bank = { slow1,  1'b0, slow0, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_1011 : bank = { slow1, slow0, chip3, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_1100 : bank = {  1'b0,  1'b0, slow1, slow2,     kick,  cart, slow0, chip0 | chip1 | chip2 | chip3 }; 
    5'b1_1101 : bank = {  1'b0, slow2, slow1, slow0,     kick,  cart, chip1 | chip3, chip0 | chip2 }; 
    5'b1_1110 : bank = { slow1, slow2, slow0, chip2,     kick,  cart, chip1, chip0 }; 
    5'b1_1111 : bank = { slow1, slow0, chip3, chip2,     kick,  cart, chip1, chip0 }; 
  endcase
end
endmodule