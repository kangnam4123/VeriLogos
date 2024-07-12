module BLK_MEM_GEN_v8_2_softecc_output_reg_stage
  #(parameter C_DATA_WIDTH          = 32,
    parameter C_ADDRB_WIDTH         = 10,
    parameter C_HAS_SOFTECC_OUTPUT_REGS_B= 0,
    parameter C_USE_SOFTECC         = 0,
    parameter FLOP_DELAY            = 100
  )
  (
   input                         CLK,
   input      [C_DATA_WIDTH-1:0] DIN,
   output reg [C_DATA_WIDTH-1:0] DOUT,
   input                         SBITERR_IN,
   input                         DBITERR_IN,
   output reg                    SBITERR,
   output reg                    DBITERR,
   input      [C_ADDRB_WIDTH-1:0]             RDADDRECC_IN,
   output reg [C_ADDRB_WIDTH-1:0]             RDADDRECC
);
  reg [C_DATA_WIDTH-1:0]           dout_i       = 0;
  reg                              sbiterr_i    = 0;
  reg                              dbiterr_i    = 0;
  reg [C_ADDRB_WIDTH-1:0]          rdaddrecc_i  = 0;
  generate if (C_HAS_SOFTECC_OUTPUT_REGS_B==0) begin : no_output_stage
    always @* begin
      DOUT = DIN;
      RDADDRECC = RDADDRECC_IN;
      SBITERR = SBITERR_IN;
      DBITERR = DBITERR_IN;
    end
  end
  endgenerate
  generate if (C_HAS_SOFTECC_OUTPUT_REGS_B==1) begin : has_output_stage
      always @(posedge CLK) begin
      dout_i <= #FLOP_DELAY DIN;
      rdaddrecc_i <= #FLOP_DELAY RDADDRECC_IN;
      sbiterr_i <= #FLOP_DELAY SBITERR_IN;
      dbiterr_i <= #FLOP_DELAY DBITERR_IN;
      end
      always @* begin
      DOUT = dout_i;
      RDADDRECC = rdaddrecc_i;
      SBITERR = sbiterr_i;
      DBITERR = dbiterr_i;
      end 
      end 
 endgenerate
endmodule