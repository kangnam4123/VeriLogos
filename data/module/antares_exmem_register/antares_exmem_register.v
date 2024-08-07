module antares_exmem_register (
                               input             clk,                      
                               input             rst,                      
                               input [31:0]      ex_alu_result,            
                               input [31:0]      ex_mem_store_data,        
                               input [4:0]       ex_gpr_wa,                
                               input             ex_gpr_we,                
                               input             ex_mem_to_gpr_select,     
                               input             ex_mem_write,             
                               input             ex_mem_byte,              
                               input             ex_mem_halfword,          
                               input             ex_mem_data_sign_ext,     
                               input [31:0]      ex_exception_pc,
                               input             ex_movn,
                               input             ex_movz,
                               input             ex_b_is_zero,
                               input             ex_llsc,
                               input             ex_kernel_mode,
                               input             ex_is_bds,
                               input             ex_trap,
                               input             ex_trap_condition,
                               input             ex_mem_exception_source,  
                               input             ex_flush,                 
                               input             ex_stall,                 
                               input             mem_stall,                
                               output reg [31:0] mem_alu_result,           
                               output reg [31:0] mem_mem_store_data,       
                               output reg [4:0]  mem_gpr_wa,               
                               output reg        mem_gpr_we,               
                               output reg        mem_mem_to_gpr_select,    
                               output reg        mem_mem_write,            
                               output reg        mem_mem_byte,             
                               output reg        mem_mem_halfword,         
                               output reg        mem_mem_data_sign_ext,    
                               output reg [31:0] mem_exception_pc,
                               output reg        mem_llsc,
                               output reg        mem_kernel_mode,
                               output reg        mem_is_bds,
                               output reg        mem_trap,
                               output reg        mem_trap_condition,
                               output reg        mem_mem_exception_source
                               );
    wire    mov_reg_write = (ex_movn &  ~ex_b_is_zero) | (ex_movz &  ex_b_is_zero);
    always @(posedge clk) begin
        mem_alu_result           <= (rst) ? 32'b0 : ((mem_stall) ? mem_alu_result                                           : ex_alu_result);
        mem_mem_store_data       <= (rst) ? 32'b0 : ((mem_stall) ? mem_mem_store_data                                       : ex_mem_store_data);
        mem_gpr_wa               <= (rst) ? 5'b0  : ((mem_stall) ? mem_gpr_wa                                               : ex_gpr_wa);
        mem_gpr_we               <= (rst) ? 1'b0  : ((mem_stall) ? mem_gpr_we               : ((ex_stall | ex_flush) ? 1'b0 : ((ex_movz | ex_movn) ? mov_reg_write : ex_gpr_we)));
        mem_mem_to_gpr_select    <= (rst) ? 1'b0  : ((mem_stall) ? mem_mem_to_gpr_select    : ((ex_stall | ex_flush) ? 1'b0 : ex_mem_to_gpr_select));     
        mem_mem_write            <= (rst) ? 1'b0  : ((mem_stall) ? mem_mem_write            : ((ex_stall | ex_flush) ? 1'b0 : ex_mem_write));
        mem_mem_byte             <= (rst) ? 1'b0  : ((mem_stall) ? mem_mem_byte                                             : ex_mem_byte);
        mem_mem_halfword         <= (rst) ? 1'b0  : ((mem_stall) ? mem_mem_halfword                                         : ex_mem_halfword);
        mem_mem_data_sign_ext    <= (rst) ? 1'b0  : ((mem_stall) ? mem_mem_data_sign_ext                                    : ex_mem_data_sign_ext);
        mem_exception_pc         <= (rst) ? 32'b0 : ((mem_stall) ? mem_exception_pc                                         : ex_exception_pc);
        mem_llsc                 <= (rst) ? 1'b0  : ((mem_stall) ? mem_llsc                                                 : ex_llsc);
        mem_kernel_mode          <= (rst) ? 1'b0  : ((mem_stall) ? mem_kernel_mode                                          : ex_kernel_mode);
        mem_is_bds               <= (rst) ? 1'b0  : ((mem_stall) ? mem_is_bds                                               : ex_is_bds);
        mem_trap                 <= (rst) ? 1'b0  : ((mem_stall) ? mem_trap                 : ((ex_stall | ex_flush) ? 1'b0 : ex_trap));
        mem_trap_condition       <= (rst) ? 1'b0  : ((mem_stall) ? mem_trap_condition                                       : ex_trap_condition);
        mem_mem_exception_source <= (rst) ? 1'b0  : ((mem_stall) ? mem_mem_exception_source : ((ex_stall | ex_flush) ? 1'b0 : ex_mem_exception_source));
    end 
endmodule