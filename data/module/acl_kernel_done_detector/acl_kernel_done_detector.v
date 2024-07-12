module acl_kernel_done_detector
#(
  parameter WIDTH = 32       
)
(
  input clock,
  input resetn,
  input start,         
  input kernel_stall_out,
  input kernel_valid_in,
  input kernel_stall_in,
  input kernel_valid_out,
  output kernel_done
);
  reg [WIDTH-1:0] items_not_done;
  assign all_items_sent = ~kernel_valid_in & ~kernel_stall_out;
  assign kernel_done = (items_not_done == {WIDTH{1'b0}});
  always @(posedge clock or negedge resetn)
  begin
    if ( ~resetn )
      items_not_done <= {WIDTH{1'b0}};
    else if ( start )
      items_not_done <= {WIDTH{1'b0}};
    else begin
        if (kernel_valid_in & ~kernel_stall_out & (~kernel_valid_out | kernel_stall_in))
          items_not_done <= (items_not_done + 2'b01);    
        else
        if (kernel_valid_out & ~kernel_stall_in & (~kernel_valid_in | kernel_stall_out))
            items_not_done <= (items_not_done - 2'b01);  
    end
  end
endmodule