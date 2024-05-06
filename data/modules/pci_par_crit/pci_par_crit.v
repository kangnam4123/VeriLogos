module pci_par_crit
(
    par_out,
    par_out_in,
    pci_cbe_en_in,
    data_par_in,
    pci_cbe_in
) ;
output par_out ;
input   par_out_in,
        pci_cbe_en_in,
        data_par_in ;
input   [3:0] pci_cbe_in ;
assign par_out = pci_cbe_en_in ? par_out_in : ( pci_cbe_in[3] ^ pci_cbe_in[2] ^ pci_cbe_in[1] ^ pci_cbe_in[0] ^ data_par_in) ;
endmodule