module axi_master_read_stub(
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
    input [1:0] M2S_AXI_RRESP
);
    assign M2S_AXI_ACLK = 1'b0;
    assign M2S_AXI_ARVALID = 1'b0;
    assign M2S_AXI_ARADDR = 32'b0;
    assign M2S_AXI_ARBURST = 2'b0;
    assign M2S_AXI_ARLEN = 4'b0;
    assign M2S_AXI_ARSIZE = 2'b0;
    assign M2S_AXI_RREADY = 1'b0;
endmodule