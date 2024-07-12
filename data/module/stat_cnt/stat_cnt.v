module stat_cnt
#(parameter
	C_CNT_BW = 32
)
(
	input       clk       ,
	input       rstn      ,
	input      [31:0] din,
	input      [31:0] dout,
	input      din_valid,
	input      dout_valid
);
	reg [31:0] indata;
	reg [C_CNT_BW-1:0] incnt;
	reg [31:0] outdata;
	reg [C_CNT_BW-1:0] outcnt;
	wire [31:0] dummy_signal_0; reg [31:0] dummy_signal_1;
	always @(posedge clk or negedge rstn) begin
		if (~rstn) begin
			indata <= 32'h0;
			incnt <= 'h0; 
		end else begin
			if (din_valid) indata <= din;
			if (din_valid) incnt <= incnt + 'h1; 
		end
	end
	always @(posedge clk or negedge rstn) begin
		if (~rstn) begin
			outdata <= 32'h0;
			outcnt <= {C_CNT_BW{1'b0}};
		end else begin
			if (dout_valid) outdata <= dout;
			if (dout_valid) outcnt <= outcnt + 'h1;
		end
	end
	assign dummy_signal_0 = outdata; 
	always @(*) begin dummy_signal_1 = outdata; end
endmodule