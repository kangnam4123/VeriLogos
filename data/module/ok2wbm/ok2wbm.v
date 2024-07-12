module ok2wbm(
		input  wire wb_clk_i,
		input  wire wb_rst_i,
		input  wire wb_ack_i,
		input  wire wb_int_i,
		output reg  wb_cyc_o,
		output reg  wb_stb_o,
		output reg  wb_we_o,
		input  wire [15:0] wb_data_i,
		output reg  [15:0] wb_data_o,
		output wire [4:0] wb_addr_o,
		output wire [1:0] wb_sel_o,
		output reg  [2:0] wb_cti_o,
		output wire trg_irq,
		output wire trg_done,
		output wire busy,
		input  wire trg_sngl_rd,
		input  wire trg_sngl_wr,
		input  wire trg_brst_rd,
		input  wire trg_brst_wr,
		input  wire brst_rd,
		input  wire brst_wr,
		input  wire [15:0] addr_in,		
		input  wire [15:0] sngl_data_in,
		output reg  [15:0] sngl_data_out,
		input  wire [15:0] brst_data_in,
		output wire [15:0] brst_data_out,
		output wire [15:0] debug_out
	);
assign debug_out = sngl_data_out;
assign wb_sel_o = 2'b11;
wire sot;
assign sot = trg_sngl_rd | trg_sngl_wr | trg_brst_rd | trg_delay_wr[1];
wire eot;
assign eot = wb_stb_o & ((wb_we_o & ~brst_wr) | (rd_burst_live & ~brst_rd));
reg [1:0] trg_delay_wr;
always @(posedge wb_clk_i) begin
	trg_delay_wr <= {trg_delay_wr[0], trg_brst_wr};
end
reg rd_burst_live;
reg wr_burst_live;
always @(posedge wb_clk_i) begin
	rd_burst_live <= (trg_brst_rd | rd_burst_live) & ~(eot | wb_rst_i);
	wr_burst_live <= (trg_delay_wr[1] | wr_burst_live) & ~(eot | wb_rst_i);
end
wire burst_mode;
assign burst_mode = rd_burst_live | wr_burst_live;
assign trg_done = (wb_ack_i & ~burst_mode) | eot;
always @(burst_mode or eot) begin
	if (burst_mode & ~eot)
		wb_cti_o = 3'b001;	
	else if (burst_mode & eot)
		wb_cti_o = 3'b111;	
	else
		wb_cti_o = 3'b000;	
end
always @(posedge wb_clk_i) begin
	wb_cyc_o <=  (sot | wb_cyc_o) & ~(trg_done | wb_rst_i);
	wb_stb_o <=  (sot | wb_stb_o) & ~(trg_done | wb_rst_i);
end
assign busy = wb_cyc_o;
always @(posedge wb_clk_i) begin
	if (burst_mode)
		wb_data_o <= brst_data_in;
	else
		wb_data_o <= sngl_data_in;
end
assign wb_addr_o = addr_in[4:0];
assign irq = wb_int_i;
assign brst_data_out = wb_data_i;
always @(posedge wb_clk_i) begin
	if (wb_ack_i &&  wb_stb_o && wb_cyc_o)
		sngl_data_out <= wb_data_i;
	else
		sngl_data_out <= sngl_data_out; 
end
always @(posedge wb_clk_i) begin
	wb_we_o <= (trg_sngl_wr | wr_burst_live | wb_we_o) & ~(trg_done | wb_rst_i);
end
endmodule