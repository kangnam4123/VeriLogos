module spu_lsurpt (
spu_lsurpt_ldxa_data_out,
spu_lsurpt_ldst_pckt_out,
spu_lsurpt_cpx_data_out,
spu_lsurpt_ldxa_data_in,
spu_lsurpt_ldst_pckt_in,
spu_lsurpt_cpx_data_in);
input [63:0] spu_lsurpt_ldxa_data_in;
input [122:0] spu_lsurpt_ldst_pckt_in;
input [134:0] spu_lsurpt_cpx_data_in;
output [63:0] spu_lsurpt_ldxa_data_out;
output [122:0] spu_lsurpt_ldst_pckt_out;
output [134:0] spu_lsurpt_cpx_data_out;
assign spu_lsurpt_ldxa_data_out[63:0] = spu_lsurpt_ldxa_data_in[63:0];
assign spu_lsurpt_ldst_pckt_out[122:0] = spu_lsurpt_ldst_pckt_in[122:0];
assign spu_lsurpt_cpx_data_out[134:0] = spu_lsurpt_cpx_data_in[134:0];
endmodule