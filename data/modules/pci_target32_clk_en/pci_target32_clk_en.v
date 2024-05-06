module pci_target32_clk_en
(
    addr_phase,
    config_access,
    addr_claim_in,
    pci_frame_in,
    state_wait,
    state_transfere,
    state_default,
    clk_enable
);
input           addr_phase ;			
input           config_access ;			
input           addr_claim_in ;			
input           pci_frame_in ;			
input			state_wait ;			
input 			state_transfere ;		
input			state_default ;			
output			clk_enable ;			
wire s_idle_clk_en	=	((addr_phase && config_access) ||
						(addr_phase && ~config_access && addr_claim_in)) ;
wire s_wait_clk_en	=	(state_wait || state_default) ;
wire s_tran_clk_en	=	(state_transfere && pci_frame_in) ;
assign clk_enable	=	(s_idle_clk_en || s_wait_clk_en || s_tran_clk_en) ;
endmodule