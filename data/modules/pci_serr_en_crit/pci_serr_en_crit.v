module pci_serr_en_crit
(
    serr_en_out,
    non_critical_par_in,
    pci_par_in,
    serr_generate_in
);
output  serr_en_out ;
input   non_critical_par_in,
        pci_par_in,
        serr_generate_in ;
assign serr_en_out = serr_generate_in && ( non_critical_par_in ^ pci_par_in ) ;
endmodule