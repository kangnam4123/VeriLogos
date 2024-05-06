module pci_io_mux_ad_load_crit
(
    load_in,
    load_on_transfer_in,
    pci_irdy_in,
    pci_trdy_in,
    load_out
);
input  load_in,
       load_on_transfer_in,
       pci_irdy_in,
       pci_trdy_in ;
output load_out ;
assign load_out = load_in || (load_on_transfer_in && ~pci_irdy_in && ~pci_trdy_in) ;
endmodule