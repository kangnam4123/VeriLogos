module seg7_1(bnum, led);
input [3:0] bnum;			
output reg [0:6] led;	
always @(bnum)
	case(bnum)
		0: led = 7'b0000001;		
		1: led = 7'b1001111;		
		2: led = 7'b0010010;		
		3: led = 7'b0000110;		
		4: led = 7'b1001100;		
		5: led = 7'b0100100;		
		6: led = 7'b0100000;		
		7: led = 7'b0001111;		
		8: led = 7'b0000000;		
		9: led = 7'b0000100;		
		10: led = 7'b0001000;	
		11: led = 7'b1100000;	
		12: led = 7'b0110001;	
		13: led = 7'b1000010;	
		14: led = 7'b0110000;	
		15: led = 7'b0111000;	
		default: led = 7'b1111111;	
	endcase
endmodule