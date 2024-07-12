module axi_master_stub(
    output M2S_AXI_ACLK,
    output M2S_AXI_ARVALID,
    input M2S_AXI_ARREADY,
    output [31:0] M2S_AXI_ARADDR,
    output [1:0] M2S_AXI_ARBURST,
    output [3:0] M2S_AXI_ARLEN,
    output [1:0] M2S_AXI_ARSIZE,
    input M2S_AXI_RVALID,
    output M2S_AXI_RREADY,
    input M2S_AXI_RLAST,
    input [63:0] M2S_AXI_RDATA,
    input [1:0] M2S_AXI_RRESP,
    output M2S_AXI_AWVALID,
    input M2S_AXI_AWREADY,
    output [31:0] M2S_AXI_AWADDR,
    output [1:0] M2S_AXI_AWBURST,
    output [3:0] M2S_AXI_AWLEN,
    output [1:0] M2S_AXI_AWSIZE,
    output M2S_AXI_WVALID,
    input M2S_AXI_WREADY,
    output M2S_AXI_WLAST,
    output [63:0] M2S_AXI_WDATA,
    output [7:0] M2S_AXI_WSTRB,
    input M2S_AXI_BVALID,
    output M2S_AXI_BREADY,
    input [1:0] M2S_AXI_BRESP
);
    assign M2S_AXI_ACLK = 1'b0;
    assign M2S_AXI_ARVALID = 1'b0;
    assign M2S_AXI_ARADDR = 32'b0;
    assign M2S_AXI_ARBURST = 2'b0;
    assign M2S_AXI_ARLEN = 4'b0;
    assign M2S_AXI_ARSIZE = 2'b0;
    assign M2S_AXI_RREADY = 1'b0;
    assign M2S_AXI_AWVALID = 1'b0;
    assign M2S_AXI_AWADDR = 32'b0;
    assign M2S_AXI_AWBURST = 2'b0;
    assign M2S_AXI_AWLEN = 4'b0;
    assign M2S_AXI_AWSIZE = 2'b0;
    assign M2S_AXI_WVALID = 1'b0;
    assign M2S_AXI_WLAST = 1'b0;
    assign M2S_AXI_WDATA = 64'b0;
    assign M2S_AXI_WSTRB = 8'b0;
    assign M2S_AXI_BREADY = 1'b0;
endmodule