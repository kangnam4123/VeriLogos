module ada_idex_stage(
    input               clk,                    
    input               rst,                    
    input       [4:0]   id_exu_operation,       
    input       [31:0]  id_exu_port_a,          
    input       [31:0]  id_exu_port_b,          
    input       [31:0]  id_mem_store_data,      
    input               id_mem_write,           
    input               id_mem_read,            
    input               id_mem_byte,            
    input               id_mem_halfword,        
    input               id_mem_sign_ext,        
    input               id_mem_exu_mem_select,  
    input       [4:0]   id_gpr_wa,              
    input               id_gpr_we,              
    input               id_kernel_mode,         
    input       [31:0]  id_pc_current,          
    input               id_ex_can_exc,          
    input               id_mem_can_exc,         
    input               id_flush,               
    input               id_stall,               
    input               ex_stall,               
    output  reg [4:0]   ex_exu_operation,       
    output  reg [31:0]  ex_exu_port_a,          
    output  reg [31:0]  ex_exu_port_b,          
    output  reg [31:0]  ex_mem_store_data,      
    output  reg         ex_mem_write,           
    output  reg         ex_mem_read,            
    output  reg         ex_mem_byte,            
    output  reg         ex_mem_halfword,        
    output  reg         ex_mem_sign_ext,        
    output  reg         ex_mem_exu_mem_select,  
    output  reg [4:0]   ex_gpr_wa,              
    output  reg         ex_gpr_we,              
    output  reg         ex_kernel_mode,         
    output  reg [31:0]  ex_pc_current,          
    output  reg         ex_ex_can_exc,          
    output  reg         ex_mem_can_exc          
    );
    always @(posedge clk) begin
        ex_exu_operation      <= (rst) ? 5'b0  : ((ex_stall) ? ex_exu_operation      : ((id_stall | id_flush) ? 5'b0    : id_exu_operation));
        ex_exu_port_a         <= (rst) ? 32'b0 : ((ex_stall) ? ex_exu_port_a                                            : id_exu_port_a);
        ex_exu_port_b         <= (rst) ? 32'b0 : ((ex_stall) ? ex_exu_port_b                                            : id_exu_port_b);
        ex_mem_store_data     <= (rst) ? 32'b0 : ((ex_stall) ? ex_mem_store_data                                        : id_mem_store_data);
        ex_mem_write          <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_write          : ((id_stall | id_flush) ? 1'b0    : id_mem_write));
        ex_mem_read           <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_read           : ((id_stall | id_flush) ? 1'b0    : id_mem_read));
        ex_mem_byte           <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_byte                                              : id_mem_byte);
        ex_mem_halfword       <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_halfword                                          : id_mem_halfword);
        ex_mem_sign_ext       <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_sign_ext                                          : id_mem_sign_ext);
        ex_mem_exu_mem_select <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_exu_mem_select                                    : id_mem_exu_mem_select);
        ex_gpr_wa             <= (rst) ? 5'b0  : ((ex_stall) ? ex_gpr_wa             : ((id_stall | id_flush) ? 5'b0    : id_gpr_wa));
        ex_gpr_we             <= (rst) ? 1'b0  : ((ex_stall) ? ex_gpr_we             : ((id_stall | id_flush) ? 1'b0    : id_gpr_we));
        ex_kernel_mode        <= (rst) ? 1'b0  : ((ex_stall) ? ex_kernel_mode        : ((id_stall | id_flush) ? 1'b0    : id_kernel_mode));
        ex_pc_current         <= (rst) ? 32'b0 : ((ex_stall) ? ex_pc_current                                            : id_pc_current);
        ex_ex_can_exc         <= (rst) ? 1'b0  : ((ex_stall) ? ex_ex_can_exc         : ((id_stall | id_flush) ? 1'b0    : id_ex_can_exc));
        ex_mem_can_exc        <= (rst) ? 1'b0  : ((ex_stall) ? ex_mem_can_exc        : ((id_stall | id_flush) ? 1'b0    : id_mem_can_exc));
    end
endmodule