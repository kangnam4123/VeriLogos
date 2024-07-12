module input_stabilizer_layer_ctrl (
	input clk,
	input reset,
	input a,
	output a_clocked
);
	reg [1:0] a_reg;
   always @ (posedge reset or posedge clk)
     if (reset)
       a_reg <= #1 2'b00; 
     else
       a_reg <= #1 {a,a_reg[1]};
	 assign a_clocked = a_reg[0];
endmodule