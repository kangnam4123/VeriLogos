module pci_target32_stop_crit
(
    stop_w,
    stop_w_frm,
    stop_w_frm_irdy,
    pci_frame_in,
    pci_irdy_in,
    pci_stop_out
);
input       stop_w ;			
input       stop_w_frm ;		
input       stop_w_frm_irdy ;	
input       pci_frame_in ;		
input		pci_irdy_in ;		
output		pci_stop_out ;		
assign 	pci_stop_out = ~(stop_w || (stop_w_frm && ~pci_frame_in) || (stop_w_frm_irdy && ~pci_frame_in && ~pci_irdy_in)) ;
endmodule