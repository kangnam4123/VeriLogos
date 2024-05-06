module pci_io_mux_ad_en_crit
(
    ad_en_in,
    pci_frame_in,
    pci_trdy_in,
    pci_stop_in,
    ad_en_out
);
input  ad_en_in,
       pci_frame_in,
       pci_trdy_in,
       pci_stop_in ;
output ad_en_out ;
assign ad_en_out = ad_en_in && ( ~pci_frame_in || (pci_trdy_in && pci_stop_in) ) ;
endmodule