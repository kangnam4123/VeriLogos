module pci_frame_en_crit
(
    pci_frame_en_out,
    frame_en_slow_in,
    frame_en_keep_in,
    pci_stop_in,
    pci_trdy_in
) ;
output  pci_frame_en_out ;
input   frame_en_slow_in,
        frame_en_keep_in,
        pci_stop_in,
        pci_trdy_in ;
assign pci_frame_en_out = frame_en_slow_in || frame_en_keep_in && pci_stop_in && pci_trdy_in ;
endmodule