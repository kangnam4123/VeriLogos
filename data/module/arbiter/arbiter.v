module arbiter
	(
		input wire 	clk,
		input wire  [3:0]	port_request_din,
		input wire 			arbiter_strobe_din,
		input wire 			clear_arbiter_din,
		output wire [3:0]	xbar_conf_vector_dout
    );
	localparam 	RQS0 =	4'b0001;
	localparam	RQS1 =	4'b0010;
	localparam	RQS2 =	4'b0100;
	localparam	RQS3 =	4'b1000;
	localparam	PTY_NEXT_RQS1 =	2'b01;
	localparam	PTY_NEXT_RQS2 =	2'b10;
	localparam	PTY_NEXT_RQS3 =	2'b11;
	localparam	PTY_NEXT_RQS0 =	2'b00;
	reg [3:0] xbar_conf_vector_reg 	= 4'b0000;
	reg  [1:0] rqs_priority_reg = 2'b00;
	reg  [1:0] rqs_priority_next;
		always @(posedge clk)
			if (clear_arbiter_din)
				rqs_priority_reg <= rqs_priority_next;
		always @(*)
			begin
				rqs_priority_next = 2'b00;
				case (xbar_conf_vector_reg)
					RQS0:	rqs_priority_next = PTY_NEXT_RQS1;
					RQS1:	rqs_priority_next = PTY_NEXT_RQS2;
					RQS2:	rqs_priority_next = PTY_NEXT_RQS3;
					RQS3:	rqs_priority_next = PTY_NEXT_RQS0;
				endcase
			end 
	wire [3:0]	grant_vector;
		assign grant_vector[0] = 	(port_request_din[0] & ~rqs_priority_reg[1] & ~rqs_priority_reg[0])																			|
									(port_request_din[0] & ~rqs_priority_reg[1] &  rqs_priority_reg[0] & ~port_request_din[3] & ~port_request_din[2] & ~port_request_din[1])	|
									(port_request_din[0] &  rqs_priority_reg[1] & ~rqs_priority_reg[0] & ~port_request_din[3] & ~port_request_din[2])							|
									(port_request_din[0] &  rqs_priority_reg[1] &  rqs_priority_reg[0] & ~port_request_din[3]);
		assign grant_vector[1] = 	(port_request_din[1] & ~rqs_priority_reg[1] & ~rqs_priority_reg[0] & ~port_request_din[0])													|
									(port_request_din[1] & ~rqs_priority_reg[1] &  rqs_priority_reg[0])																			|
									(port_request_din[1] &  rqs_priority_reg[1] & ~rqs_priority_reg[0] & ~port_request_din[3] & ~port_request_din[2] & ~port_request_din[0])	|
									(port_request_din[1] &  rqs_priority_reg[1] &  rqs_priority_reg[0] & ~port_request_din[3] & ~port_request_din[0]);
		assign grant_vector[2] = 	(port_request_din[2] & ~rqs_priority_reg[1] & ~rqs_priority_reg[0] & ~port_request_din[1] & ~port_request_din[0])							|
									(port_request_din[2] & ~rqs_priority_reg[1] &  rqs_priority_reg[0] & ~port_request_din[1])													|
									(port_request_din[2] &  rqs_priority_reg[1] & ~rqs_priority_reg[0] )																		|
									(port_request_din[2] &  rqs_priority_reg[1] &  rqs_priority_reg[0] & ~port_request_din[3] & ~port_request_din[1] & ~port_request_din[0]);
		assign grant_vector[3] = 	(port_request_din[3] & ~rqs_priority_reg[1] & ~rqs_priority_reg[0] & ~port_request_din[2] & ~port_request_din[1] & ~port_request_din[0])	|
									(port_request_din[3] & ~rqs_priority_reg[1] &  rqs_priority_reg[0] & ~port_request_din[2] & ~port_request_din[1])							|
									(port_request_din[3] &  rqs_priority_reg[1] & ~rqs_priority_reg[0] & ~port_request_din[2])													|
									(port_request_din[3] &  rqs_priority_reg[1] &  rqs_priority_reg[0]);
	always @(posedge clk)
		if (clear_arbiter_din)
			xbar_conf_vector_reg <= {4{1'b0}};
		else 
			if (arbiter_strobe_din)
				xbar_conf_vector_reg <= grant_vector;
	assign xbar_conf_vector_dout = xbar_conf_vector_reg;
endmodule