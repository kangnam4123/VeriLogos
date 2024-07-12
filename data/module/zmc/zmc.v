module zmc(
	input SDRD0,
	input [1:0] SDA_L,
	input [15:8] SDA_U,
	output [21:11] MA
);
	wire BANKSEL = SDA_U[15:8];		
	reg [7:0] RANGE_0;					
	reg [7:0] RANGE_1;					
	reg [7:0] RANGE_2;					
	reg [7:0] RANGE_3;
	assign MA = SDA_U[15] ?				
						~SDA_U[14] ?
							{RANGE_3, SDA_U[13:11]} :					
							~SDA_U[13] ?
								{1'b0, RANGE_2, SDA_U[12:11]} :		
								~SDA_U[12] ?
									{2'b00, RANGE_1, SDA_U[11]} :		
									{3'b000, RANGE_0} :					
					{6'b000000, SDA_U[15:11]};							
	always @(posedge SDRD0)
	begin
		case (SDA_L)
			0: RANGE_0 <= BANKSEL;
			1: RANGE_1 <= BANKSEL;
			2: RANGE_2 <= BANKSEL;
			3: RANGE_3 <= BANKSEL;
		endcase
	end
endmodule