module SSDS_spoof(
	clk,
	cyc,
	ack,
	we,
	err,
	clk_count,
	data_out,
	reset
	);
input		clk;
input		cyc;
input		ack;
input		we;
input		err;
input	[31:0]	clk_count;
input		reset;
output	[31:0]	data_out;
wire	[31:0]	clk_count;
wire		cyc;
wire		ack;
wire		we;
wire		clk;
wire		reset;
wire		err;
reg 	[31:0]	data_out;
reg	[31:0]	CountRead;
reg	[31:0]	CountRead_Next;
reg	[31:0]	CountWrite;
reg	[31:0]	CountWrite_Next;
reg	[31:0]	Clk_Counter;
reg	[31:0]	Clk_Counter_Next;
reg	[3:0]	HoldCycles;
reg	[3:0]	HoldCycles_Next;
reg	[2:0]	CurrentState;
reg	[2:0]	NextState;
localparam	STATE_Initial		= 3'd0,
		STATE_1			= 3'd1,
		STATE_2			= 3'd2,
		STATE_3			= 3'd3,
		STATE_4			= 3'd4,
		STATE_5_Placeholder	= 3'd5,
		STATE_6_Placeholder	= 3'd6,
		STATE_7_Placeholder	= 3'd7;
localparam	OUTPUT_TIME		= 4'd3;
always@ (posedge clk)
begin: STATE_TRANS
	if(reset == 1)
		begin
		CurrentState	<= STATE_Initial;
		Clk_Counter	<= clk_count;
		CountRead		<= 0;
		CountWrite		<= 0;
		HoldCycles	<= 0;
		HoldCycles_Next	<= 0;
		CountRead_Next	<= 0;
		CountWrite_Next	<= 0;
		end
	else 
		begin
		CurrentState <= NextState;
		Clk_Counter <= Clk_Counter_Next;
		HoldCycles <= HoldCycles_Next;
		CountRead <= CountRead_Next;
		CountWrite <= CountWrite_Next;
		end
end
always@ (posedge clk)
begin: OUTPUT_LOGIC
	if(reset == 1)
		data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
	else
	begin 
		case(CurrentState)
		STATE_Initial:		data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
		STATE_1:		data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
		STATE_2:		data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;		
		STATE_3:		data_out<=CountRead;
		STATE_4:		data_out<=CountWrite;
		STATE_5_Placeholder:	data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
		STATE_6_Placeholder:	data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
		STATE_7_Placeholder:	data_out<=32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;		
		endcase		
	end
end
always@ (*)
	begin
	if(Clk_Counter == 32'b00000000000000000000000000000000)		
		begin
		NextState = STATE_3;
		Clk_Counter_Next <= clk_count;				
		HoldCycles_Next <= OUTPUT_TIME;				
		end
	else
		begin
		case(CurrentState)
			STATE_Initial: begin
				Clk_Counter_Next <= Clk_Counter-1;
				if(cyc)
					begin
					if(we) NextState <= STATE_1;
					else NextState <= STATE_2;
					end
				else NextState <= STATE_Initial;
				end	
			STATE_1: begin
				Clk_Counter_Next <= Clk_Counter-1;
				if(err)
					begin 
					NextState <= STATE_Initial;
					end 
				else
					begin 
					if(!cyc)
						begin 
						NextState <= STATE_Initial;
						CountRead_Next <= CountRead+1;
						end
					end
				end
			STATE_2: begin
				Clk_Counter_Next <= Clk_Counter-1;
				if(err)
					begin 
					NextState <= STATE_Initial;
					end
				else
					begin 
					if(!cyc)
						begin 
						NextState <= STATE_Initial;
						CountWrite_Next <= CountWrite+1;
						end
					end
				end				
			STATE_3: begin
				if(HoldCycles == 4'b0000)
					begin
					NextState <= STATE_4;
					HoldCycles_Next <= OUTPUT_TIME;
					end
				else
					begin
					NextState <= STATE_3;
					HoldCycles_Next <= HoldCycles-1;
					end
				end
			STATE_4: begin
				if(HoldCycles == 4'b0000)
					begin
					NextState <= STATE_Initial;		
					HoldCycles_Next <= OUTPUT_TIME;
					CountRead_Next <= 0;
					CountWrite_Next <= 0;
					Clk_Counter_Next <= clk_count;
					end
				else
					begin
					NextState <= STATE_4;
					HoldCycles_Next <= HoldCycles-1;
					end
				end
			STATE_5_Placeholder: begin
				end
			STATE_6_Placeholder: begin
				end
			STATE_7_Placeholder: begin
				end
		endcase
		end
	end
endmodule