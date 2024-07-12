module fifoctrl_dualclk
  #(parameter width=1)
  (input [width:0] size_i,
   input [width:0] w_ptr_i,
   input [width:0] r_ptr_i,
   input w_clk_i,
   input r_clk_i,
   output full_o,
   output empty_o,
   output [width:0] w_ptr_next_o,
   output [width:0] r_ptr_next_o,
   output w_busy_o,
   output r_busy_o);
  wire [width:0] zero;
  wire [width:0] one;
  assign zero = {width+1{1'b0}};
  assign one = {{width{1'b0}}, 1'b1};
  reg  [width:0] w_ptr;
  wire [width:0] w_ptr_next;
  reg  [width:0] w_ptr_meta;
  reg  [width:0] r_ptr;
  wire [width:0] r_ptr_next;
  reg  [width:0] r_ptr_meta;
  assign full_o = (w_ptr_next_o == r_ptr);
  assign empty_o = (w_ptr == r_ptr);
  assign w_ptr_next = w_ptr + one;
  assign r_ptr_next = r_ptr + one;
  assign w_busy_o = (w_ptr != w_ptr_i);
  assign r_busy_o = (r_ptr != r_ptr_i);
  assign w_ptr_next_o = (w_ptr_next == size_i) ? zero : w_ptr_next;
  assign r_ptr_next_o = (r_ptr_next == size_i) ? zero : r_ptr_next;
  always @(posedge w_clk_i) begin
    w_ptr_meta <= w_ptr_i;
    w_ptr <= w_ptr_meta;
  end
  always @(posedge r_clk_i) begin
    r_ptr_meta <= r_ptr_i;
    r_ptr <= r_ptr_meta;
  end
endmodule