module spi_master_2(rstb, clk, mlb, start, tdat, cdiv, 
				  din,  ss, sck, dout, done_r, rdata);
parameter state_idle   = 4'd0;		
parameter state_send   = 4'd1; 
parameter state_finish = 4'd2;
input 		 rstb, clk, mlb, start;
input [31:0] tdat;  
input [1:0]  cdiv;  
input 		 din;
output reg 	 ss; 
output reg 	 sck; 
output reg 	 dout; 
output reg 	 done_r;
output reg 	 [31:0] rdata; 
wire [4:0] 	mid;
reg [3:0] 	current_state,next_state;
reg [31:0] 	treg,rreg;
reg [31:0] 	rdata_next;
reg [31:0] 	nbit;
reg [4:0] 	cnt;
reg 		shift, clr;
reg			done;
assign mid = 1;
always @ (negedge clk or negedge rstb) begin
	if (rstb == 0) 
		done_r  <= 1'b0;
	else 
		if (current_state == state_finish)
			done_r <= 1'b1;
		else 
			done_r <= 1'b0;
end
always @ (negedge clk or negedge rstb) begin
	if (rstb == 0) begin
		current_state <= state_finish;
		rdata         <= 0;
	end
	else begin
		current_state <= next_state;
		rdata         <= rdata_next;
	end
end
always  @ (start or current_state or nbit or cdiv or rreg or rdata) begin
	clr   = 0;  
	shift = 0;
	ss    = 1; 
	rdata_next = rdata;
	next_state = current_state;
	case(current_state)
		state_idle: begin 
			#1 
			if (start == 1) begin 
				shift      = 1;
				next_state = state_send;	 
	        end
	    end    
		state_send: begin 
			ss = 0;
			if (nbit != 32) begin
				shift = 1; 
			end
			else begin
				rdata_next = rreg;
				next_state = state_finish;
			end
		end		
		state_finish: begin 
			shift = 0;
			ss    = 1;
			clr   = 1;
			next_state = state_idle;
		end
		default: next_state = state_finish;
	endcase
end
always @ (negedge clk or posedge clr) begin
	if (clr == 1) begin
		cnt = 5'd0; 
		sck = 0; 
	end 
	else begin
		if (shift == 1) begin
			cnt = cnt + 5'd1; 
			if (cnt == mid) begin
				sck = ~sck;
				cnt = 5'd0;
			end
		end 
	end 
end 
always @ (negedge sck or posedge clr ) begin 
	if (clr == 1)  begin
		nbit = 7'd0;  
		rreg = 32'hFFFF_FFFF;  
	end 
	else begin 
		if (mlb == 0) begin 
			rreg = { din, rreg[31:1] };  
		end 
		else begin 
			rreg = { rreg[30:0], din };  
		end
		nbit = nbit + 7'd1;
	end
end 
always @ (posedge sck or posedge clr) begin
	if (clr == 1) begin
	  	treg = 32'h0;  
	  	dout = 0;  
	end  
	else begin
		if (nbit == 0) begin 
			treg = tdat; 
			dout = mlb ? treg[31] : treg[0];
		end 
		else begin
			if (mlb == 0) begin 
				treg = { 1'b1, treg[31:1] }; 
				dout = treg[0]; 
			end 
			else begin 
				treg = { treg[30:0], 1'b1 }; 
				dout = treg[31]; 
			end
		end
	end 
end
endmodule