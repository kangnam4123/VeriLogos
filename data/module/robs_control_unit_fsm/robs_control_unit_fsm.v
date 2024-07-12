module robs_control_unit_fsm(
	input clk, reset,
	input zq, zy, zr,
	output c0, c1, c2, c3, c9, c10, c5, c8, c12, c14, c13, c4, c6, c7, c11,
	output reg done
	);
	parameter   S0  	= 5'b00000; 
	parameter   S1  	= 5'b00001; 
	parameter   S2  	= 5'b00010;	
	parameter   S3   	= 5'b00011;	
	parameter   S4   	= 5'b00100;	
	parameter   S5   	= 5'b00101;	
	parameter   S6 	    = 5'b00110;	
	parameter   S7 	    = 5'b00111;	
	parameter   S8   	= 5'b01000;	
	parameter   S9 	    = 5'b01001;	
	parameter   S10	    = 5'b01010;	
	parameter   S11     = 5'b01011;	
	parameter   S12 	= 5'b01100; 
	parameter   S13 	= 5'b01101; 
	parameter   S14  	= 5'b01111;	
	parameter   S15	    = 5'b10010;	
	parameter   S16	    = 5'b10011;	
	parameter   S17	    = 5'b10100;	
	reg [4:0]  state, nextstate;
	reg [14:0] controls;	
	always @(posedge clk or posedge reset)			
	 if (reset) state <= S0;
	 else state <= nextstate;
	always @( * )
	 case(state)
		S0:  nextstate <= S1;
		S1:  nextstate <= S2;
		S2:  nextstate <= S3;
		S3:  case(zq)
					  0:      nextstate <= S4;
					  1:      nextstate <= S12;
					  default: nextstate <= S0;  
					endcase
		S4:  case(zr)
					  0:      nextstate <= S5;
					  1:      nextstate <= S6;
					  default: nextstate <= S0; 
					endcase
		S5:  nextstate <= S6;
		S6:  case(zy)
					  0:      nextstate <= S7;
					  1:      nextstate <= S9;
					  default: nextstate <= S0; 
					endcase
		S7:  nextstate <= S8;		
		S8:  nextstate <= S10;	
		S9:  nextstate <= S10;
		S10:  nextstate <= S11;
		S11:  nextstate <= S3;
		S12:  case(zr)
					  0:      nextstate <= S13;
					  1:      nextstate <= S14;
					  default: nextstate <= S0; 
					endcase
		S13:  nextstate <= S14;
		S14:  nextstate <= S15;
		S15:  nextstate <= S16;
		S16:  nextstate <= S17;
		S17:  begin nextstate <= S17; done <= 1; end
	 endcase
	assign {c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0} = controls;
	always @( * )
	 case(state)
        S0:        	controls <= 15'b000_0000_0000_0011;
		S1:       	controls <= 15'b000_0000_0000_1100;
		S2:         controls <= 15'b000_0011_0000_0000;
		S3:         controls <= 15'b000_0000_0000_0000;
		S4:         controls <= 15'b000_0000_0000_0000;
		S5:         controls <= 15'b000_0101_0010_0000;
		S6:         controls <= 15'b000_0000_0000_0000;
		S7:        	controls <= 15'b001_0000_0000_0000;
		S8:   		controls <= 15'b000_0000_0000_0000;
		S9:         controls <= 15'b001_1000_0000_0000;
		S10:    	controls <= 15'b010_0011_0101_0000;
		S11:  		controls <= 15'b000_0000_0000_0000;
		S12:        controls <= 15'b000_0000_0000_0000;   
		S13:       	controls <= 15'b000_0001_0010_0000;
		S14:        controls <= 15'b001_0000_0000_0000;
		S15:        controls <= 15'b000_0011_0101_0000;
		S16:        controls <= 15'b100_0000_1000_1000;	
		S17:        controls <= 15'b000_0000_0000_0000;	
		default:    controls <= 15'b000_0000_0000_0000; 
	 endcase
endmodule