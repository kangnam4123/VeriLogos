module altpcierd_tx_req_reg  #(
   parameter TX_PIPE_REQ=0
      )(
   input             clk_in,
   input             rstn,
   input             itx_req0 ,
   input [127:0]     itx_desc0,
   input             itx_err0 ,
   input             itx_dv0  ,
   input             itx_dfr0 ,
   input[127:0]      itx_data0,
   output            otx_req0 ,
   output [127:0]    otx_desc0,
   output            otx_err0 ,
   output            otx_dv0  ,
   output            otx_dfr0 ,
   output [127:0]    otx_data0
   );
   generate begin
      if (TX_PIPE_REQ==0) begin : g_comb
         assign otx_req0  = itx_req0 ;
         assign otx_desc0 = itx_desc0;
         assign otx_err0  = itx_err0 ;
         assign otx_dv0   = itx_dv0  ;
         assign otx_dfr0  = itx_dfr0 ;
         assign otx_data0 = itx_data0;
      end
   end
   endgenerate
   generate begin
      if (TX_PIPE_REQ>0) begin : g_pipe
         reg            rtx_req0 ;
         reg [127:0]    rtx_desc0;
         reg            rtx_err0 ;
         reg            rtx_dv0  ;
         reg            rtx_dfr0 ;
         reg [127:0]    rtx_data0;
         assign otx_req0  = rtx_req0 ;
         assign otx_desc0 = rtx_desc0;
         assign otx_err0  = rtx_err0 ;
         assign otx_dv0   = rtx_dv0  ;
         assign otx_dfr0  = rtx_dfr0 ;
         assign otx_data0 = rtx_data0;
         always @ (negedge rstn or posedge clk_in) begin
            if (rstn==1'b0) begin
               rtx_req0  <= 0;
               rtx_desc0 <= 0;
               rtx_err0  <= 0;
               rtx_dv0   <= 0;
               rtx_dfr0  <= 0;
               rtx_data0 <= 0;
            end
            else begin
               rtx_req0  <= itx_req0 ;
               rtx_desc0 <= itx_desc0;
               rtx_err0  <= itx_err0 ;
               rtx_dv0   <= itx_dv0  ;
               rtx_dfr0  <= itx_dfr0 ;
               rtx_data0 <= itx_data0;
            end
         end
      end
   end
   endgenerate
endmodule