module mist1032isa_sync_fifo
	#(
		parameter N = 16,
		parameter DEPTH = 4,
		parameter D_N = 2
	)(
		input wire iCLOCK,
		input wire inRESET,
		input wire iREMOVE,
		output wire [D_N-1:0] oCOUNT,
		input wire iWR_EN,
		input wire [N-1:0] iWR_DATA,
		output wire oWR_FULL,
		input wire iRD_EN,
		output wire [N-1:0] oRD_DATA,
		output wire oRD_EMPTY
	);
	wire [D_N:0] count;
	reg [D_N:0] b_write_pointer;
	reg [D_N:0] b_read_pointer;
	reg [N-1:0] b_memory [0 : DEPTH-1];
	assign count = b_write_pointer - b_read_pointer;
	always@(posedge iCLOCK or negedge inRESET)begin
		if(!inRESET)begin
			b_write_pointer <= {D_N+1{1'b0}};
			b_read_pointer <= {D_N+1{1'b0}};
		end
		else if(iREMOVE)begin
			b_write_pointer <= {D_N+1{1'b0}};
			b_read_pointer <= {D_N+1{1'b0}};
		end
		else begin
			if(iWR_EN)begin
				b_write_pointer <= b_write_pointer + {{D_N-1{1'b0}}, 1'b1};
				b_memory [b_write_pointer[D_N-1:0]] <= iWR_DATA;
			end
			if(iRD_EN)begin
				b_read_pointer <= b_read_pointer + {{D_N-1{1'b0}}, 1'b1};
			end
		end
	end 
	assign oRD_DATA = b_memory	[b_read_pointer[D_N-1:0]];
	assign oRD_EMPTY = ((b_write_pointer - b_read_pointer) ==  {D_N+1{1'b0}})? 1'b1 : 1'b0;
	assign oWR_FULL = count[D_N];
	assign oCOUNT = count	[D_N-1:0];
endmodule