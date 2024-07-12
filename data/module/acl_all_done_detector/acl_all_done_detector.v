module acl_all_done_detector
#(
  parameter NUM_COPIES = 1       
)
(
  input clock,
  input resetn,
  input start,
  input dispatched_all_groups,
  input [NUM_COPIES-1:0] kernel_done,
  output reg finish
);
  localparam MAX_CYCLE_COUNTER_VALUE = 5;
  reg [3:0] cycles_since_sent_first_item;
  wire sent_first_item = (cycles_since_sent_first_item == MAX_CYCLE_COUNTER_VALUE);
  reg not_finished;
  always @(posedge clock or negedge resetn)
  begin
    if ( ~resetn )
      finish <= 1'b0;
    else if ( start )
      finish <= 1'b0;
    else
      finish <= not_finished & 
                dispatched_all_groups &
                sent_first_item &
                (kernel_done == {NUM_COPIES{1'b1}});
  end
  always @(posedge clock or negedge resetn)
  begin
    if ( ~resetn )
      not_finished <= 1'b1;
    else if ( start )
      not_finished <= 1'b1;
    else if ( finish )
      not_finished <= 1'b0;
    else
      not_finished <= not_finished;
  end
  always @(posedge clock or negedge resetn)
  begin
    if ( ~resetn )
      cycles_since_sent_first_item <= 0;
    else if ( start )
      cycles_since_sent_first_item <= 0;
    else if ( cycles_since_sent_first_item == MAX_CYCLE_COUNTER_VALUE )
      cycles_since_sent_first_item <= MAX_CYCLE_COUNTER_VALUE;
    else if ( dispatched_all_groups | (cycles_since_sent_first_item > 0) )
      cycles_since_sent_first_item <= cycles_since_sent_first_item + 1;
  end
endmodule