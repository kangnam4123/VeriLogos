module pci_frame_crit
(
    pci_frame_out,
    force_frame_in,
    slow_frame_in,
    pci_stop_in
) ;
output  pci_frame_out ;
input   force_frame_in,
        slow_frame_in,
        pci_stop_in ;
assign  pci_frame_out   = force_frame_in && (slow_frame_in || ~pci_stop_in) ;
endmodule