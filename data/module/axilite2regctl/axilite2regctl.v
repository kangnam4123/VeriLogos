module axilite2regctl #
(
	parameter integer C_DATA_WIDTH	= 32,
	parameter integer C_ADDR_WIDTH	= 10,
	parameter integer C_REG_IDX_WIDTH = 8
)
(
	input wire  clk,
	input wire  resetn,
	output rd_en,
	output [C_REG_IDX_WIDTH-1:0] rd_addr,
	input [C_DATA_WIDTH-1:0] rd_data,
	output wr_en,
	output [C_REG_IDX_WIDTH-1:0] wr_addr,
	output [C_DATA_WIDTH-1:0] wr_data,
	input wire [C_ADDR_WIDTH-1 : 0] s_axi_awaddr,
	input wire  s_axi_awvalid,
	output wire  s_axi_awready,
	input wire [C_DATA_WIDTH-1 : 0] s_axi_wdata,
	input wire  s_axi_wvalid,
	output wire  s_axi_wready,
	output wire [1 : 0] s_axi_bresp,
	output wire  s_axi_bvalid,
	input wire  s_axi_bready,
	input wire [C_ADDR_WIDTH-1 : 0] s_axi_araddr,
	input wire  s_axi_arvalid,
	output wire  s_axi_arready,
	output wire [C_DATA_WIDTH-1 : 0] s_axi_rdata,
	output wire [1 : 0] s_axi_rresp,
	output wire  s_axi_rvalid,
	input wire  s_axi_rready
);
	reg [C_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg  	axi_bvalid;
	reg  	axi_arready;
	reg  	axi_rvalid;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	integer	 byte_index;
	reg	 aw_en;
	assign rd_en = slv_reg_rden;
	assign rd_addr = s_axi_araddr[C_ADDR_WIDTH-1:C_ADDR_WIDTH-C_REG_IDX_WIDTH];
	assign wr_addr = axi_awaddr[C_ADDR_WIDTH-1:C_ADDR_WIDTH-C_REG_IDX_WIDTH];
	assign wr_en = slv_reg_wren;
	assign wr_data = s_axi_wdata;
	assign s_axi_awready	= axi_awready;
	assign s_axi_wready	= axi_wready;
	assign s_axi_bresp	= 0;
	assign s_axi_bvalid	= axi_bvalid;
	assign s_axi_arready	= axi_arready;
	assign s_axi_rdata	= rd_data;
	assign s_axi_rresp	= 0;
	assign s_axi_rvalid	= axi_rvalid;
	always @( posedge clk )
	begin
		if ( resetn == 1'b0 ) begin
			axi_awready <= 1'b0;
			aw_en <= 1'b1;
		end
		else if (~axi_awready && s_axi_awvalid && s_axi_wvalid && aw_en) begin
			axi_awready <= 1'b1;
			aw_en <= 1'b0;
		end
		else if (s_axi_bready && axi_bvalid) begin
			aw_en <= 1'b1;
			axi_awready <= 1'b0;
		end
		else begin
			axi_awready <= 1'b0;
		end
	end
	always @( posedge clk )
	begin
		if ( resetn == 1'b0 )
			axi_awaddr <= 0;
		else if (~axi_awready && s_axi_awvalid && s_axi_wvalid && aw_en)
			axi_awaddr <= s_axi_awaddr;
		else
			axi_awaddr <= axi_awaddr;
	end
	always @( posedge clk ) begin
		if ( resetn == 1'b0 )
			axi_wready <= 1'b0;
		else if (~axi_wready && s_axi_wvalid && s_axi_awvalid && aw_en )
			axi_wready <= 1'b1;
		else
			axi_wready <= 1'b0;
	end
	assign slv_reg_wren = axi_wready && s_axi_wvalid && axi_awready && s_axi_awvalid;
	always @( posedge clk )
	begin
		if ( resetn == 1'b0 )
			axi_bvalid  <= 0;
		else if (axi_awready && s_axi_awvalid && ~axi_bvalid && axi_wready && s_axi_wvalid)
			axi_bvalid <= 1'b1;
		else if (s_axi_bready && axi_bvalid)
			axi_bvalid <= 1'b0;
	end
	always @( posedge clk ) begin
		if ( resetn == 1'b0 )
			axi_arready <= 1'b0;
		else if (~axi_arready && s_axi_arvalid)
			axi_arready <= 1'b1;
		else
			axi_arready <= 1'b0;
	end
	always @( posedge clk ) begin
		if ( resetn == 1'b0 )
			axi_rvalid <= 0;
		else if (axi_arready && s_axi_arvalid && ~axi_rvalid)
			axi_rvalid <= 1'b1;
		else if (axi_rvalid && s_axi_rready)
			axi_rvalid <= 1'b0;
	end
	assign slv_reg_rden = axi_arready & s_axi_arvalid & ~axi_rvalid;
endmodule