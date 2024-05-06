module pci_perr_crit
(
    perr_out,
    perr_n_out,
    non_critical_par_in,
    pci_par_in,
    perr_generate_in
) ;
output  perr_out,
        perr_n_out;
input   non_critical_par_in,
        pci_par_in,
        perr_generate_in ;
assign perr_out     = (non_critical_par_in ^ pci_par_in) && perr_generate_in ;
assign perr_n_out   = ~perr_out ;
endmodule