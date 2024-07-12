module ps2_keyboard (
CLK,
RESET_N,
PS2_CLK,
PS2_DATA,
RX_PRESSED,
RX_EXTENDED,
RX_SCAN
);
input					CLK;
input					RESET_N;
input					PS2_CLK;
input					PS2_DATA;
output				RX_PRESSED;
reg					RX_PRESSED;
output				RX_EXTENDED;
reg					RX_EXTENDED;
output	[7:0]		RX_SCAN;
reg		[7:0]		RX_SCAN;
reg					KB_CLK;
reg					KB_DATA;
reg					KB_CLK_B;
reg					KB_DATA_B;
reg					PRESSED_N;
reg					EXTENDED;
reg		[2:0]		BIT;
reg		[3:0]		STATE;
reg		[7:0]		SCAN;
wire					PARITY;
reg		[10:0]	TIMER;
reg					KILLER;
wire					RESET_X;
always @ (posedge CLK)
begin
	KB_CLK_B		<=	PS2_CLK;
	KB_DATA_B	<= PS2_DATA;
	KB_CLK		<= KB_CLK_B;
	KB_DATA		<= KB_DATA_B;
end
assign PARITY =	~(((SCAN[0]^SCAN[1])
						  ^(SCAN[2]^SCAN[3]))
						 ^((SCAN[4]^SCAN[5])
						  ^(SCAN[6]^SCAN[7])));
assign RESET_X = RESET_N & KILLER;
always @ (negedge CLK or negedge RESET_N)
	if(!RESET_N)
	begin
		KILLER <= 1'b1;
		TIMER <= 11'h000;
	end
	else
		case(TIMER)
		11'h000:
		begin
			KILLER <= 1'b1;
			if(STATE != 4'h0)
				TIMER <= 11'h001;
		end
		11'h7FD:
		begin
			KILLER <= 1'b0;
			TIMER <= 11'h7FE;
		end
		default:
			if(STATE == 4'h0)
				TIMER <= 11'h000;
			else
				TIMER <= TIMER + 1'b1;
		endcase
always @ (posedge CLK or negedge RESET_X)
begin
	if(!RESET_X)
	begin
		STATE				<= 4'h0;
		SCAN				<= 8'h00;
		BIT				<= 3'b000;
		RX_SCAN			<=	8'h00;
		RX_PRESSED		<= 1'b0;
		RX_EXTENDED		<= 1'b0;
		PRESSED_N		<= 1'b0;
		EXTENDED			<= 1'b0;
	end
	else
	begin
		case (STATE)
		4'h0:						
		begin
			BIT				<= 3'b000;
			RX_SCAN			<= 8'h00;
			RX_PRESSED		<= 1'b0;
			RX_EXTENDED		<= 1'b0;
			if(~KB_DATA & ~KB_CLK)				
					STATE			<= 4'h1;
		end
		4'h1:						
		begin
			if(KB_CLK)
				STATE				<= 4'h2;
		end
		4'h2:						
		begin
			if(~KB_CLK)
			begin
				SCAN[BIT]		<= KB_DATA;
				BIT				<= BIT + 1'b1;
				if(BIT == 3'b111)
					STATE				<= 4'h3;
				else
					STATE				<= 4'h1;
			end
		end
		4'h3:						
		begin
			if(KB_CLK)
				STATE	<= 4'h4;
		end
		4'h4:						
		begin
			if(~KB_CLK)
			begin
				if(KB_DATA == PARITY)
					STATE				<= 4'h5;
				else
				begin
					PRESSED_N	<= 1'b0;
					EXTENDED		<= 1'b0;
					SCAN			<= 8'h00;
					STATE			<= 4'hF;
				end
			end
		end
		4'h5:						
		begin
			if(KB_CLK)
				STATE	<= 4'h6;
		end
		4'h6:						
		begin
			if(~KB_CLK)
				STATE	<= 4'h7;
		end
		4'h7:
		begin
			if(SCAN ==8'hE0)
			begin
				EXTENDED <= 1'b1;
				STATE		<= 4'hF;
			end
			else
				if(SCAN == 8'hF0)
				begin
					PRESSED_N	<= 1'b1;
					STATE			<= 4'hF;
				end
				else
				begin
					RX_SCAN		<= SCAN;
					RX_PRESSED	<= ~PRESSED_N;
					RX_EXTENDED	<= EXTENDED;
					PRESSED_N	<= 1'b0;
					EXTENDED		<= 1'b0;
					SCAN			<= 8'h00;
					STATE			<= 4'hF;
				end
			end
		4'h8:
		begin
			STATE				<= 4'h9;
		end
		4'h9:
		begin
			STATE				<= 4'hA;
		end
		4'hA:
		begin
			STATE				<= 4'hB;
		end
		4'hB:
		begin
			STATE				<= 4'hC;
		end
		4'hC:
		begin
			STATE				<= 4'hD;
		end
		4'hD:
		begin
			STATE				<= 4'hE;
		end
		4'hE:
		begin
			STATE				<= 4'hF;
		end
		4'hF:
		begin
			if(KB_CLK)
				STATE			<= 4'h0;
		end
		endcase
	end
end
endmodule