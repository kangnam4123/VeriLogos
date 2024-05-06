module pci_irdy_out_crit
(
    pci_irdy_out,
    irdy_slow_in,
    pci_frame_out_in,
    pci_trdy_in,
    pci_stop_in
) ;
output  pci_irdy_out ;
input   irdy_slow_in,
        pci_frame_out_in,
        pci_trdy_in,
        pci_stop_in ;
assign pci_irdy_out = irdy_slow_in || (pci_frame_out_in && ~(pci_trdy_in && pci_stop_in)) ;
endmodule