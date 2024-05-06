module pci_perr_en_crit
(
    reset_in,
    clk_in,
    perr_en_out,
    perr_en_reg_out,
    non_critical_par_in,
    pci_par_in,
    perr_generate_in,
    par_err_response_in
) ;
output  perr_en_out,
        perr_en_reg_out ;
input   reset_in,
        clk_in,
        non_critical_par_in,
        pci_par_in,
        perr_generate_in,
        par_err_response_in ;
wire perr = par_err_response_in && perr_generate_in && ( non_critical_par_in ^ pci_par_in ) ;
reg perr_en_reg_out ;
always@(posedge reset_in or posedge clk_in)
begin
    if ( reset_in )
        perr_en_reg_out <= #1 1'b0 ;
    else
        perr_en_reg_out <= #1 perr ;
end
assign perr_en_out = perr || perr_en_reg_out ;
endmodule