module i2s_tx #(parameter DATA_WIDTH = 16
				) (clk, left_chan, right_chan, sdata, lrclk, mck, sck);
input wire clk; 
input wire [DATA_WIDTH-1:0] left_chan;
input wire [DATA_WIDTH-1:0] right_chan;
output reg sdata; initial sdata <= 1'b0;
output wire mck, sck, lrclk;
reg [9:0]  mck_div; initial mck_div<=10'd0;
parameter LR_BIT = 9; 
parameter SCK_BIT = LR_BIT - 6; 
parameter MCK_BIT = 1;
assign mck   = ~mck_div[MCK_BIT];
assign lrclk = mck_div[LR_BIT];
assign sck   = mck_div[SCK_BIT];
reg lrclk_prev; initial lrclk_prev <= 1'b1;
wire lrclk_change = ~(lrclk_prev == lrclk);
reg [DATA_WIDTH-1:0] ch_data; initial ch_data <= {DATA_WIDTH{1'b0}};
reg sck_prev; initial sck_prev <= 1'b0;
wire sck_neg = (sck_prev==1'b1 && sck==1'b0);
always @(posedge clk) begin
	mck_div <= mck_div + 1'b1;
	lrclk_prev <= lrclk;
	sck_prev <= sck;
	if (sck_neg) begin
		if (lrclk_change) begin
			ch_data <= (lrclk) ? left_chan : right_chan;
		end else begin
			ch_data <= ch_data << 1;
		end
		sdata <= ch_data[DATA_WIDTH-1];
	end
end
endmodule