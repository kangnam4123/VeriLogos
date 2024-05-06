module pci_frame_load_crit
(
    pci_frame_load_out,
    sm_data_phases_in,
    frame_load_slow_in,
    pci_trdy_in,
    pci_stop_in
) ;
output  pci_frame_load_out ;
input   sm_data_phases_in,
        frame_load_slow_in,
        pci_trdy_in,
        pci_stop_in ;
assign pci_frame_load_out = frame_load_slow_in || sm_data_phases_in && (~(pci_trdy_in && pci_stop_in)) ;
endmodule