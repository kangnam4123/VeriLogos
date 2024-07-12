module uart_light_clk_gen
#( 	
	parameter BR_DIVISOR_TX = 54,
	parameter BR_DIVISOR_RX = 5,
	parameter BRD_SIZE_TX = 6,
	parameter BRD_SIZE_RX = 3
)(
	output wire clk_rx,
	output wire clk_tx,
	input  wire clk_peri,
	input  wire reset
   );
	reg [BRD_SIZE_TX-1:0] divisor_tx;
	reg [BRD_SIZE_RX-1:0] divisor_rx;
	assign clk_tx = divisor_tx[BRD_SIZE_TX-1];
	assign clk_rx = divisor_rx[BRD_SIZE_RX-1];
	always @(posedge clk_peri, posedge reset) begin
		if(reset) begin 
			divisor_tx <= {(BRD_SIZE_TX){1'b0}};
			divisor_rx <= {(BRD_SIZE_RX){1'b0}};
		end
		else begin  
			if(divisor_tx == (BR_DIVISOR_TX - 1'b1))
				divisor_tx <= {(BRD_SIZE_TX){1'b0}};
			else
				divisor_tx <= divisor_tx + 1'b1;
			if(divisor_rx == (BR_DIVISOR_RX - 1'b1))
				divisor_rx <= {(BRD_SIZE_RX){1'b0}};
			else
				divisor_rx <= divisor_rx + 1'b1;
		end
	end
endmodule