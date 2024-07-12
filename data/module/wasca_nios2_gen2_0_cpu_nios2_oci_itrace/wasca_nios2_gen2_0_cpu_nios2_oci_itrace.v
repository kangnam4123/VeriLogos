module wasca_nios2_gen2_0_cpu_nios2_oci_itrace (
                                                  clk,
                                                  dbrk_traceoff,
                                                  dbrk_traceon,
                                                  jdo,
                                                  jrst_n,
                                                  take_action_tracectrl,
                                                  xbrk_traceoff,
                                                  xbrk_traceon,
                                                  xbrk_wrap_traceoff,
                                                  itm,
                                                  trc_ctrl,
                                                  trc_on
                                               )
;
  output  [ 35: 0] itm;
  output  [ 15: 0] trc_ctrl;
  output           trc_on;
  input            clk;
  input            dbrk_traceoff;
  input            dbrk_traceon;
  input   [ 15: 0] jdo;
  input            jrst_n;
  input            take_action_tracectrl;
  input            xbrk_traceoff;
  input            xbrk_traceon;
  input            xbrk_wrap_traceoff;
wire             advanced_exc_occured;
wire             curr_pid;
wire    [  1: 0] dct_code;
wire             dct_is_taken;
wire    [ 31: 0] eic_addr;
wire    [ 31: 0] exc_addr;
wire             instr_retired;
wire             is_cond_dct;
wire             is_dct;
wire             is_exception_no_break;
wire             is_external_interrupt;
wire             is_fast_tlb_miss_exception;
wire             is_idct;
wire    [ 35: 0] itm;
wire             not_in_debug_mode;
wire             record_dct_outcome_in_sync;
wire             record_itrace;
wire    [ 31: 0] retired_pcb;
wire    [  1: 0] sync_code;
wire    [  6: 0] sync_interval;
wire    [  6: 0] sync_timer;
wire    [  6: 0] sync_timer_next;
wire             sync_timer_reached_zero;
wire    [ 15: 0] trc_ctrl;
reg     [ 10: 0] trc_ctrl_reg ;
wire             trc_on;
  assign is_cond_dct = 1'b0;
  assign is_dct = 1'b0;
  assign dct_is_taken = 1'b0;
  assign is_idct = 1'b0;
  assign retired_pcb = 32'b0;
  assign not_in_debug_mode = 1'b0;
  assign instr_retired = 1'b0;
  assign advanced_exc_occured = 1'b0;
  assign is_exception_no_break = 1'b0;
  assign is_external_interrupt = 1'b0;
  assign is_fast_tlb_miss_exception = 1'b0;
  assign curr_pid = 1'b0;
  assign exc_addr = 32'b0;
  assign eic_addr = 32'b0;
  assign sync_code = trc_ctrl[3 : 2];
  assign sync_interval = { sync_code[1] & sync_code[0], 1'b0, sync_code[1] & ~sync_code[0], 1'b0, ~sync_code[1] & sync_code[0], 2'b00 };
  assign sync_timer_reached_zero = sync_timer == 0;
  assign record_dct_outcome_in_sync = dct_is_taken & sync_timer_reached_zero;
  assign sync_timer_next = sync_timer_reached_zero ? sync_timer : (sync_timer - 1);
  assign record_itrace = trc_on & trc_ctrl[4];
  assign dct_code = {is_cond_dct, dct_is_taken};
  assign itm = 36'd0;
  assign sync_timer = 7'd1;
  always @(posedge clk or negedge jrst_n)
    begin
      if (jrst_n == 0)
        begin
          trc_ctrl_reg[0] <= 1'b0;
          trc_ctrl_reg[1] <= 1'b0;
          trc_ctrl_reg[3 : 2] <= 2'b00;
          trc_ctrl_reg[4] <= 1'b0;
          trc_ctrl_reg[7 : 5] <= 3'b000;
          trc_ctrl_reg[8] <= 0;
          trc_ctrl_reg[9] <= 1'b0;
          trc_ctrl_reg[10] <= 1'b0;
        end
      else if (take_action_tracectrl)
        begin
          trc_ctrl_reg[0] <= jdo[5];
          trc_ctrl_reg[1] <= jdo[6];
          trc_ctrl_reg[3 : 2] <= jdo[8 : 7];
          trc_ctrl_reg[4] <= jdo[9];
          trc_ctrl_reg[9] <= jdo[14];
          trc_ctrl_reg[10] <= jdo[2];
          trc_ctrl_reg[7 : 5] <= 3'b000;
          trc_ctrl_reg[8] <= 1'b0;
        end
      else if (xbrk_wrap_traceoff)
        begin
          trc_ctrl_reg[1] <= 0;
          trc_ctrl_reg[0] <= 0;
        end
      else if (dbrk_traceoff | xbrk_traceoff)
          trc_ctrl_reg[1] <= 0;
      else if (trc_ctrl_reg[0] & 
                                  (dbrk_traceon | xbrk_traceon))
          trc_ctrl_reg[1] <= 1;
    end
  assign trc_ctrl = 0;
  assign trc_on = trc_ctrl[1] & (trc_ctrl[9] | not_in_debug_mode);
endmodule