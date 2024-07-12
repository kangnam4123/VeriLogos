module RPCv3RouterArbiter #(
	parameter TOTAL_PORTS 		= 4,
	parameter CHILD_IS_TRUNK	= 1'b0,
	parameter THIS_PORT			= 0,
	parameter X_POS 						= 4'h0,
	parameter Y_POS 						= 4'h0
) (
	input wire		clk,
	input wire[TOTAL_PORTS-1 : 0]		rx_dst_valid,
	input wire[16*TOTAL_PORTS - 1 : 0]	rx_dst_addr,
	output reg							tx_src_valid	= 0,
	output reg[8:0]						tx_src_port		= 0,
	input wire							tx_done
);
	reg[8:0] 	rr_count	= 0;
	wire[8:0]	rr_count_inc	= rr_count + 1'h1;
	always @(posedge clk) begin
		if(tx_done) begin
			if(rr_count_inc >= TOTAL_PORTS)
				rr_count	<= 0;
			else
				rr_count	<= rr_count_inc;
		end
	end
	localparam BASE_ADDR				= {X_POS, Y_POS, 8'h00};
	localparam CHILD_PORT 				= THIS_PORT - 4;
	reg[TOTAL_PORTS-1:0]	port_match	= 0;
	genvar i;
	generate
		for(i=0; i<TOTAL_PORTS; i=i+1) begin : sendloop
			wire[15:0]	rx_dst	= rx_dst_addr[i*16 +: 16];
			wire[3:0]	rx_xpos	= rx_dst[15:12];
			wire[3:0]	rx_ypos	= rx_dst[11:8];
			wire[15:0]	addrxor	= rx_dst ^ BASE_ADDR[15:8];
			wire		random	= ^addrxor;
			always @(*) begin
				port_match[i]	<= 0;
				case(THIS_PORT)
					0: begin
						if(rx_ypos <= Y_POS)
							port_match[i]	<= 0;
						else begin
							if(rx_xpos == X_POS)
								port_match[i]	<= 1;
							else if(random)
								port_match[i]	<= 1;
							else
								port_match[i]	<= 0;
						end
					end
					1: begin
						if(rx_ypos >= Y_POS)
							port_match[i]	<= 0;
						else begin
							if(rx_xpos == X_POS)
								port_match[i]	<= 1;
							else if(random)
								port_match[i]	<= 1;
							else
								port_match[i]	<= 0;
						end
					end
					2: begin
						if(rx_xpos <= X_POS)
							port_match[i]	<= 0;
						else begin
							if(rx_ypos == Y_POS)
								port_match[i]	<= 1;
							else if(!random)
								port_match[i]	<= 1;
							else
								port_match[i]	<= 0;
						end
					end
					3: begin
						if(rx_xpos >= X_POS)
							port_match[i]	<= 0;
						else begin
							if(rx_ypos == Y_POS)
								port_match[i]	<= 1;
							else if(!random)
								port_match[i]	<= 1;
							else
								port_match[i]	<= 0;
						end
					end
					default: begin
						if(CHILD_IS_TRUNK)
							port_match[i]	<= (rx_dst[15:8] == BASE_ADDR[15:8]);
						else
							port_match[i]	<= (rx_dst == {BASE_ADDR[15:8], CHILD_PORT[7:0]});
					end
				endcase
			end
		end
	endgenerate
	wire[TOTAL_PORTS-1:0]	port_sending_to_us	= port_match & rx_dst_valid;
	always @(posedge clk) begin
	end
endmodule