module pci_cbe_en_crit
(
    pci_cbe_en_out,
    cbe_en_slow_in,
    cbe_en_keep_in,
    pci_stop_in,
    pci_trdy_in
) ;
output  pci_cbe_en_out ;
input   cbe_en_slow_in,
        cbe_en_keep_in,
        pci_stop_in,
        pci_trdy_in ;
assign pci_cbe_en_out = cbe_en_slow_in || cbe_en_keep_in && pci_stop_in && pci_trdy_in ;
endmodule