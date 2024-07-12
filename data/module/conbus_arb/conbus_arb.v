module conbus_arb(
	input sys_clk,
	input sys_rst,
	input [6:0] req,
	output [6:0] gnt
);
parameter [6:0] grant0 = 7'b0000001,
                grant1 = 7'b0000010,
                grant2 = 7'b0000100,
                grant3 = 7'b0001000,
                grant4 = 7'b0010000,
                grant5 = 7'b0100000,
                grant6 = 7'b1000000;
reg [6:0] state;
reg [6:0] next_state;
assign gnt = state;
always @(posedge sys_clk) begin
	if(sys_rst)
		state <= grant0;
	else
		state <= next_state;
end
always @(*) begin
	next_state = state;
	case(state)
		grant0: begin
			if(~req[0]) begin
				     if(req[1]) next_state = grant1;
				else if(req[2]) next_state = grant2;
				else if(req[3]) next_state = grant3;
				else if(req[4]) next_state = grant4;
				else if(req[5]) next_state = grant5;
				else if(req[6]) next_state = grant6;
			end
		end
		grant1: begin
			if(~req[1]) begin
				     if(req[2]) next_state = grant2;
				else if(req[3]) next_state = grant3;
				else if(req[4]) next_state = grant4;
				else if(req[5]) next_state = grant5;
				else if(req[6]) next_state = grant6;
				else if(req[0]) next_state = grant0;
			end
		end
		grant2: begin
			if(~req[2]) begin
				     if(req[3]) next_state = grant3;
				else if(req[4]) next_state = grant4;
				else if(req[5]) next_state = grant5;
				else if(req[6]) next_state = grant6;
				else if(req[0]) next_state = grant0;
				else if(req[1]) next_state = grant1;
			end
		end
		grant3: begin
			if(~req[3]) begin
				     if(req[4]) next_state = grant4;
				else if(req[5]) next_state = grant5;
				else if(req[6]) next_state = grant6;
				else if(req[0]) next_state = grant0;
				else if(req[1]) next_state = grant1;
				else if(req[2]) next_state = grant2;
			end
		end
		grant4: begin
			if(~req[4]) begin
				     if(req[5]) next_state = grant5;
				else if(req[6]) next_state = grant6;
				else if(req[0]) next_state = grant0;
				else if(req[1]) next_state = grant1;
				else if(req[2]) next_state = grant2;
				else if(req[3]) next_state = grant3;
			end
		end
		grant5: begin
			if(~req[5]) begin
				     if(req[6]) next_state = grant6;
				else if(req[0]) next_state = grant0;
				else if(req[1]) next_state = grant1;
				else if(req[2]) next_state = grant2;
				else if(req[3]) next_state = grant3;
				else if(req[4]) next_state = grant4;
			end
		end
		grant6: begin
			if(~req[6]) begin
				     if(req[0]) next_state = grant0;
				else if(req[1]) next_state = grant1;
				else if(req[2]) next_state = grant2;
				else if(req[3]) next_state = grant3;
				else if(req[4]) next_state = grant4;
				else if(req[5]) next_state = grant5;
			end
		end
	endcase
end
endmodule