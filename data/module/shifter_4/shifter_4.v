module shifter_4 #(parameter 	NO_OF_MSGS=8, MSG_WIDTH=4, B=3, PATTERN_WIDTH=6, 
							SHIFT_WIDTH=$clog2(PATTERN_WIDTH-B+1)+1,DATA_WIDTH=2*NO_OF_MSGS*MSG_WIDTH,NOS_SHIFTER=2*NO_OF_MSGS,
							POINTER_WIDTH=$clog2(NOS_SHIFTER),MAX_PAT_SZ=22)
			( 	input clk,
				input Reset,
				input input_ready,
				input [DATA_WIDTH-1:0] data_in,
				input [SHIFT_WIDTH-1:0] shift_count,
			 	output reg [MSG_WIDTH*PATTERN_WIDTH-1:0] data_out,
				output reg [POINTER_WIDTH-1:0]  pointer,
				output reg [MSG_WIDTH*MAX_PAT_SZ-1:0] data_nfa,
			 	output reg datald);
wire [POINTER_WIDTH-1:0] tmp_pointer;
wire [MSG_WIDTH*PATTERN_WIDTH-1:0] data_out_wire[NOS_SHIFTER-1:0];
wire [MSG_WIDTH*MAX_PAT_SZ-1:0] data_nfa_wr [NOS_SHIFTER-1:0];
reg start;
always@(posedge clk)
begin
		if (Reset) begin
			pointer <= 0;
			data_out <= 0;
			data_nfa <= 0;
			start  <= 0;
			datald <= 1;
		end
		else begin
			if(input_ready == 1) begin
			     start <= 1;
			end
			if (start == 1) begin
					pointer <=tmp_pointer;
					data_out <= data_out_wire[tmp_pointer];
					data_nfa <= data_nfa_wr[tmp_pointer];
					if(tmp_pointer > NO_OF_MSGS)
						datald <= 0;
					else 
						datald <= 1;
			end
		end
end
assign tmp_pointer = pointer + {{(POINTER_WIDTH-SHIFT_WIDTH){1'b0}},shift_count};
generate
	genvar i;
	for(i=0;i<NOS_SHIFTER;i=i+1) 
	begin: muxshift
		if(NOS_SHIFTER-i < PATTERN_WIDTH)
			assign data_out_wire[i] = {data_in[MSG_WIDTH*(NOS_SHIFTER-i)-1:0],data_in[DATA_WIDTH-1: DATA_WIDTH-MSG_WIDTH*(PATTERN_WIDTH-(NOS_SHIFTER-i))]};
		else
			assign data_out_wire[i] = data_in[DATA_WIDTH-MSG_WIDTH*i-1: DATA_WIDTH-MSG_WIDTH*(i+PATTERN_WIDTH)];
	end
endgenerate
generate
	genvar j;
	for(j=0;j<NOS_SHIFTER;j=j+1) 
	begin: muxnfa
		if(NOS_SHIFTER-j < MAX_PAT_SZ)
			assign data_nfa_wr[j] = {data_in[MSG_WIDTH*(NOS_SHIFTER-j)-1:0],data_in[DATA_WIDTH-1: DATA_WIDTH-MSG_WIDTH*(MAX_PAT_SZ-(NOS_SHIFTER-j))]};
		else
			assign data_nfa_wr[j] = data_in[DATA_WIDTH-MSG_WIDTH*j-1: DATA_WIDTH-MSG_WIDTH*(j+MAX_PAT_SZ)];
	end
endgenerate
endmodule