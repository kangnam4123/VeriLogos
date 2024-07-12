module soc_design_Sys_Timer (
                               address,
                               chipselect,
                               clk,
                               reset_n,
                               write_n,
                               writedata,
                               irq,
                               readdata
                            )
;
  output           irq;
  output  [ 15: 0] readdata;
  input   [  2: 0] address;
  input            chipselect;
  input            clk;
  input            reset_n;
  input            write_n;
  input   [ 15: 0] writedata;
  wire             clk_en;
  wire             control_interrupt_enable;
  reg              control_register;
  wire             control_wr_strobe;
  reg              counter_is_running;
  wire             counter_is_zero;
  wire    [ 16: 0] counter_load_value;
  reg              delayed_unxcounter_is_zeroxx0;
  wire             do_start_counter;
  wire             do_stop_counter;
  reg              force_reload;
  reg     [ 16: 0] internal_counter;
  wire             irq;
  wire             period_h_wr_strobe;
  wire             period_l_wr_strobe;
  wire    [ 15: 0] read_mux_out;
  reg     [ 15: 0] readdata;
  wire             status_wr_strobe;
  wire             timeout_event;
  reg              timeout_occurred;
  assign clk_en = 1;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          internal_counter <= 17'h1869F;
      else if (counter_is_running || force_reload)
          if (counter_is_zero    || force_reload)
              internal_counter <= counter_load_value;
          else 
            internal_counter <= internal_counter - 1;
    end
  assign counter_is_zero = internal_counter == 0;
  assign counter_load_value = 17'h1869F;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          force_reload <= 0;
      else if (clk_en)
          force_reload <= period_h_wr_strobe || period_l_wr_strobe;
    end
  assign do_start_counter = 1;
  assign do_stop_counter = 0;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          counter_is_running <= 1'b0;
      else if (clk_en)
          if (do_start_counter)
              counter_is_running <= -1;
          else if (do_stop_counter)
              counter_is_running <= 0;
    end
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          delayed_unxcounter_is_zeroxx0 <= 0;
      else if (clk_en)
          delayed_unxcounter_is_zeroxx0 <= counter_is_zero;
    end
  assign timeout_event = (counter_is_zero) & ~(delayed_unxcounter_is_zeroxx0);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          timeout_occurred <= 0;
      else if (clk_en)
          if (status_wr_strobe)
              timeout_occurred <= 0;
          else if (timeout_event)
              timeout_occurred <= -1;
    end
  assign irq = timeout_occurred && control_interrupt_enable;
  assign read_mux_out = ({16 {(address == 1)}} & control_register) |
    ({16 {(address == 0)}} & {counter_is_running,
    timeout_occurred});
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          readdata <= 0;
      else if (clk_en)
          readdata <= read_mux_out;
    end
  assign period_l_wr_strobe = chipselect && ~write_n && (address == 2);
  assign period_h_wr_strobe = chipselect && ~write_n && (address == 3);
  assign control_wr_strobe = chipselect && ~write_n && (address == 1);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          control_register <= 0;
      else if (control_wr_strobe)
          control_register <= writedata[0];
    end
  assign control_interrupt_enable = control_register;
  assign status_wr_strobe = chipselect && ~write_n && (address == 0);
endmodule