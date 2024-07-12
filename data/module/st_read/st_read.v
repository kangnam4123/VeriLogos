module st_read (
        clock,
        resetn,
        i_init,
        i_predicate,
        i_valid,
        o_stall,
        o_valid,
        i_stall,
        o_data,
	o_datavalid, 
        i_fifodata,
        i_fifovalid,
        o_fifoready,
        i_fifosize,
        profile_i_valid,
        profile_i_stall,
        profile_o_stall,
        profile_total_req,
        profile_fifo_stall,
        profile_total_fifo_size, profile_total_fifo_size_incr
        );
parameter DATA_WIDTH = 32;
parameter INIT = 0;
parameter INIT_VAL = 64'h0000000000000000;
parameter NON_BLOCKING = 1'b0;
parameter FIFOSIZE_WIDTH=32;
parameter ACL_PROFILE=0;      
parameter ACL_PROFILE_INCREMENT_WIDTH=32;
input clock, resetn, i_stall, i_valid, i_fifovalid;
input i_init;
output o_stall, o_valid, o_fifoready;
input i_predicate;
output o_datavalid;
output [DATA_WIDTH-1:0] o_data;
input [DATA_WIDTH-1:0] i_fifodata;
input [FIFOSIZE_WIDTH-1:0] i_fifosize;
output profile_i_valid;
output profile_i_stall;
output profile_o_stall;
output profile_total_req;
output profile_fifo_stall;
output profile_total_fifo_size;
output [ACL_PROFILE_INCREMENT_WIDTH-1:0] profile_total_fifo_size_incr;
wire feedback_downstream, data_downstream;
wire nop = i_predicate;
wire initvalid;
wire initready;
assign feedback_downstream = i_valid & ~nop & initvalid;
assign data_downstream = i_valid & nop;
assign o_datavalid = feedback_downstream;
wire init_reset;
wire r_o_stall;
wire init_val;
generate
if ( INIT ) begin
assign init_reset = ~resetn;
assign init_val   = i_init;
init_reg
  #( .WIDTH    ( DATA_WIDTH   ),
     .INIT     ( INIT     ),
     .INIT_VAL ( INIT_VAL ) )
reg_data ( 
      .clk     ( clock ),
      .reset   ( init_reset ),
      .i_init  ( init_val   ),
      .i_data  ( i_fifodata ),
      .i_valid ( i_fifovalid ), 
      .o_valid ( initvalid ),
      .o_data  ( o_data ),
      .o_stall ( r_o_stall ),
      .i_stall ( ~initready ) 
      );
end
else begin
assign init_reset = ~resetn;
assign init_val   = 1'b0;
assign o_data = i_fifodata;
assign initvalid = i_fifovalid;
assign r_o_stall = ~initready;
end
endgenerate
assign o_fifoready = ~r_o_stall;
assign o_valid = feedback_downstream | data_downstream | ( i_valid & NON_BLOCKING );
assign o_data_valid = feedback_downstream;
assign o_stall = ( i_valid & ~nop & ~initvalid & ~NON_BLOCKING) | i_stall;
assign initready = ~(i_stall  | data_downstream | ~i_valid); 
generate
if(ACL_PROFILE==1)
begin
  assign profile_i_valid = ( i_valid & ~o_stall );
  assign profile_i_stall = ( o_valid & i_stall );
  assign profile_o_stall = ( i_valid & o_stall );
  assign profile_total_req = ( i_valid & ~o_stall & ~nop );
  assign profile_fifo_stall = ( i_valid & ~nop & ~initvalid );
  assign profile_total_fifo_size = ( i_fifovalid & o_fifoready );
  assign profile_total_fifo_size_incr = i_fifosize;
end
else
begin
  assign profile_i_valid = 1'b0;
  assign profile_i_stall = 1'b0;
  assign profile_o_stall = 1'b0;
  assign profile_total_req = 1'b0;
  assign profile_fifo_stall = 1'b0;
  assign profile_total_fifo_size = 1'b0;
  assign profile_total_fifo_size_incr = {ACL_PROFILE_INCREMENT_WIDTH{1'b0}};
end
endgenerate
endmodule