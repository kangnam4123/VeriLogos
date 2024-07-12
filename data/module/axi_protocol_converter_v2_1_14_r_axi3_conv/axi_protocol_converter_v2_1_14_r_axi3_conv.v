module axi_protocol_converter_v2_1_14_r_axi3_conv #
  (
   parameter C_FAMILY                            = "none",
   parameter integer C_AXI_ID_WIDTH              = 1,
   parameter integer C_AXI_ADDR_WIDTH            = 32,
   parameter integer C_AXI_DATA_WIDTH            = 32,
   parameter integer C_AXI_SUPPORTS_USER_SIGNALS = 0,
   parameter integer C_AXI_RUSER_WIDTH           = 1,
   parameter integer C_SUPPORT_SPLITTING              = 1,
   parameter integer C_SUPPORT_BURSTS                 = 1
   )
  (
   input wire ACLK,
   input wire ARESET,
   input  wire                              cmd_valid,
   input  wire                              cmd_split,
   output wire                              cmd_ready,
   output wire [C_AXI_ID_WIDTH-1:0]    S_AXI_RID,
   output wire [C_AXI_DATA_WIDTH-1:0]  S_AXI_RDATA,
   output wire [2-1:0]                 S_AXI_RRESP,
   output wire                         S_AXI_RLAST,
   output wire [C_AXI_RUSER_WIDTH-1:0] S_AXI_RUSER,
   output wire                         S_AXI_RVALID,
   input  wire                         S_AXI_RREADY,
   input  wire [C_AXI_ID_WIDTH-1:0]    M_AXI_RID,
   input  wire [C_AXI_DATA_WIDTH-1:0]  M_AXI_RDATA,
   input  wire [2-1:0]                 M_AXI_RRESP,
   input  wire                         M_AXI_RLAST,
   input  wire [C_AXI_RUSER_WIDTH-1:0] M_AXI_RUSER,
   input  wire                         M_AXI_RVALID,
   output wire                         M_AXI_RREADY
   );
  localparam [2-1:0] C_RESP_OKAY        = 2'b00;
  localparam [2-1:0] C_RESP_EXOKAY      = 2'b01;
  localparam [2-1:0] C_RESP_SLVERROR    = 2'b10;
  localparam [2-1:0] C_RESP_DECERR      = 2'b11;
  wire                            cmd_ready_i;
  wire                            pop_si_data;
  wire                            si_stalling;
  wire                            M_AXI_RREADY_I;
  wire [C_AXI_ID_WIDTH-1:0]       S_AXI_RID_I;
  wire [C_AXI_DATA_WIDTH-1:0]     S_AXI_RDATA_I;
  wire [2-1:0]                    S_AXI_RRESP_I;
  wire                            S_AXI_RLAST_I;
  wire [C_AXI_RUSER_WIDTH-1:0]    S_AXI_RUSER_I;
  wire                            S_AXI_RVALID_I;
  wire                            S_AXI_RREADY_I;
  assign M_AXI_RREADY_I = ~si_stalling & cmd_valid;
  assign M_AXI_RREADY   = M_AXI_RREADY_I;
  assign S_AXI_RVALID_I = M_AXI_RVALID & cmd_valid;
  assign pop_si_data    = S_AXI_RVALID_I & S_AXI_RREADY_I;
  assign cmd_ready_i    = cmd_valid & pop_si_data & M_AXI_RLAST;
  assign cmd_ready      = cmd_ready_i;
  assign si_stalling    = S_AXI_RVALID_I & ~S_AXI_RREADY_I;
  assign S_AXI_RLAST_I  = M_AXI_RLAST & 
                          ( ~cmd_split | ( C_SUPPORT_SPLITTING == 0 ) );
  assign S_AXI_RID_I    = M_AXI_RID;
  assign S_AXI_RUSER_I  = M_AXI_RUSER;
  assign S_AXI_RDATA_I  = M_AXI_RDATA;
  assign S_AXI_RRESP_I  = M_AXI_RRESP;
  assign S_AXI_RREADY_I = S_AXI_RREADY;
  assign S_AXI_RVALID   = S_AXI_RVALID_I;
  assign S_AXI_RID      = S_AXI_RID_I;
  assign S_AXI_RDATA    = S_AXI_RDATA_I;
  assign S_AXI_RRESP    = S_AXI_RRESP_I;
  assign S_AXI_RLAST    = S_AXI_RLAST_I;
  assign S_AXI_RUSER    = S_AXI_RUSER_I;
endmodule