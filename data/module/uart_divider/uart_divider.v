module uart_divider
	#(parameter COUNT = 0, CLK2_MUL = 5)
	(input sys_clk,
	 input reset,
	 output reg outclk,
	 output reg outclk2);
	localparam BITS  = $clog2(COUNT);
	reg [(BITS-1):0] counter;
	always @(posedge sys_clk or posedge reset)
	begin
		if(reset) begin
			counter <= 'b0;
			outclk <= 'b0;
		end else begin
			if(counter == (COUNT - 1)) begin
				counter <= 'b0;
				outclk <= ~outclk;
			end else
				counter <= counter + 1'b1;
		end
	end
	localparam COUNT2 = COUNT / CLK2_MUL;
	localparam BITS2 = $clog2(COUNT2);
	reg [(BITS2-1):0] counter2;
	always @(posedge sys_clk or posedge reset)
	begin
		if(reset) begin
			counter2 <= 'b0;
			outclk2 <= 'b0;
		end else begin
			if(counter2 == (COUNT2 - 1)) begin
				counter2 <= 'b0;
				outclk2 <= ~outclk2;
			end else
				counter2 <= counter2 + 1'b1;
		end
	end
endmodule