module pci_mas_ad_load_crit
(
    ad_load_out,
    ad_load_in,
    ad_load_on_grant_in,
    pci_gnt_in
);
output ad_load_out ;
input  ad_load_in,
       ad_load_on_grant_in,
       pci_gnt_in ;
assign ad_load_out = ad_load_in || ( ad_load_on_grant_in && !pci_gnt_in ) ;
endmodule