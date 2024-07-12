module mor1kx_branch_predictor_simple
   (
    input op_bf_i,               
    input op_bnf_i,              
    input [9:0] immjbr_upper_i,  
    output predicted_flag_o      
    );
   assign predicted_flag_o = op_bf_i & immjbr_upper_i[9] |
                             op_bnf_i & !immjbr_upper_i[9];
endmodule