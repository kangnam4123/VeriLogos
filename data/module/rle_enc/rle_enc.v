module rle_enc #(
  parameter integer DW = 32
)(
  input  wire          clk,
  input  wire          rst,
  input  wire          enable,
  input  wire          arm,
  input  wire    [1:0] rle_mode,
  input  wire    [3:0] disabledGroups,
  input  wire [DW-1:0] sti_data,
  input  wire          sti_valid,
  output reg  [DW-1:0] sto_data,
  output reg           sto_valid = 0
);
localparam RLE_COUNT = 1'b1;
reg         active = 0, next_active;
reg         mask_flag = 0, next_mask_flag;
reg   [1:0] mode;
reg  [30:0] data_mask;
reg  [30:0] last_data, next_last_data;
reg         last_valid = 0, next_last_valid;
reg  [31:0] next_sto_data;
reg         next_sto_valid;
reg  [30:0] count = 0, next_count;		
reg   [8:0] fieldcount = 0, next_fieldcount;	
reg   [1:0] track = 0, next_track;		
wire [30:0] inc_count = count+1'b1;
wire        count_zero = ~|count;
wire        count_gt_one = track[1];
wire        count_full = (count==data_mask);
reg         mismatch;
wire [30:0] masked_sti_data = sti_data & data_mask;
wire rle_repeat_mode = 0; 
always @ (posedge clk)
begin
  case (disabledGroups)
    4'b1110,4'b1101,4'b1011,4'b0111                 : mode <= 2'h0; 
    4'b1100,4'b1010,4'b0110,4'b1001,4'b0101,4'b0011 : mode <= 2'h1; 
    4'b1000,4'b0100,4'b0010,4'b0001                 : mode <= 2'h2; 
    default                                         : mode <= 2'h3; 
  endcase
  case (mode)
    2'h0    : data_mask <= 32'h0000007F;
    2'h1    : data_mask <= 32'h00007FFF;
    2'h2    : data_mask <= 32'h007FFFFF;
    default : data_mask <= 32'h7FFFFFFF;
  endcase
end
always @ (posedge clk, posedge rst)
if (rst) begin
  active    <= 0;
  mask_flag <= 0;
end else begin
  active    <= next_active;
  mask_flag <= next_mask_flag;
end
always @ (posedge clk)
begin
  count      <= next_count;
  fieldcount <= next_fieldcount;
  track      <= next_track;
  sto_data   <= next_sto_data;
  sto_valid  <= next_sto_valid;
  last_data  <= next_last_data;
  last_valid <= next_last_valid;
end
always @*
begin
  next_active = active | (enable && arm);
  next_mask_flag = mask_flag | (enable && arm); 
  next_sto_data = (mask_flag) ? masked_sti_data : sti_data;
  next_sto_valid = sti_valid;
  next_last_data = (sti_valid) ? masked_sti_data : last_data; 
  next_last_valid = 1'b0;
  next_count = count & {31{active}};
  next_fieldcount = fieldcount & {9{active}};
  next_track = track & {2{active}};
  mismatch = |(masked_sti_data^last_data); 
  if (active)
    begin
      next_sto_valid = 1'b0;
      next_last_valid = last_valid | sti_valid;
      if (sti_valid && last_valid)
        if (!enable || mismatch || count_full) 
          begin
	    next_active = enable;
            next_sto_valid = 1'b1;
            next_sto_data = {RLE_COUNT,count};
            case (mode)
              2'h0 : next_sto_data = {RLE_COUNT,count[6:0]};
              2'h1 : next_sto_data = {RLE_COUNT,count[14:0]};
              2'h2 : next_sto_data = {RLE_COUNT,count[22:0]};
            endcase
            if (!count_gt_one) next_sto_data = last_data;
	    next_fieldcount = fieldcount+1'b1; 
	    next_count = (mismatch || ~rle_mode[1] || ~rle_mode[0] & fieldcount[8]) ? 0 : 1;
	    next_track = next_count[1:0];
          end
        else 
	  begin
            next_count = inc_count;
	    if (count_zero) 
	      begin
		next_fieldcount = 0;
		next_sto_valid = 1'b1;
	      end
	    if (rle_repeat_mode && count_zero) next_count = 2;
	    next_track = {|track,1'b1};
	  end
    end
end
endmodule