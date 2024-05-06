module pci_conf_cyc_addr_dec
(
    ccyc_addr_in,
    ccyc_addr_out
) ;
input   [31:0]  ccyc_addr_in ;
output  [31:0]  ccyc_addr_out ;
reg     [31:11]  ccyc_addr_31_11 ;
assign ccyc_addr_out = {ccyc_addr_31_11, ccyc_addr_in[10:0]} ;
wire ccyc_type = ccyc_addr_in[0] ;
always@(ccyc_addr_in or ccyc_type)
begin
    if (ccyc_type)
        ccyc_addr_31_11 = ccyc_addr_in[31:11] ;
    else
    begin
        case (ccyc_addr_in[15:11])
            5'h00:ccyc_addr_31_11 = 21'h00_0001 ;
            5'h01:ccyc_addr_31_11 = 21'h00_0002 ;
            5'h02:ccyc_addr_31_11 = 21'h00_0004 ;
            5'h03:ccyc_addr_31_11 = 21'h00_0008 ;
            5'h04:ccyc_addr_31_11 = 21'h00_0010 ;
            5'h05:ccyc_addr_31_11 = 21'h00_0020 ;
            5'h06:ccyc_addr_31_11 = 21'h00_0040 ;
            5'h07:ccyc_addr_31_11 = 21'h00_0080 ;
            5'h08:ccyc_addr_31_11 = 21'h00_0100 ;
            5'h09:ccyc_addr_31_11 = 21'h00_0200 ;
            5'h0A:ccyc_addr_31_11 = 21'h00_0400 ;
            5'h0B:ccyc_addr_31_11 = 21'h00_0800 ;
            5'h0C:ccyc_addr_31_11 = 21'h00_1000 ;
            5'h0D:ccyc_addr_31_11 = 21'h00_2000 ;
            5'h0E:ccyc_addr_31_11 = 21'h00_4000 ;
            5'h0F:ccyc_addr_31_11 = 21'h00_8000 ;
            5'h10:ccyc_addr_31_11 = 21'h01_0000 ;
            5'h11:ccyc_addr_31_11 = 21'h02_0000 ;
            5'h12:ccyc_addr_31_11 = 21'h04_0000 ;
            5'h13:ccyc_addr_31_11 = 21'h08_0000 ;
            5'h14:ccyc_addr_31_11 = 21'h10_0000 ;
            default: ccyc_addr_31_11 = 21'h00_0000 ;
        endcase
    end
end
endmodule