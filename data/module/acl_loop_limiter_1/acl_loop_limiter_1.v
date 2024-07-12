module acl_loop_limiter_1 #(
  parameter ENTRY_WIDTH = 8,
            EXIT_WIDTH = 8, 
            THRESHOLD = 100,             
            THRESHOLD_NO_DELAY = 0, 
            PEXIT_WIDTH = (EXIT_WIDTH == 0)? 1 : EXIT_WIDTH 
)(
  input                        clock,
  input                        resetn,
  input  [ENTRY_WIDTH-1:0]     i_valid,
  input  [ENTRY_WIDTH-1:0]     i_stall,  
  input  [PEXIT_WIDTH-1:0]     i_valid_exit,
  input  [PEXIT_WIDTH-1:0]     i_stall_exit,
  output [ENTRY_WIDTH-1:0]     o_valid,
  output [ENTRY_WIDTH-1:0]     o_stall  
);
localparam  ADD_WIDTH = $clog2(ENTRY_WIDTH + 1);
localparam  SUB_WIDTH = $clog2(PEXIT_WIDTH + 1);
localparam  THRESHOLD_W = $clog2(THRESHOLD + 1);
integer i;
wire [ENTRY_WIDTH-1:0]  inc_bin;
wire [ADD_WIDTH-1:0]    inc_wire [ENTRY_WIDTH]; 
wire [PEXIT_WIDTH-1:0]  dec_bin;
wire [SUB_WIDTH-1:0]    dec_wire [PEXIT_WIDTH];   
wire [ADD_WIDTH-1:0]    inc_value [ENTRY_WIDTH]; 
wire                    decrease_allow; 
wire [THRESHOLD_W:0]    valid_allow_wire;
reg  [THRESHOLD_W-1:0]  counter_next, valid_allow;
wire [ENTRY_WIDTH-1:0]  limit_mask;
wire [ENTRY_WIDTH-1:0]  accept_inc_bin;
assign decrease_allow =  inc_value[ENTRY_WIDTH-1] > dec_wire[PEXIT_WIDTH-1];
assign valid_allow_wire =  valid_allow  +  dec_wire[PEXIT_WIDTH-1] - inc_value[ENTRY_WIDTH-1];
always @(*) begin
  if(decrease_allow) counter_next = valid_allow_wire[THRESHOLD_W]? 0 : valid_allow_wire[THRESHOLD_W-1:0];  
  else counter_next = (valid_allow_wire > THRESHOLD)? THRESHOLD : valid_allow_wire[THRESHOLD_W-1:0];      
end
wire  [THRESHOLD_W:0]   valid_allow_temp; 
assign valid_allow_temp = valid_allow + dec_wire[PEXIT_WIDTH-1];
genvar z;
generate  
    for(z=0; z<ENTRY_WIDTH; z=z+1) begin : GEN_COMB_ENTRY
      assign inc_bin[z] = ~i_stall[z] & i_valid[z];
      assign inc_wire[z] = (z==0)? i_valid[0] : inc_wire[z-1] + i_valid[z];    
      assign limit_mask[z] = inc_wire[z] <= (THRESHOLD_NO_DELAY? valid_allow_temp : valid_allow);   
      assign accept_inc_bin[z] = inc_bin[z] & limit_mask[z]; 
      assign inc_value[z] = (z==0)? accept_inc_bin[0] : inc_value[z-1] + accept_inc_bin[z];
      assign o_valid[z] = limit_mask[z] & i_valid[z];
      assign o_stall[z] =  (ENTRY_WIDTH == 1)? (valid_allow == 0 | i_stall[z]) : (!o_valid[z] | i_stall[z]);    
    end
    for(z=0; z<PEXIT_WIDTH; z=z+1) begin : GEN_COMB_EXIT
      assign dec_bin[z] = !i_stall_exit[z] & i_valid_exit[z];
      assign dec_wire[z] = (z==0)? dec_bin[0] : dec_wire[z-1] + dec_bin[z];    
    end
endgenerate
always @(posedge clock or negedge resetn) begin    
  if(!resetn) begin
    valid_allow <= THRESHOLD;
  end
  else begin      
    valid_allow <= counter_next;    
  end
end   
endmodule