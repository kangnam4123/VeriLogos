module pci_serr_crit
(
    serr_out,
    non_critical_par_in,
    pci_par_in,
    serr_check_in
);
output  serr_out ;
input   non_critical_par_in,
        pci_par_in,
        serr_check_in ;
assign serr_out = ~(serr_check_in && ( non_critical_par_in ^ pci_par_in )) ;
endmodule