module nios_uart_0_tx (
                         baud_divisor,
                         begintransfer,
                         clk,
                         clk_en,
                         do_force_break,
                         reset_n,
                         status_wr_strobe,
                         tx_data,
                         tx_wr_strobe,
                         tx_overrun,
                         tx_ready,
                         tx_shift_empty,
                         txd
                      )
;
  output           tx_overrun;
  output           tx_ready;
  output           tx_shift_empty;
  output           txd;
  input   [  9: 0] baud_divisor;
  input            begintransfer;
  input            clk;
  input            clk_en;
  input            do_force_break;
  input            reset_n;
  input            status_wr_strobe;
  input   [  7: 0] tx_data;
  input            tx_wr_strobe;
  reg              baud_clk_en;
  reg     [  9: 0] baud_rate_counter;
  wire             baud_rate_counter_is_zero;
  reg              do_load_shifter;
  wire             do_shift;
  reg              pre_txd;
  wire             shift_done;
  wire    [  9: 0] tx_load_val;
  reg              tx_overrun;
  reg              tx_ready;
  reg              tx_shift_empty;
  wire             tx_shift_reg_out;
  wire    [  9: 0] tx_shift_register_contents;
  wire             tx_wr_strobe_onset;
  reg              txd;
  wire    [  9: 0] unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_in;
  reg     [  9: 0] unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out;
  assign tx_wr_strobe_onset = tx_wr_strobe && begintransfer;
  assign tx_load_val = {{1 {1'b1}},
    tx_data,
    1'b0};
  assign shift_done = ~(|tx_shift_register_contents);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          do_load_shifter <= 0;
      else if (clk_en)
          do_load_shifter <= (~tx_ready) && shift_done;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tx_ready <= 1'b1;
      else if (clk_en)
          if (tx_wr_strobe_onset)
              tx_ready <= 0;
          else if (do_load_shifter)
              tx_ready <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tx_overrun <= 0;
      else if (clk_en)
          if (status_wr_strobe)
              tx_overrun <= 0;
          else if (~tx_ready && tx_wr_strobe_onset)
              tx_overrun <= -1;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tx_shift_empty <= 1'b1;
      else if (clk_en)
          tx_shift_empty <= tx_ready && shift_done;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          baud_rate_counter <= 0;
      else if (clk_en)
          if (baud_rate_counter_is_zero || do_load_shifter)
              baud_rate_counter <= baud_divisor;
          else 
            baud_rate_counter <= baud_rate_counter - 1;
    end
  assign baud_rate_counter_is_zero = baud_rate_counter == 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          baud_clk_en <= 0;
      else if (clk_en)
          baud_clk_en <= baud_rate_counter_is_zero;
    end
  assign do_shift = baud_clk_en  && 
    (~shift_done) && 
    (~do_load_shifter);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          pre_txd <= 1;
      else if (~shift_done)
          pre_txd <= tx_shift_reg_out;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          txd <= 1;
      else if (clk_en)
          txd <= pre_txd & ~do_force_break;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out <= 0;
      else if (clk_en)
          unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out <= unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_in;
    end
  assign unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_in = (do_load_shifter)? tx_load_val :
    (do_shift)? {1'b0,
    unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out[9 : 1]} :
    unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out;
  assign tx_shift_register_contents = unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out;
  assign tx_shift_reg_out = unxshiftxtx_shift_register_contentsxtx_shift_reg_outxx5_out[0];
endmodule