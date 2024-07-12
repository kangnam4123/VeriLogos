module mor1kx_branch_prediction
  #(
    parameter OPTION_OPERAND_WIDTH = 32
    )
   (
    input 	clk,
    input 	rst,
    input 	op_bf_i,
    input 	op_bnf_i,
    input [9:0] immjbr_upper_i,
    output 	predicted_flag_o,
    input 	prev_op_brcond_i,
    input 	prev_predicted_flag_i,
    input 	flag_i,
    output 	branch_mispredict_o
    );
   assign branch_mispredict_o = prev_op_brcond_i &
				(flag_i != prev_predicted_flag_i);
   assign predicted_flag_o = op_bf_i & immjbr_upper_i[9] |
			     op_bnf_i & !immjbr_upper_i[9];
endmodule