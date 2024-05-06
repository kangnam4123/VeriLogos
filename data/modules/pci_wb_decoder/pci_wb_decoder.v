module pci_wb_decoder (hit, addr_out, addr_in, base_addr, mask_addr, tran_addr, at_en) ;
parameter		decode_len     = 12 ;
output	hit ;
output	[31:0]	addr_out ;
input	[31:0]	addr_in ;
input	[31:(32-decode_len)]	base_addr ;
input	[31:(32-decode_len)]	mask_addr ;
input	[31:(32-decode_len)]	tran_addr ;
input	at_en ;
wire	img_en ;
wire	[31:(32-decode_len)]	addr_in_compare ;
wire	[31:(32-decode_len)]	base_addr_compare ;
assign addr_in_compare = (addr_in[31:(32-decode_len)] & mask_addr) ;
assign base_addr_compare = (base_addr & mask_addr) ;
assign img_en = mask_addr[31] ;
assign hit = { 1'b1, addr_in_compare } == { img_en, base_addr_compare } ;
`ifdef ADDR_TRAN_IMPL
    wire	[31:(32-decode_len)] addr_in_combine ;
    reg		[31:(32-decode_len)] tran_addr_combine ;
    assign addr_in_combine = (addr_in[31:(32-decode_len)] & ~mask_addr) ;
    always@(at_en or tran_addr or mask_addr or addr_in)
	begin
	    if (at_en)
			begin
				tran_addr_combine <= (tran_addr & mask_addr) ;
    		end
    	else
			begin
				tran_addr_combine <= (addr_in[31:(32-decode_len)] & mask_addr) ;
			end
	end
    assign addr_out[31:(32-decode_len)] = addr_in_combine | tran_addr_combine ;
    assign addr_out[(31-decode_len):0] = addr_in [(31-decode_len):0] ;
`else
    assign addr_out = addr_in ;
`endif
endmodule