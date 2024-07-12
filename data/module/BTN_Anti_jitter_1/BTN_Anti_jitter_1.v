module BTN_Anti_jitter_1(
	input wire clk,
	input wire [4:0]button,
	input wire [7:0]SW,
	output reg [4:0]button_out,
	output reg [7:0]SW_OK
    );
reg [31:0] counter;
always @(posedge clk)begin
	if (counter > 0)begin
		if (counter < 100000)            
			counter <= counter + 1;
		else begin
			counter <= 32'b0;
			button_out <= button;
			SW_OK <= SW;
		end
	end else
	if (button >0 || SW > 0)
		counter <= counter + 1;
end
endmodule