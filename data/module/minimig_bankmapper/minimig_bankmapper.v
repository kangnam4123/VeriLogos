module minimig_bankmapper
(
	input	chip0,				
	input	chip1,				
	input	chip2,				
	input	chip3,				
	input	slow0,				
	input	slow1,				
	input	slow2,				
	input	kick,				
  input kick1mb,    
	input	cart,				
	input	aron,				
  input ecs,        
	input	[3:0] memory_config,
	output	reg [7:0] bank		
);
always @(*)
begin
  case ({aron,memory_config})
    5'b0_0000 : bank = {  kick, kick1mb,  1'b0,  1'b0,   1'b0,  1'b0,          1'b0, chip3 | chip2 | chip1 | chip0 }; 
    5'b0_0001 : bank = {  kick, kick1mb,  1'b0,  1'b0,   1'b0,  1'b0, chip3 | chip1,                 chip2 | chip0 }; 
    5'b0_0010 : bank = {  kick, kick1mb,  1'b0,  1'b0,   1'b0, chip2,         chip1,                         chip0 }; 
    5'b0_0011 : bank = {  kick, kick1mb,  1'b0,  1'b0,  chip3, chip2,         chip1,                         chip0 }; 
    5'b0_0100 : bank = {  kick, kick1mb,  1'b0, slow0,   1'b0,  1'b0,          1'b0, chip0 | (chip1 & !ecs) | chip2 | (chip3 & !ecs) }; 
    5'b0_0101 : bank = {  kick, kick1mb,  1'b0, slow0,   1'b0,  1'b0, chip3 | chip1,                 chip2 | chip0 }; 
    5'b0_0110 : bank = {  kick, kick1mb,  1'b0, slow0,   1'b0, chip2,         chip1,                         chip0 }; 
    5'b0_0111 : bank = {  kick, kick1mb,  1'b0, slow0,  chip3, chip2,         chip1,                         chip0 }; 
    5'b0_1000 : bank = {  kick, kick1mb, slow1, slow0,   1'b0,  1'b0,          1'b0, chip3 | chip2 | chip1 | chip0 }; 
    5'b0_1001 : bank = {  kick, kick1mb, slow1, slow0,   1'b0,  1'b0, chip3 | chip1,                 chip2 | chip0 }; 
    5'b0_1010 : bank = {  kick, kick1mb, slow1, slow0,   1'b0, chip2,         chip1,                         chip0 }; 
    5'b0_1011 : bank = {  kick, kick1mb, slow1, slow0,  chip3, chip2,         chip1,                         chip0 }; 
    5'b0_1100 : bank = {  kick, kick1mb, slow1, slow0,   1'b0,  1'b0,          1'b0, chip3 | chip2 | chip1 | chip0 }; 
    5'b0_1101 : bank = {  kick, kick1mb, slow1, slow0,   1'b0,  1'b0, chip3 | chip1,                 chip2 | chip0 }; 
    5'b0_1110 : bank = {  kick, kick1mb, slow1, slow0,   1'b0, chip2,         chip1,                         chip0 }; 
    5'b0_1111 : bank = {  kick, kick1mb, slow1, slow0,  chip3, chip2,         chip1,                         chip0 }; 
    5'b1_0000 : bank = {  kick, kick1mb, cart,   1'b0,   1'b0,  1'b0,  1'b0, chip0 | chip1 | chip2 | chip3 }; 
    5'b1_0001 : bank = {  kick, kick1mb, cart,   1'b0,   1'b0,  1'b0, chip1 | chip3, chip0 | chip2 }; 
    5'b1_0010 : bank = {  kick, kick1mb, cart,   1'b0,   1'b0, chip2, chip1, chip0 }; 
    5'b1_0011 : bank = {  kick, kick1mb, cart,   1'b0,  chip3, chip2, chip1, chip0 }; 
    5'b1_0100 : bank = {  kick, kick1mb, cart,  slow0,   1'b0,  1'b0, 1'b0, chip0 | (chip1 & !ecs) | chip2 | (chip3 & !ecs) }; 
    5'b1_0101 : bank = {  kick, kick1mb, cart,  slow0,   1'b0,  1'b0, chip1 | chip3, chip0 | chip2 }; 
    5'b1_0110 : bank = {  kick, kick1mb, cart,  slow0,   1'b0, chip2, chip1, chip0 }; 
    5'b1_0111 : bank = {  kick, kick1mb, cart,  slow0,  chip3, chip2, chip1, chip0 }; 
    5'b1_1000 : bank = {  kick, kick1mb, cart,  slow0,   1'b0,  1'b0,  1'b0, chip0 | chip1 | chip2 | chip3 }; 
    5'b1_1001 : bank = {  kick, kick1mb, cart,  slow0,   1'b0,  1'b0, chip1 | chip3, chip0 | chip2 }; 
    5'b1_1010 : bank = {  kick, kick1mb, cart,  slow0,   1'b0, chip2, chip1, chip0 }; 
    5'b1_1011 : bank = {  kick, kick1mb, cart,  slow0,  chip3, chip2, chip1, chip0 }; 
    5'b1_1100 : bank = {  kick, kick1mb, cart,  slow0,   1'b0,  1'b0, 1'b0, chip0 | chip1 | chip2 | chip3 }; 
    5'b1_1101 : bank = {  kick, kick1mb, cart,  slow0,   1'b0,  1'b0, chip1 | chip3, chip0 | chip2 }; 
    5'b1_1110 : bank = {  kick, kick1mb, cart,  slow0,   1'b0, chip2, chip1, chip0 }; 
    5'b1_1111 : bank = {  kick, kick1mb, cart,  slow0,  chip3, chip2, chip1, chip0 }; 
  endcase
end
endmodule