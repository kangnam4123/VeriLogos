module fifo1(
	input clk_i, 
	input rst_i, 
	input [g_width-1:0] data_i, 
	input push_i,
	input pull_i,
	output [g_width-1:0] data_o, 
	output full_o, 
	output empty_o
);
	parameter g_width = 32;
	reg     [g_width-1:0]		mem;
	reg								full;
	reg								empty;
	initial mem = 0;
	always @(posedge clk_i, negedge rst_i)
        if(!rst_i)
		  begin
			empty <= 1;
			full <= 0;
		  end
        else
		  begin
				if(push_i & !full)
				begin
				    empty <= 0;
					 mem <= data_i;
					 full <= 1;
				end
				else if (pull_i & !empty)
				begin
					empty <= 1;
					full <= 0;
				end
			end
	assign  data_o = mem;
	assign empty_o = empty;
	assign full_o  = full;
endmodule