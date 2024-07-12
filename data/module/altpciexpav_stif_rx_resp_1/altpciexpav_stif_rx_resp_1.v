module altpciexpav_stif_rx_resp_1
#(
  parameter CG_COMMON_CLOCK_MODE = 1
)
  ( input          Clk_i,
    input          AvlClk_i,
    input          Rstn_i,
    input          RxmRstn_i,
    input          CplReq_i,
    input  [4:0]   CplDesc_i, 
    output [8:0]    CplRdAddr_o,
    input [65:0]   CplBufData_i,
    output         TagRelease_o,
    output  [63:0]  TxsReadData_o,
    output          TxsReadDataValid_o
  );
  localparam RXCPL_IDLE         = 3'h0;
  localparam RXCPL_RDPIPE       = 3'h3;
  localparam RXCPL_RD_VALID     = 3'h5;
wire                          last_qword;
wire                          dw_swap;
reg                           dw_swap_reg;
reg        [2:0]              rxcpl_state;
reg        [2:0]              rxcpl_nxt_state;
wire                          rdpipe_st;
wire                          rdvalid_st;
reg        [5:0]              rd_addr_cntr;
reg        [2:0]              hol_cntr;
reg        [7:0]             tag_status_reg;
reg        [7:0]             last_cpl_reg;
reg                           cpl_req_reg;
wire                          cpl_req;
wire                          cpl_done;
reg                           cpl_done_reg;
wire       [3:0]              tag;
wire                           cpl_ack_reg;
wire                          cpl_req_int;
wire                          last_cpl;
wire                          rxcpl_idle_state;
wire                          cpl_req_rise;
wire                          cpl_eop;
always @(posedge AvlClk_i or negedge RxmRstn_i)
  begin
    if(~RxmRstn_i)
       cpl_req_reg <= 1'b0;
    else
       cpl_req_reg <= CplReq_i;
  end
  assign cpl_req_rise = ~cpl_req_reg & CplReq_i;
  assign    tag = CplDesc_i[2:0];
  assign    last_cpl = CplDesc_i[4];
  assign    cpl_eop  = CplBufData_i[65];
generate
  genvar i;
  for(i=0; i< 8; i=i+1)
    begin: tag_status_register
       always @(posedge AvlClk_i or negedge RxmRstn_i)
         begin
           if(~RxmRstn_i)
              last_cpl_reg[i] <= 1'b0;
           else if(cpl_req_rise & tag == i)
              last_cpl_reg[i] <= last_cpl;
           else if(cpl_done & hol_cntr == i & last_cpl_reg[i]) 
              last_cpl_reg[i] <= 1'b0;
         end
     always @(posedge AvlClk_i or negedge RxmRstn_i)
         begin
           if(~RxmRstn_i)
              tag_status_reg[i] <= 1'b0;
           else if(cpl_req_rise & last_cpl & tag == i)
              tag_status_reg[i] <= 1'b1;
           else if(cpl_done & hol_cntr == i) 
              tag_status_reg[i] <= 1'b0;
         end 
       end
  endgenerate
always @(posedge AvlClk_i or negedge RxmRstn_i)  
  begin
    if(~RxmRstn_i)
     rxcpl_state  <= RXCPL_IDLE;
    else
      rxcpl_state <= rxcpl_nxt_state;
  end
always @*
  begin
    case(rxcpl_state)
      RXCPL_IDLE :
         if(tag_status_reg[hol_cntr])
          rxcpl_nxt_state <= RXCPL_RDPIPE; 
        else
          rxcpl_nxt_state <= RXCPL_IDLE;
      RXCPL_RDPIPE:
        if(cpl_eop)
           rxcpl_nxt_state <= RXCPL_IDLE;
        else
          rxcpl_nxt_state <= RXCPL_RD_VALID;
      RXCPL_RD_VALID: 
        if(cpl_eop)
          rxcpl_nxt_state <= RXCPL_IDLE;
        else
          rxcpl_nxt_state <= RXCPL_RD_VALID;
      default:
          rxcpl_nxt_state <= RXCPL_IDLE;
    endcase
end      
assign rxcpl_idle_state = ~rxcpl_state[0]; 
assign rdpipe_st = rxcpl_state[1];
assign rdvalid_st = rxcpl_state[2];
assign TxsReadDataValid_o = rdpipe_st | rdvalid_st;
assign TxsReadData_o[63:0] = CplBufData_i[63:0];
assign cpl_done = (rdvalid_st | rdpipe_st) & cpl_eop ;
always @(posedge AvlClk_i or negedge RxmRstn_i)
  begin
    if(~RxmRstn_i)
       cpl_done_reg <= 1'b0;
    else 
       cpl_done_reg <= cpl_done;
  end
assign TagRelease_o = cpl_done_reg;
always @(posedge AvlClk_i or negedge RxmRstn_i)
  begin
    if(~RxmRstn_i)
       hol_cntr <= 3'h0;
    else if(cpl_done & last_cpl_reg[hol_cntr])
       hol_cntr <= hol_cntr + 3'h1;
  end
always @(posedge AvlClk_i or negedge RxmRstn_i)
  begin
    if(~RxmRstn_i)
       rd_addr_cntr <= 6'h0;
    else if(cpl_done)
       rd_addr_cntr <= 6'h0;
    else if(rdpipe_st | rdvalid_st | (rxcpl_idle_state & tag_status_reg[hol_cntr]))
       rd_addr_cntr <= rd_addr_cntr + 6'h1;
  end          
 assign CplRdAddr_o = {  hol_cntr,      rd_addr_cntr};                                                          
endmodule