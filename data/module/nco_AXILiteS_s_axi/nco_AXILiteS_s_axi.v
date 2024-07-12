module nco_AXILiteS_s_axi
#(parameter
    C_S_AXI_ADDR_WIDTH = 5,
    C_S_AXI_DATA_WIDTH = 32
)(
    input  wire                            ACLK,
    input  wire                            ARESET,
    input  wire                            ACLK_EN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]   AWADDR,
    input  wire                            AWVALID,
    output wire                            AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0]   WDATA,
    input  wire [C_S_AXI_DATA_WIDTH/8-1:0] WSTRB,
    input  wire                            WVALID,
    output wire                            WREADY,
    output wire [1:0]                      BRESP,
    output wire                            BVALID,
    input  wire                            BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0]   ARADDR,
    input  wire                            ARVALID,
    output wire                            ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0]   RDATA,
    output wire [1:0]                      RRESP,
    output wire                            RVALID,
    input  wire                            RREADY,
    input  wire [15:0]                     sine_sample_V,
    input  wire                            sine_sample_V_ap_vld,
    output wire [15:0]                     step_size_V
);
localparam
    ADDR_BITS = 5;
localparam
    ADDR_SINE_SAMPLE_V_DATA_0 = 5'h10,
    ADDR_SINE_SAMPLE_V_CTRL   = 5'h14,
    ADDR_STEP_SIZE_V_DATA_0   = 5'h18,
    ADDR_STEP_SIZE_V_CTRL     = 5'h1c;
localparam
    WRIDLE = 2'd0,
    WRDATA = 2'd1,
    WRRESP = 2'd2;
localparam
    RDIDLE = 2'd0,
    RDDATA = 2'd1;
reg  [1:0]           wstate;
reg  [1:0]           wnext;
reg  [ADDR_BITS-1:0] waddr;
wire [31:0]          wmask;
wire                 aw_hs;
wire                 w_hs;
reg  [1:0]           rstate;
reg  [1:0]           rnext;
reg  [31:0]          rdata;
wire                 ar_hs;
wire [ADDR_BITS-1:0] raddr;
reg  [15:0]          int_sine_sample_V;
reg                  int_sine_sample_V_ap_vld;
reg  [15:0]          int_step_size_V;
assign AWREADY = (wstate == WRIDLE);
assign WREADY  = (wstate == WRDATA);
assign BRESP   = 2'b00;  
assign BVALID  = (wstate == WRRESP);
assign wmask   = { {8{WSTRB[3]}}, {8{WSTRB[2]}}, {8{WSTRB[1]}}, {8{WSTRB[0]}} };
assign aw_hs   = AWVALID & AWREADY;
assign w_hs    = WVALID & WREADY;
always @(posedge ACLK) begin
    if (ARESET)
        wstate <= WRIDLE;
    else if (ACLK_EN)
        wstate <= wnext;
end
always @(*) begin
    case (wstate)
        WRIDLE:
            if (AWVALID)
                wnext = WRDATA;
            else
                wnext = WRIDLE;
        WRDATA:
            if (WVALID)
                wnext = WRRESP;
            else
                wnext = WRDATA;
        WRRESP:
            if (BREADY)
                wnext = WRIDLE;
            else
                wnext = WRRESP;
        default:
            wnext = WRIDLE;
    endcase
end
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (aw_hs)
            waddr <= AWADDR[ADDR_BITS-1:0];
    end
end
assign ARREADY = (rstate == RDIDLE);
assign RDATA   = rdata;
assign RRESP   = 2'b00;  
assign RVALID  = (rstate == RDDATA);
assign ar_hs   = ARVALID & ARREADY;
assign raddr   = ARADDR[ADDR_BITS-1:0];
always @(posedge ACLK) begin
    if (ARESET)
        rstate <= RDIDLE;
    else if (ACLK_EN)
        rstate <= rnext;
end
always @(*) begin
    case (rstate)
        RDIDLE:
            if (ARVALID)
                rnext = RDDATA;
            else
                rnext = RDIDLE;
        RDDATA:
            if (RREADY & RVALID)
                rnext = RDIDLE;
            else
                rnext = RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (ar_hs) begin
            rdata <= 1'b0;
            case (raddr)
                ADDR_SINE_SAMPLE_V_DATA_0: begin
                    rdata <= int_sine_sample_V[15:0];
                end
                ADDR_SINE_SAMPLE_V_CTRL: begin
                    rdata[0] <= int_sine_sample_V_ap_vld;
                end
                ADDR_STEP_SIZE_V_DATA_0: begin
                    rdata <= int_step_size_V[15:0];
                end
            endcase
        end
    end
end
assign step_size_V = int_step_size_V;
always @(posedge ACLK) begin
    if (ARESET)
        int_sine_sample_V <= 0;
    else if (ACLK_EN) begin
        if (sine_sample_V_ap_vld)
            int_sine_sample_V <= sine_sample_V;
    end
end
always @(posedge ACLK) begin
    if (ARESET)
        int_sine_sample_V_ap_vld <= 1'b0;
    else if (ACLK_EN) begin
        if (sine_sample_V_ap_vld)
            int_sine_sample_V_ap_vld <= 1'b1;
        else if (ar_hs && raddr == ADDR_SINE_SAMPLE_V_CTRL)
            int_sine_sample_V_ap_vld <= 1'b0; 
    end
end
always @(posedge ACLK) begin
    if (ACLK_EN) begin
        if (w_hs && waddr == ADDR_STEP_SIZE_V_DATA_0)
            int_step_size_V[15:0] <= (WDATA[31:0] & wmask) | (int_step_size_V[15:0] & ~wmask);
    end
end
endmodule