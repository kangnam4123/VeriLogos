module SOC_NIOS_II_nios2_oci_im (
                                   clk,
                                   jdo,
                                   jrst_n,
                                   reset_n,
                                   take_action_tracectrl,
                                   take_action_tracemem_a,
                                   take_action_tracemem_b,
                                   take_no_action_tracemem_a,
                                   trc_ctrl,
                                   tw,
                                   tracemem_on,
                                   tracemem_trcdata,
                                   tracemem_tw,
                                   trc_enb,
                                   trc_im_addr,
                                   trc_wrap,
                                   xbrk_wrap_traceoff
                                )
;
  output           tracemem_on;
  output  [ 35: 0] tracemem_trcdata;
  output           tracemem_tw;
  output           trc_enb;
  output  [  6: 0] trc_im_addr;
  output           trc_wrap;
  output           xbrk_wrap_traceoff;
  input            clk;
  input   [ 37: 0] jdo;
  input            jrst_n;
  input            reset_n;
  input            take_action_tracectrl;
  input            take_action_tracemem_a;
  input            take_action_tracemem_b;
  input            take_no_action_tracemem_a;
  input   [ 15: 0] trc_ctrl;
  input   [ 35: 0] tw;
  wire             tracemem_on;
  wire    [ 35: 0] tracemem_trcdata;
  wire             tracemem_tw;
  wire             trc_enb;
  reg     [  6: 0] trc_im_addr ;
  wire    [ 35: 0] trc_im_data;
  reg     [ 16: 0] trc_jtag_addr ;
  wire             trc_on_chip;
  reg              trc_wrap ;
  wire             tw_valid;
  wire             xbrk_wrap_traceoff;
  assign trc_im_data = tw;
  always @(posedge clk or negedge jrst_n)
    begin
      if (jrst_n == 0)
        begin
          trc_im_addr <= 0;
          trc_wrap <= 0;
        end
      else if (!0)
        begin
          trc_im_addr <= 0;
          trc_wrap <= 0;
        end
      else if (take_action_tracectrl && 
                      (jdo[4] | jdo[3]))
        begin
          if (jdo[4])
              trc_im_addr <= 0;
          if (jdo[3])
              trc_wrap <= 0;
        end
      else if (trc_enb & trc_on_chip & tw_valid)
        begin
          trc_im_addr <= trc_im_addr+1;
          if (&trc_im_addr)
              trc_wrap <= 1;
        end
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          trc_jtag_addr <= 0;
      else if (take_action_tracemem_a ||
                take_no_action_tracemem_a || 
                take_action_tracemem_b)
          trc_jtag_addr <= take_action_tracemem_a ? 
                    jdo[35 : 19] : 
                    trc_jtag_addr + 1;
    end
  assign trc_enb = trc_ctrl[0];
  assign trc_on_chip = ~trc_ctrl[8];
  assign tw_valid = |trc_im_data[35 : 32];
  assign xbrk_wrap_traceoff = trc_ctrl[10] & trc_wrap;
  assign tracemem_tw = trc_wrap;
  assign tracemem_on = trc_enb;
  assign tracemem_trcdata = 0;
endmodule