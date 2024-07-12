module BTN_OK(
		input clk,
		input BTN,
		output reg BTN_out
	);
	wire BTN_Down;
	reg BTN1;
	reg BTN2;
	reg [23:0] cnt;
	reg BTN_20ms_1, BTN_20ms_2;
	always @(posedge clk)
	begin
		BTN1 <= BTN;
		BTN2 <= BTN1;
	end
	assign BTN_Down = (~BTN2)&&BTN1;
	always @(posedge clk)
	begin
		if(BTN_Down)
			begin
				cnt <= 24'b0;
				BTN_out <= 1'b1;
			end
		else
			begin
				cnt<=cnt+1'b1;
			end
		if(cnt == 24'h1E8480)
			BTN_out <= 1'b0;
	end
endmodule