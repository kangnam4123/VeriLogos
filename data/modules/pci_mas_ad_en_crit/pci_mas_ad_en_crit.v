module pci_mas_ad_en_crit
(
    pci_ad_en_out,
    ad_en_slow_in,
    ad_en_on_grant_in,
    pci_gnt_in
) ;
output pci_ad_en_out ;
input  ad_en_slow_in,
       ad_en_on_grant_in,
       pci_gnt_in ;
assign pci_ad_en_out = ad_en_slow_in || (ad_en_on_grant_in && !pci_gnt_in) ;
endmodule