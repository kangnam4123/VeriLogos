module mux2_5(
				input d0, 
				input d1,  
				input s, 
				output y);
		assign y = (s) ? d1 : d0;
	endmodule