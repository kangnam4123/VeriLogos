module mig_7series_v2_0_qdr_rld_phy_ck_addr_cmd_delay #
  (
   parameter TCQ          = 100,       
   parameter BURST_LEN   = 4,      
   parameter nCK_PER_CLK  = 2,         
   parameter CLK_PERIOD   = 3636,      
   parameter N_CTL_LANES  = 3          
   )
  (
   input            clk,            
   input            rst,            
   input            cmd_delay_start,
   output reg [5:0] ctl_lane_cnt,   
   output reg       po_stg2_f_incdec,
   output reg       po_en_stg2_f,   
   output           po_ck_addr_cmd_delay_done 
   );
   localparam TAP_CNT_LIMIT = 63;
   localparam FREQ_REF_DIV           = (CLK_PERIOD > 5000 ? 4 : 
                                        CLK_PERIOD > 2500 ? 2 : 1);
   localparam real FREQ_REF_PS       = CLK_PERIOD/FREQ_REF_DIV;
   localparam integer PHASER_TAP_RES = ((FREQ_REF_PS/2)/64);
   localparam CALC_TAP_CNT = (CLK_PERIOD / (4 * PHASER_TAP_RES));
   localparam TAP_CNT = (CALC_TAP_CNT > TAP_CNT_LIMIT) ? 
                         TAP_CNT_LIMIT : CALC_TAP_CNT;
   reg       delay_done;
   reg       delay_done_r1;
   reg       delay_done_r2;
   reg       delay_done_r3;
   reg       delay_done_r4;
   reg [5:0] delay_cnt_r;
   assign po_ck_addr_cmd_delay_done = (BURST_LEN == 2)? cmd_delay_start : delay_done_r4;
   always @(posedge clk) begin
     if (rst || ~cmd_delay_start || delay_done || (delay_cnt_r == 6'd1)) begin
       po_stg2_f_incdec <= #TCQ 1'b0;
       po_en_stg2_f     <= #TCQ 1'b0;
     end else if (((delay_cnt_r == 6'd0) || (delay_cnt_r == TAP_CNT)) && (ctl_lane_cnt < N_CTL_LANES)) begin
       po_stg2_f_incdec <= #TCQ 1'b1;
       po_en_stg2_f     <= #TCQ 1'b1;
     end
   end
   always @(posedge clk) begin  
     if (rst || ~cmd_delay_start ||((delay_cnt_r == 6'd0) && (ctl_lane_cnt < N_CTL_LANES)))
       delay_cnt_r  <= #TCQ TAP_CNT;
     else if (po_en_stg2_f && (delay_cnt_r > 6'd0))
       delay_cnt_r  <= #TCQ delay_cnt_r - 1;
   end
   always @(posedge clk) begin
     if (rst || ~cmd_delay_start )
       ctl_lane_cnt <= #TCQ 6'b0;
     else if (~delay_done && (ctl_lane_cnt == N_CTL_LANES-1) && (delay_cnt_r == 6'd1))
       ctl_lane_cnt <= #TCQ ctl_lane_cnt;
     else if ((ctl_lane_cnt != N_CTL_LANES-1) && (delay_cnt_r == 6'd1))
        ctl_lane_cnt <= #TCQ ctl_lane_cnt + 1;
   end
   always @(posedge clk) begin
     if (rst )  begin
       delay_done    <= #TCQ 1'b0;
     end else if ((delay_cnt_r == 6'd2) && (ctl_lane_cnt == N_CTL_LANES-1))  begin
       delay_done    <= #TCQ 1'b1;
     end
   end
   always @(posedge clk) begin
     delay_done_r1 <= #TCQ delay_done;
     delay_done_r2 <= #TCQ delay_done_r1;
     delay_done_r3 <= #TCQ delay_done_r2;
     delay_done_r4 <= #TCQ delay_done_r3;
   end
endmodule