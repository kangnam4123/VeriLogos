module nkmd_cpu_seq(
    input wire rf_regn_is_zero_i,
    input wire dcd_repn_i,
    output wire if_stop_inc_pc_o,
    output wire dcd_latch_curr_output_o);
wire stall = (dcd_repn_i == 1'b1) && (rf_regn_is_zero_i == 1'b0);
assign if_stop_inc_pc_o = stall;
assign dcd_latch_curr_output_o = stall;
endmodule