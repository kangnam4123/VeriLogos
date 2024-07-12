module axi_crossbar_v2_1_9_wdata_mux #
  (
   parameter         C_FAMILY       = "none", 
   parameter integer C_WMESG_WIDTH            =  1, 
   parameter integer C_NUM_SLAVE_SLOTS     =  1, 
   parameter integer C_SELECT_WIDTH      =  1, 
   parameter integer C_FIFO_DEPTH_LOG     =  0 
   )
  (
   input  wire                                        ACLK,
   input  wire                                        ARESET,
   input  wire [C_NUM_SLAVE_SLOTS*C_WMESG_WIDTH-1:0]     S_WMESG,
   input  wire [C_NUM_SLAVE_SLOTS-1:0]                S_WLAST,
   input  wire [C_NUM_SLAVE_SLOTS-1:0]                S_WVALID,
   output wire [C_NUM_SLAVE_SLOTS-1:0]                S_WREADY,
   output wire [C_WMESG_WIDTH-1:0]                       M_WMESG,
   output wire                                        M_WLAST,
   output wire                                        M_WVALID,
   input  wire                                        M_WREADY,
   input  wire [C_SELECT_WIDTH-1:0]                 S_ASELECT,  
   input  wire                                        S_AVALID,
   output wire                                        S_AREADY
   );
  localparam integer P_FIFO_DEPTH_LOG = (C_FIFO_DEPTH_LOG <= 5) ? C_FIFO_DEPTH_LOG : 5;  
  function [C_NUM_SLAVE_SLOTS-1:0] f_decoder (
      input [C_SELECT_WIDTH-1:0] sel
    );
    integer i;
    begin
      for (i=0; i<C_NUM_SLAVE_SLOTS; i=i+1) begin
        f_decoder[i] = (sel == i);
      end
    end
  endfunction
  wire                                          m_valid_i;
  wire                                          m_last_i;
  wire [C_NUM_SLAVE_SLOTS-1:0]             m_select_hot;
  wire [C_SELECT_WIDTH-1:0]                 m_select_enc;
  wire                                          m_avalid;
  wire                                          m_aready;
  generate
    if (C_NUM_SLAVE_SLOTS>1) begin : gen_wmux
      axi_data_fifo_v2_1_7_axic_reg_srl_fifo #
        (
         .C_FAMILY          (C_FAMILY),
         .C_FIFO_WIDTH      (C_SELECT_WIDTH),
         .C_FIFO_DEPTH_LOG  (P_FIFO_DEPTH_LOG),
         .C_USE_FULL        (0)
         )
        wmux_aw_fifo
          (
           .ACLK    (ACLK),
           .ARESET  (ARESET),
           .S_MESG  (S_ASELECT),
           .S_VALID (S_AVALID),
           .S_READY (S_AREADY),
           .M_MESG  (m_select_enc),
           .M_VALID (m_avalid),
           .M_READY (m_aready)
           );
      assign m_select_hot = f_decoder(m_select_enc);
      generic_baseblocks_v2_1_0_mux_enc # 
        (
         .C_FAMILY      ("rtl"),
         .C_RATIO       (C_NUM_SLAVE_SLOTS),
         .C_SEL_WIDTH   (C_SELECT_WIDTH),
         .C_DATA_WIDTH  (C_WMESG_WIDTH)
        ) mux_w 
        (
         .S   (m_select_enc),
         .A   (S_WMESG),
         .O   (M_WMESG),
         .OE  (1'b1)
        ); 
      assign m_last_i  = |(S_WLAST & m_select_hot);
      assign m_valid_i = |(S_WVALID & m_select_hot);
      assign m_aready = m_valid_i & m_avalid & m_last_i & M_WREADY;
      assign M_WLAST = m_last_i;
      assign M_WVALID = m_valid_i & m_avalid;
      assign S_WREADY = m_select_hot & {C_NUM_SLAVE_SLOTS{m_avalid & M_WREADY}};
    end else begin : gen_no_wmux
      assign S_AREADY = 1'b1;
      assign M_WVALID = S_WVALID;
      assign S_WREADY = M_WREADY;
      assign M_WLAST = S_WLAST;
      assign M_WMESG = S_WMESG;
    end
  endgenerate
endmodule