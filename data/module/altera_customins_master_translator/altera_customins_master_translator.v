module altera_customins_master_translator 
#(
    parameter SHARED_COMB_AND_MULTI = 0
)
(
    input  wire [31:0] ci_slave_dataa,          
    input  wire [31:0] ci_slave_datab,          
    output wire [31:0] ci_slave_result,         
    input  wire [7:0]  ci_slave_n,              
    input  wire        ci_slave_readra,         
    input  wire        ci_slave_readrb,         
    input  wire        ci_slave_writerc,        
    input  wire [4:0]  ci_slave_a,              
    input  wire [4:0]  ci_slave_b,              
    input  wire [4:0]  ci_slave_c,              
    input  wire [31:0] ci_slave_ipending,       
    input  wire        ci_slave_estatus,        
    input  wire        ci_slave_multi_clk,      
    input  wire        ci_slave_multi_reset,    
    input  wire        ci_slave_multi_clken,    
    input  wire        ci_slave_multi_start,    
    output wire        ci_slave_multi_done,     
    input  wire [31:0] ci_slave_multi_dataa,    
    input  wire [31:0] ci_slave_multi_datab,    
    output wire [31:0] ci_slave_multi_result,   
    input  wire [7:0]  ci_slave_multi_n,        
    input  wire        ci_slave_multi_readra,   
    input  wire        ci_slave_multi_readrb,   
    input  wire        ci_slave_multi_writerc,  
    input  wire [4:0]  ci_slave_multi_a,        
    input  wire [4:0]  ci_slave_multi_b,        
    input  wire [4:0]  ci_slave_multi_c,        
    output wire [31:0] comb_ci_master_dataa,    
    output wire [31:0] comb_ci_master_datab,    
    input  wire [31:0] comb_ci_master_result,   
    output wire [7:0]  comb_ci_master_n,        
    output wire        comb_ci_master_readra,   
    output wire        comb_ci_master_readrb,   
    output wire        comb_ci_master_writerc,  
    output wire [4:0]  comb_ci_master_a,        
    output wire [4:0]  comb_ci_master_b,        
    output wire [4:0]  comb_ci_master_c,        
    output wire [31:0] comb_ci_master_ipending, 
    output wire        comb_ci_master_estatus,  
    output wire        multi_ci_master_clk,     
    output wire        multi_ci_master_reset,   
    output wire        multi_ci_master_clken,   
    output wire        multi_ci_master_start,   
    input  wire        multi_ci_master_done,    
    output wire [31:0] multi_ci_master_dataa,   
    output wire [31:0] multi_ci_master_datab,   
    input  wire [31:0] multi_ci_master_result,  
    output wire [7:0]  multi_ci_master_n,       
    output wire        multi_ci_master_readra,  
    output wire        multi_ci_master_readrb,  
    output wire        multi_ci_master_writerc, 
    output wire [4:0]  multi_ci_master_a,       
    output wire [4:0]  multi_ci_master_b,       
    output wire [4:0]  multi_ci_master_c        
	);
    assign comb_ci_master_dataa   = ci_slave_dataa;
    assign comb_ci_master_datab   = ci_slave_datab;
    assign comb_ci_master_n       = ci_slave_n;
    assign comb_ci_master_a       = ci_slave_a;
    assign comb_ci_master_b       = ci_slave_b;
    assign comb_ci_master_c       = ci_slave_c;
    assign comb_ci_master_readra  = ci_slave_readra;
    assign comb_ci_master_readrb  = ci_slave_readrb;
    assign comb_ci_master_writerc = ci_slave_writerc;
    assign comb_ci_master_ipending = ci_slave_ipending;
    assign comb_ci_master_estatus  = ci_slave_estatus;
    assign multi_ci_master_clk   = ci_slave_multi_clk;
    assign multi_ci_master_reset = ci_slave_multi_reset;
    assign multi_ci_master_clken = ci_slave_multi_clken;
    assign multi_ci_master_start = ci_slave_multi_start;
    assign ci_slave_multi_done   = multi_ci_master_done;
    generate if (SHARED_COMB_AND_MULTI == 0) begin
        assign multi_ci_master_dataa   = ci_slave_multi_dataa;
        assign multi_ci_master_datab   = ci_slave_multi_datab;
        assign multi_ci_master_n       = ci_slave_multi_n;
        assign multi_ci_master_a       = ci_slave_multi_a;
        assign multi_ci_master_b       = ci_slave_multi_b;
        assign multi_ci_master_c       = ci_slave_multi_c;
        assign multi_ci_master_readra  = ci_slave_multi_readra;
        assign multi_ci_master_readrb  = ci_slave_multi_readrb;
        assign multi_ci_master_writerc = ci_slave_multi_writerc;
        assign ci_slave_result         = comb_ci_master_result;
        assign ci_slave_multi_result   = multi_ci_master_result;
    end else begin
	    assign multi_ci_master_dataa   = ci_slave_dataa;
	    assign multi_ci_master_datab   = ci_slave_datab;
        assign multi_ci_master_n       = ci_slave_n;
        assign multi_ci_master_a       = ci_slave_a;
        assign multi_ci_master_b       = ci_slave_b;
        assign multi_ci_master_c       = ci_slave_c;
        assign multi_ci_master_readra  = ci_slave_readra;
        assign multi_ci_master_readrb  = ci_slave_readrb;
        assign multi_ci_master_writerc = ci_slave_writerc;
        assign ci_slave_result = ci_slave_multi_done ? multi_ci_master_result :
                                    comb_ci_master_result;
    end
    endgenerate
endmodule