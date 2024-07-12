module anode_decoder(
		anode,
		control
);
			output [3:0] anode;
			input [1:0]  control;
			assign anode = (control == 2'b00) ? 4'b1110 : 
								(control == 2'b01) ? 4'b1101 : 
								(control == 2'b10) ? 4'b1011 : 
								4'b0111;
endmodule