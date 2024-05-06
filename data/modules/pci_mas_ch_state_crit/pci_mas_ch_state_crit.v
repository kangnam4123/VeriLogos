module pci_mas_ch_state_crit
(
    change_state_out,
    ch_state_med_in,
    sm_data_phases_in,
    pci_trdy_in,
    pci_stop_in
) ;
output  change_state_out ;
input   ch_state_med_in,
        sm_data_phases_in,
        pci_trdy_in,
        pci_stop_in ;
assign change_state_out = ch_state_med_in || sm_data_phases_in && (~(pci_trdy_in && pci_stop_in)) ;
endmodule