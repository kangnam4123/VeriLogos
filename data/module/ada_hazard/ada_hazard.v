module ada_hazard(
    input   [4:0]   id_gpr_port_a,          
    input   [4:0]   id_gpr_port_b,          
    input   [4:0]   ex_gpr_wa,              
    input   [4:0]   mem_gpr_wa,             
    input   [4:0]   wb_gpr_wa,              
    input           ex_gpr_we,              
    input           mem_gpr_we,             
    input           wb_gpr_we,              
    input           if_mem_request_stall,   
    input           ex_data_read,           
    input           mem_request_stall,      
    input           if_exception_stall,     
    input           id_exception_stall,     
    input           ex_exception_stall,     
    input           mem_exception_stall,    
    input           ex_exu_stall,           
    output  [1:0]   forward_port_a_select,  
    output  [1:0]   forward_port_b_select,  
    output          if_stall,               
    output          id_stall,               
    output          ex_stall,               
    output          mem_stall,              
    output          wb_stall                
    );
    wire id_port_a_is_zero;
    wire id_port_b_is_zero;
    wire id_ex_port_a_match;
    wire id_ex_port_b_match;
    wire id_mem_port_a_match;
    wire id_mem_port_b_match;
    wire id_wb_port_a_match;
    wire id_wb_port_b_match;
    wire id_stall_1;
    wire id_stall_2;
    wire id_forward_1;
    wire id_forward_2;
    wire id_forward_3;
    wire id_forward_4;
    wire id_forward_5;
    wire id_forward_6;
    assign id_port_a_is_zero   = (id_gpr_port_a == 5'b0);
    assign id_port_b_is_zero   = (id_gpr_port_b == 5'b0);
    assign id_ex_port_a_match  = (id_gpr_port_a == ex_gpr_wa)  & (~id_port_a_is_zero) & ex_gpr_we;
    assign id_mem_port_a_match = (id_gpr_port_a == mem_gpr_wa) & (~id_port_a_is_zero) & mem_gpr_we;
    assign id_wb_port_a_match  = (id_gpr_port_a == wb_gpr_wa)  & (~id_port_a_is_zero) & wb_gpr_we;
    assign id_ex_port_b_match  = (id_gpr_port_b == ex_gpr_wa)  & (~id_port_b_is_zero) & ex_gpr_we;
    assign id_mem_port_b_match = (id_gpr_port_b == mem_gpr_wa) & (~id_port_b_is_zero) & mem_gpr_we;
    assign id_wb_port_b_match  = (id_gpr_port_b == wb_gpr_wa)  & (~id_port_b_is_zero) & wb_gpr_we;
    assign id_stall_1          = id_ex_port_a_match & ex_data_read;
    assign id_stall_2          = id_ex_port_b_match & ex_data_read;
    assign id_forward_1        = id_ex_port_a_match & ~ex_data_read;
    assign id_forward_2        = id_ex_port_b_match & ~ex_data_read;
    assign id_forward_3        = id_mem_port_a_match;
    assign id_forward_4        = id_mem_port_b_match;
    assign id_forward_5        = id_wb_port_a_match;
    assign id_forward_6        = id_wb_port_b_match;
    assign wb_stall  = mem_stall;                                                   
    assign mem_stall = mem_exception_stall | mem_request_stall;
    assign ex_stall  = ex_exception_stall  | ex_exu_stall | mem_stall;
    assign id_stall  = id_exception_stall  | id_stall_1 | id_stall_2 | ex_stall ;
    assign if_stall  = if_exception_stall  | if_mem_request_stall | id_stall;
    assign forward_port_a_select = (id_forward_1) ? 2'b01 : ((id_forward_3) ? 2'b10 : ((id_forward_5) ? 2'b11 : 2'b00));
    assign forward_port_b_select = (id_forward_2) ? 2'b01 : ((id_forward_4) ? 2'b10 : ((id_forward_6) ? 2'b11 : 2'b00));
endmodule