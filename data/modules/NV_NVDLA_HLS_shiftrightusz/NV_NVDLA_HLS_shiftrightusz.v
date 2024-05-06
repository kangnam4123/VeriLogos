module NV_NVDLA_HLS_shiftrightusz (
   data_in
  ,shift_num
  ,data_out
  ,frac_out
  );
parameter IN_WIDTH = 49;
parameter OUT_WIDTH = 32;
parameter FRAC_WIDTH = 35; 
parameter SHIFT_WIDTH = 6;
parameter SHIFT_MAX = 1<<(SHIFT_WIDTH-1);
parameter HIGH_WIDTH = SHIFT_MAX+IN_WIDTH-OUT_WIDTH;
input [IN_WIDTH-1:0] data_in; 
input [SHIFT_WIDTH-1:0] shift_num; 
output [OUT_WIDTH-1:0] data_out;
output [FRAC_WIDTH-1:0] frac_out;
wire [SHIFT_WIDTH-1:0] shift_num_abs;
wire [OUT_WIDTH-1:0] data_shift_l;
wire [HIGH_WIDTH-1:0] data_high;
wire [IN_WIDTH-1:0] data_shift_r;
wire [FRAC_WIDTH-1:0] frac_shift;
wire [OUT_WIDTH-1:0] data_max;
wire left_shift_sat;
wire right_shift_sat;
wire shift_sign;
assign shift_sign = shift_num[SHIFT_WIDTH-1];
assign shift_num_abs[SHIFT_WIDTH-1:0] = ~shift_num[SHIFT_WIDTH-1:0] + 1;
assign {data_high[((HIGH_WIDTH) - 1):0],data_shift_l[((OUT_WIDTH) - 1):0]} = {{SHIFT_MAX{1'b0}},data_in} << shift_num_abs[((SHIFT_WIDTH) - 1):0];
assign left_shift_sat = shift_sign & {data_high[((HIGH_WIDTH) - 1):0],data_shift_l[OUT_WIDTH-1]} != {(HIGH_WIDTH+1){1'b0}};
assign {data_shift_r[((IN_WIDTH) - 1):0],frac_shift[((FRAC_WIDTH) - 1):0]} = {data_in[((IN_WIDTH) - 1):0],{(FRAC_WIDTH){1'b0}}} >> shift_num[((SHIFT_WIDTH) - 1):0];
assign right_shift_sat = !shift_sign & (|data_shift_r[IN_WIDTH-1:OUT_WIDTH]);
assign data_max = {(OUT_WIDTH){1'b1}};
assign data_out[((OUT_WIDTH) - 1):0] = (left_shift_sat | right_shift_sat) ? data_max : shift_sign ? data_shift_l[((OUT_WIDTH) - 1):0] : data_shift_r[((OUT_WIDTH) - 1):0];
assign frac_out[((FRAC_WIDTH) - 1):0] = shift_sign ? {FRAC_WIDTH{1'b0}} : frac_shift[((FRAC_WIDTH) - 1):0];
endmodule