module pci_target32_trdy_crit
(
    trdy_w,
    trdy_w_frm,
    trdy_w_frm_irdy,
    pci_frame_in,
    pci_irdy_in,
    pci_trdy_out
);
input       trdy_w ;			
input       trdy_w_frm ;		
input       trdy_w_frm_irdy ;	
input       pci_frame_in ;		
input		pci_irdy_in ;		
output		pci_trdy_out ;		
assign 	pci_trdy_out = ~(trdy_w || (trdy_w_frm && ~pci_frame_in) || (trdy_w_frm_irdy && ~pci_frame_in && pci_irdy_in)) ;
endmodule