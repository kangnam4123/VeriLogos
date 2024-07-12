module clk_gen_20(
    clk,
    clk_n,
    clk_p,
    sync_rst
    );
    parameter CLOCK_PERIOD = 5;
    parameter INITIAL_RESET_CLOCK_CYCLES = 100;
    parameter RESET_POLARITY = 1;
    output reg clk;
    output reg clk_n;
    output reg clk_p;
    output reg sync_rst;
    reg rst_trigger;
    reg [15:0] rst_counter;
    initial
    begin
      clk   = 1'b0;
      clk_n = 1'b1;
      clk_p = 1'b0;
      rst_trigger = 1'b0;
      rst_counter = 1'b0;
      sync_rst   = (RESET_POLARITY == 0) ? 1'b0 : 1'b1;
    end
    always #(CLOCK_PERIOD/2.0) clk <= ~clk;
    always #(CLOCK_PERIOD/2.0) clk_p <= ~clk_p;
    always #(CLOCK_PERIOD/2.0) clk_n  <= ~clk_n;
    always@(posedge clk)
    begin
       rst_counter <= rst_counter + 1;
    end
    always@(posedge clk)
    begin
      if (rst_counter == INITIAL_RESET_CLOCK_CYCLES)
      begin
         sync_rst <= (RESET_POLARITY == 0) ? 1'b1 : 1'b0;
      end
    end
endmodule