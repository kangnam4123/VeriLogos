module pci_target32_devs_crit
(
    devs_w,
    devs_w_frm,
    devs_w_frm_irdy,
    pci_frame_in,
    pci_irdy_in,
    pci_devsel_out
);
input       devs_w ;			
input       devs_w_frm ;		
input       devs_w_frm_irdy ;	
input       pci_frame_in ;		
input		pci_irdy_in ;		
output		pci_devsel_out ;	
assign 	pci_devsel_out = ~(devs_w || (devs_w_frm && ~pci_frame_in) || (devs_w_frm_irdy && ~pci_frame_in && pci_irdy_in)) ;
endmodule