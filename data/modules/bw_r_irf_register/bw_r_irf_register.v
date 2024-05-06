module bw_r_irf_register(clk, wren, save, save_addr, restore, restore_addr, wr_data, rd_data);
	input		clk;
	input		wren;
	input		save;
	input	[2:0]	save_addr;
	input		restore;
	input	[2:0]	restore_addr;
	input	[71:0]	wr_data;
	output	[71:0]	rd_data;
reg	[71:0]	window[7:0];
reg	[71:0]	onereg;
reg	[2:0]	rd_addr;
reg	[2:0]	wr_addr;
reg		save_d;
  initial onereg = 72'b0;
  always @(negedge clk) begin
    rd_addr = restore_addr;
  end
  always @(posedge clk) begin
    wr_addr <= save_addr;
  end
  always @(posedge clk) begin
    save_d <= save;
  end
  assign rd_data = onereg;
  wire [71:0] restore_data = window[rd_addr];
  wire [71:0] wrdata = restore ? restore_data : wr_data;
  wire wr_en = wren | (restore & (wr_addr != rd_addr));
  always @(posedge clk) begin
    if(wr_en) onereg <= wrdata;
  end
  always @(negedge clk) begin
    if(save_d) window[wr_addr] <= rd_data;
  end
endmodule